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
        process_test(i*i*10);
    }

    // TODO: Bug: Se chamar processo com um bilhete primeiro, não acontece o fork em todos.
    process_test(1);

    exit();
}


void process_test(int tickets){

    int i = 0;

    if ((fork(tickets)) != 0) {

        // LOOP INFINITO INCREMENTANDO VARIÁVEL PARA NÃO OTIMIZAR
        while (1) i++;

    }
}
