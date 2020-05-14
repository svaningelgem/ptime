#include <iostream>
#include <iomanip>
#include <cctype>
#include <algorithm>
#include <sstream>
#include <Windows.h>


using namespace std;


// https://stackoverflow.com/questions/3418231/replace-part-of-a-string-with-another-string
std::string ReplaceString(std::string subject, const std::string& search,
                          const std::string& replace) {
  size_t pos = 0;
  while ((pos = subject.find(search, pos)) != std::string::npos) {
    subject.replace(pos, search.length( ), replace);
    pos += replace.length( );
  }
  return subject;
}


string escape_shell_argument(string in) {
  static const string single_quote = "\"";
  static const string escaped_single_quote = "\\\"";

  string quoted = ReplaceString(in, single_quote, escaped_single_quote);
  if (count_if(quoted.begin( ), quoted.end( ), [] (unsigned char c) { return std::isspace(c); }) > 0) {
    return single_quote + quoted + single_quote;
  }
  else {
    return quoted;
  }
}


void print_help( ) {
  cerr << "Syntax: ptime command [arguments ...]" << endl
    << endl
    << "ptime will run the specified command and measure the execution time" << endl
    << "(run time) in seconds, accurate to 5 millisecond or better. It is an" << endl
    << "automatic process timer, or program timer." << endl;
}


int main(int argc, const char* argv[]) {
  if (argc <= 1) {
    print_help( );
    return -1;
  }

  std::stringstream cmd_to_run;
  for (int i = 1; i < argc; i++) {
    if (i != 1) cmd_to_run << ' ';
    cmd_to_run << escape_shell_argument(argv[i]);
  }


  cout << "=== " << cmd_to_run.str() << " ===" << endl;

  timeBeginPeriod(1u);
  DWORD start_time = timeGetTime( );
  system(cmd_to_run.str().c_str());
  DWORD total_time = timeGetTime( ) - start_time;
  timeEndPeriod(1u);

  cout << "=== Execution time: " << std::fixed << std::setprecision(3) << (total_time * 0.001) << " s ===" << endl;

  return 0;
}
