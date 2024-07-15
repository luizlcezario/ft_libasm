#include "libasm.h"

#include <iostream>
#include <vector>
#include <string>
#include <utility>
#include <unistd.h>
#include <assert.h>
#include <string.h>
#include "colors.hpp"

typedef std::pair<bool, std::string> TestParameter;

typedef std::vector<TestParameter> TestCases;

TestCases testCases;

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

bool testStrCpy(const char *msg) {
	char buffer[strlen(msg) + 1];
	char *res = ft_strcpy(buffer, msg);
	return std::string(msg) == std::string(buffer) && res == buffer;
}


void setup_ft_strlen() {
	testCases.push_back({ft_strlen("Hello, World!") == 13, "ft_strlen('Hello, World!') == 13"});
	testCases.push_back({ ft_strlen("") == 0, "ft_strlen('') == 0" });
	testCases.push_back({ ft_strlen(NULL) == 0, "ft_strlen(NULL) == 0" });
	testCases.push_back({ ft_strlen("Hello, World!\n\t\0") == 15, "ft_strlen('Hello, World!\\n\\t\\0') == 15" });
	testCases.push_back({ ft_strlen("Hello, World!\0\0") == 13, "ft_strlen('Hello, World!\\0\\0') == 13" });
}

void setup_ft_write() {
	testCases.push_back({testIO("Hello, World!", false), "testIO('Hello, World!', false)"});
	testCases.push_back({testIO("Hello, World!\t\t\t\nasldkalsd\n", false), "testIO('Hello, World!\\t\\t\\t\\nasldkalsd\\n', false)" });
	std::cout << ft_read(-1, NULL, 1) << errno << std::endl;
	testCases.push_back({ft_read(-1, NULL, 1) == -1, "ft_read(-1, NULL, 1) == -1" });
}

void setup_ft_read() {
	testCases.push_back({testIO("Hello, World!", true), "testIO('Hello, World!', true)"});
	testCases.push_back({testIO("Hello, World!\t\t\t\nasldkalsd\n", true), "testIO('Hello, World!\\t\\t\\t\\nasldkalsd\\n', true)" });
}

void setup_ft_strcpy() {
	testCases.push_back({testStrCpy("Hello, World!"), "testStrCpy('Hello, World!')" });
	testCases.push_back({testStrCpy("Hello, World!\n\t\0"), "testStrCpy('Hello, World!\\n\\t\\0')" });
	testCases.push_back({testStrCpy(""), "testStrCpy('')" });
	testCases.push_back({ft_strcpy((char *)"test", NULL) == NULL, "ft_strcpy('test, NULL) == NULL" });
	testCases.push_back({ft_strcpy(NULL, NULL) == NULL, "ft_strcpy(NULL, NULL) == NULL" });
	testCases.push_back({ft_strcpy(NULL, "test") == NULL, "ft_strcpy(NULL, 'test') == NULL" });
}

void runTests() {
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
	testCases.clear();
}

int main()
{
	std::cout << BLUE  << "ft_strlen: ";
	setup_ft_strlen();
	runTests();
	std::cout << BLUE << "ft_write: ";
	setup_ft_write();
	runTests();
	std::cout << BLUE << "ft_read: ";
	setup_ft_read();
	runTests();
	std::cout << BLUE << "ft_strcpy: ";
	setup_ft_strcpy();
	runTests();
	// std::cout << BLUE << "ft_strdup: ";

}


