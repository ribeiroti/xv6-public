/*
https://01siddharth.blogspot.com/2018/04/adding-system-call-in-xv6-os.html
*/

#include "types.h"
#include "stat.h"
#include "user.h"
#include "param.h"



#define TIME        300
#define QTD_PROC    5


void process_test(int id, int tickets);


int main(void) {

//
//    for (int i = 1; i <= QTD_PROC; i++) {
//        process_test(i, i*i*100);
//    }

//  #TODO: Bug: Se chamar processo com um bilhete primeiro, não acontece o fork em todos.

    process_test(1, 1000); // 4 - 5 %
    process_test(2, 2000); // 9 - 10 %
    process_test(3, 4000); // 19 %
    process_test(4, 6000); // 28 - 29 %
    process_test(5, 8000); // 38 %
    process_test(6, 1); // 0%


    exit();
}


void process_test(int id, int tickets){

    int i = 0;

    if (fork(tickets)) {

        while (1) i++;

    }
}
