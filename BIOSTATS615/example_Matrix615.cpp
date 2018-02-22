#include "Matrix615.h" 

int main(int argc, char** argv){
   Matrix615<string> my_matrix;
   my_matrix.readFromFile(argv[1]);
   my_matrix.print();
   
   return 0;
}
