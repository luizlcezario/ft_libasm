#include "libasm.h"

#include <iostream>
#include <vector>
#include <string>
#include <utility>
#include <unistd.h>
#include <assert.h>
#include "colors.hpp"

typedef std::pair<bool, std::string> TestParameter;

typedef std::vector<TestParameter> TestCases;

TestCases ft_strlen_test_cases;

TestCases ft_write_test_cases;

TestCases ft_read_test_cases;

std::string assertEqual(bool exp, std::string msg) {
	if (exp) {
		std::cout << GREEN << "OK " << RESET;
		return "";
	} else {
		std::cout << RED << "KO " << RESET;
		return msg;
	}
}

bool testIO(std::string msg, bool isRead) {
	int fd[2];
	if (pipe(fd) == - 1){
		std::cerr << "Error: pipe failed" << std::endl;
		return false;
	}
	if (isRead) 
		int ret = write(fd[1], msg.c_str(), msg.size());
	else
		int ret = ft_write(fd[1], msg.c_str(), msg.size());
	
	close(fd[1]);
	char buffer[msg.size() + 1];
	int len = 0;
	if (isRead)
		len = ft_read(fd[0], buffer, msg.size());
	else 
		len = read(fd[0], buffer, msg.size());
	buffer[len] = '\0';
	close(fd[0]);
	return len == msg.size() && msg == std::string(buffer);
}


void test_ft_strlen() {
	ft_strlen_test_cases.push_back({ft_strlen("Hello, World!") == 13, "ft_strlen('Hello, World!') == 13"});
	ft_strlen_test_cases.push_back({ ft_strlen("") == 0, "ft_strlen('') == 1" });
	ft_strlen_test_cases.push_back({ ft_strlen("Hello, World!\n\t\0") == 15, "ft_strlen('Hello, World!\\n\\t\\0') == 15" });
	ft_strlen_test_cases.push_back({ ft_strlen("Hello, World!\0\0") == 13, "ft_strlen('Hello, World!\\0\\0') == 13" });
}

void test_ft_write() {
	ft_write_test_cases.push_back({testIO("Hello, World!", false), "testWrite('Hello, World!')"});
	ft_write_test_cases.push_back({testIO("Hello, World!\t\t\t\nasldkalsd\n", false), "testWrite('Hello, World!\\t\\t\\t\\nasldkalsd\\n')" });
}

void test_ft_read() {
	ft_read_test_cases.push_back({testIO("Hello, World!", true), "testWrite('Hello, World!')"});
	ft_read_test_cases.push_back({testIO("Hello, World!\t\t\t\nasldkalsd\n", true), "testWrite('Hello, World!\\t\\t\\t\\nasldkalsd\\n')" });
}

void runTests(TestCases testCases) {
	std::vector<std::string> printError;
    for (const auto& testCase : testCases) {
    	std::string err = assertEqual(testCase.first, testCase.second);
		if (err != "") {
			printError.push_back(err);
		}
	}
	std::cout << std::endl;
	if (printError.size() > 0) {
		std::cout << RED << "Failed tests:" << RESET << std::endl;
		for (const auto& err : printError) {
			std::cout << "\t\t" << RED << err << RESET <<  std::endl;
		}
    }
}


void setup() {
	test_ft_strlen();
	test_ft_write();
	test_ft_read();
}

int main()
{
	setup();
	std::cout << BLUE  << "ft_strlen: " ;
	runTests(ft_strlen_test_cases);
	std::cout << BLUE << "ft_write: ";
	runTests(ft_write_test_cases);
	std::cout << BLUE << "ft_read: ";
	runTests(ft_write_test_cases);

}


