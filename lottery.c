/*
https://01siddharth.blogspot.com/2018/04/adding-system-call-in-xv6-os.html
*/

#include "types.h"
#include "stat.h"
#include "user.h"
#include "param.h"


#define TIME        300
#define N           100000
#define QTD_PROC    5


void process_test(int id, int tickets);


int main(void) {

    process_test(0, 10);
    process_test(1, 100);
    process_test(2, 1000);
    process_test(3, 5000);

//    printf(0, "FINISHED!!\n");

    exit();
}


void process_test(int id, int tickets){

    int i = 0;

    if (fork(tickets)) {
        while (i < N) {
            i++;
//            if ((i % 50) == 0) printf(1, "ID: %d | TICKETS: %d\n", id, tickets);
        }
    }
}
