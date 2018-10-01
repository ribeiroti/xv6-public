/*
https://01siddharth.blogspot.com/2018/04/adding-system-call-in-xv6-os.html
*/

#include "types.h"
#include "stat.h"
#include "user.h"

#define QTD_PROC    10

void process_test(int tickets);

int main() {


    for (int i = 1; i <= QTD_PROC; i++) {
        process_test(i*100);
    }

    //Bug: Se não criar  este processo o último do laço fica sempre como zombie.
    process_test(1); // Para não bugar.

    exit();
}

void process_test(int tickets){

    int i = 0;

    if (fork(tickets)) {

        // LOOP INFINITO INCREMENTANDO VARIÁVEL PARA NÃO OTIMIZAR
        while (1) i++;

    }
}
