#include <stdio.h>
#include <cuda_runtime_api.h>
#include <time.h>



__device__ int is_a_match(char *attempt) {
char plain_password1[] = "SA9860";
char plain_password2[] = "MU1995";
char plain_password3[] = "JJ2100";
char plain_password4[] = "SP0023";
char *s = attempt;
char *p = attempt;
char *m = attempt;
char *d = attempt;
char *d1 = plain_password1;
char *d2 = plain_password2;
char *d3 = plain_password3;
char *d4 = plain_password4;
	while(*s == *d1) {
	 if(*s == '\0')
	   {
	      printf("password: %s\n",plain_password1);
	      break;
	   }
           s++;
	   d1++;
	}
  
	while(*p == *d2) {
	  if(*p == '\0')
	    {
	      printf("password: %s\n",plain_password2);
	       break;
	    }
	    p++;
	    d2++;
	  }

        while(*m == *d3) {
          if(*m == '\0')
             {
               printf("password: %s\n",plain_password3);
                break;
             }
          m++;
          d3++;
           }
       while(*d == *d4) {
          if(*d == '\0')
             {
              printf("password: %s\n",plain_password4);
              return 1;
             }
             d++;
             d4++;
            }
          return 0;
}
__global__ void kernel() {
char i1,i2,i3,i4;//variables
char password[7];
password[6] = '\0';
//block id threrad id initilizedthreadidx
int i = blockIdx.x+65;
int j = threadIdx.x+65;
char firstmatch = i;
char secondmatch = j;
password[0] = firstmatch;
password[1] = secondmatch;


		for(i1='0'; i1<='9'; i1++){
	           for(i2='0'; i2<='9'; i2++){
			for(i3='0'; i3<='9'; i3++){
                          for(i4='0'; i4<='9'; i4++){
				password[2] = i1;
				password[3] = i2;
				password[4] = i3;
				password[5] = i4;
			    if(is_a_match(password)) {
				}
			    else {
				//printf("tried: %s\n", password);
				}


				}
			}
		}
	}
}
//time difference
	int time_difference(struct timespec *start,
	struct timespec *finish,
	long long int *difference) {
	long long int ds = finish->tv_sec - start->tv_sec;
	long long int dn = finish->tv_nsec - start->tv_nsec;
	if(dn < 0 ) {
	ds--;
	dn += 1000000000;
	}
	*difference = ds * 1000000000 + dn;
	return !(*difference > 0);
}
int main() {
	struct timespec start, finish;
	long long int time_elapsed;
	clock_gettime(CLOCK_MONOTONIC, &start);
	//kernal function that determine block and threads to use
	kernel <<<26,26>>>();
	cudaThreadSynchronize();
	clock_gettime(CLOCK_MONOTONIC, &finish);
	time_difference(&start, &finish, &time_elapsed);
	printf("Time elapsed was %lldns or %0.9lfs\n", time_elapsed, (time_elapsed/1.0e9));
	return 0;
}
