/*
Created by lucas on 17/09/18.

https://01siddharth.blogspot.com/2018/04/adding-system-call-in-xv6-os.html
*/


#include "types.h"
#include "stat.h"
#include "user.h"
#include "param.h"

#define TIME    300
#define N       5

int i = 0;

int main(void) {
    int pid;

    while(i<N) {
        pid = fork(NTICKETS * ++i);

        if (pid) {
            while (1) {
                printf(1, ">>> pid %d tickets %d\n", pid, NTICKETS*i);
                sleep(TIME);
            }
        }

        if (fork(NTICKETS * ++i)) {
            while (1) {
                printf(1, ">>> pid %d tickets %d\n", pid, NTICKETS*i);
                sleep(TIME);
            }
        }
    }

    exit();
}
