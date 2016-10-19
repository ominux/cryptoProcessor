#include <stdio.h>
#include <stdint.h>

int
main (void)
{
uint16_t x0 = 0xffff;
uint16_t x1 = 0xffff;
uint16_t x2 = 0x5e;
uint16_t x3 = 0xa6;
uint32_t result;
uint16_t result_0;
uint16_t result_1;
uint16_t result_2;
uint16_t result_3;
long i;
long j;
for (i = 0; i<=65535; i++)
{
//	printf ("i: %li\n",i);
	for (j = 0; j<=65535; j++)
	{
		x0=i;
		x1=j;
		result = x0*x1;
//  printf ("x0: %x\n size of x0: %lu \n",x0,sizeof(x0));
//  printf ("x1: %x\n size of x1: %lu \n",x1,sizeof(x1));
//  printf ("result: %x\n size of result: %lu \n",result,sizeof(result));
		result_0 = result % 0x10001;
//  printf ("result_0: %x\n",result_0);
		result_1 = result % 0x10000;
//  printf ("result_1: %x\n",result_1);
		result_2 = result / 0x10000;
//  printf ("result_2: %x\n",result_2);
		result_3 = result_1 - result_2;
//  printf ("result_3: %x\n",result_3);
		if (result_1 < result_2)
		{
			result_3 = result_3 + 1;
//	printf ("result_3: %x\n",result_3);
		}
		if (result_3 != result_0)
		{
			printf ("result_0: %x\nresult_3: %x\n",result_0,result_3);
		}
	}
}
return 0;
}
