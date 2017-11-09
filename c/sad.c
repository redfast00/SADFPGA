#include <stdint.h>
#include <stdio.h>
#include <stdbool.h>

int main()
{

  int32_t i;
  bool tested = false;

  for(i=0; i < 1<<30; i++) {
    tested = tested || ( ((i >> 1) & 1) && ((i >> 3) & 1) && !((i >> 22) & 1));
  }
  printf("%d, %d\n", i, tested);
}

