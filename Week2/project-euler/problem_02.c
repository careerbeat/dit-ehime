#include<stdio.h>

int main(void) {
   int f[100];
   int i;
   int count = 0;
   int sum = 0;

   f[0] = 1;
   count++;
   printf("f[0] = %d\n", f[0]);
   f[1] = 2;
   printf("f[1] = %d\n", f[1]);
   count++;

   for (i = 2; f[i - 1] < 4000000; i++) {
      f[i] = f[i-2] + f[i-1];
      count++;
      printf("f[%d] = %d\n", i, f[i]);
   }

   for (i = 0; i < count; i++) {
      if ((f[i] % 2) == 0) sum += f[i];
   }

   printf("sum = %d\n", sum);

   return 0;
}