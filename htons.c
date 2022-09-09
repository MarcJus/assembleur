#include <stdio.h>
#include <unistd.h>
#include <arpa/inet.h>

extern int strlen(char *buffer);

int main(void){
    int family = 2;
    int domain = 1;
    int protocol = 0;
    socket(family, domain, protocol);
    // printf("%d\n%d\n", htons(3030), inet_addr("127.0.0.1"));
}
