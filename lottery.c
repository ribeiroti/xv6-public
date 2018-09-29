/*
https://01siddharth.blogspot.com/2018/04/adding-system-call-in-xv6-os.html
*/

#include "types.h"
#include "stat.h"
#include "user.h"
#include "param.h"



#define TIME        300
#define N           1
#define QTD_PROC    5


void process_test(int id, int tickets);


int main(void) {


    for (int i = 1; i <= QTD_PROC; i++) {
        process_test(i, i*i*100);
    }



    exit();
}


void process_test(int id, int tickets){

    int i = 0;

    if (fork(tickets)) {

        while (1) i++;

    }
}
