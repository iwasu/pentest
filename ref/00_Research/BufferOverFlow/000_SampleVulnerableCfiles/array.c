#include <stdio.h>

void print_array() {
  int my_array[] = {9, 5, 11, 2, 15};
  int i;
  for (i = 0; i < 5; i++) {
    printf("my_array[%d] = %d\n", i, my_array[i]);
  }
}

int main() {
  printf("Call print_array().\n");
  print_array();
  printf("Done.\n");
  
  return 0;
}