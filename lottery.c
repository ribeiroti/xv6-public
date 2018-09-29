/*
https://01siddharth.blogspot.com/2018/04/adding-system-call-in-xv6-os.html
*/

#include "types.h"
#include "stat.h"
#include "user.h"
#include "param.h"



#define TIME        300
#define QTD_PROC    10


void process_test(int tickets);


int main() {


    for (int i = 1; i <= QTD_PROC; i++) {
        process_test(i*i*100);
    }

//  #TODO: Bug: Se chamar processo com um bilhete primeiro, não acontece o fork em todos.
    process_test(1); // 0%

    exit();
}


void process_test(int tickets){

    int i = 0;

    if (fork(tickets)) {

        // LOOP INFINITO INCREMENTANDO VARIÁVEL PARA NÃO OTIMIZAR
        while (1) i++;

    }
}
