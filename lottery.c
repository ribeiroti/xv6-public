/*
Created by lucas on 17/09/18.

https://01siddharth.blogspot.com/2018/04/adding-system-call-in-xv6-os.html
*/
#include "types.h"
#include "stat.h"
#include "user.h"
#include "param.h"

#define NFORK 3
#define N     100

int m = 0;

int main(void) {
    int pid, i, j, k, l;

    while (m < NFORK) {
        if ((pid=fork(NTICKETS * ++m))) {
            printf(1, ">>> pid %d tickets %d\n", pid, NTICKETS * m);
            for (i = 0; i < N; i++) {
                for (j = 0; j < N; j++) {
                    for (k = 0; k < N; k++) {
                        for (l = 0; l < N; l++) {
                            printf(1, "");
                        }
                    }
                }
            }
        }
    }

    exit();
}
