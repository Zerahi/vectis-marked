#include<iostream>

using namespace std;

extern "C" int funct();

int main() {
	cout << "The result is: " << funct() << endl;

		return 0;
}