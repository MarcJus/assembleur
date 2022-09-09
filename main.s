.global main
.extern strlen
.extern exit_success
.extern exit_failure

.section .data
sockaddr_in:
    @ socket_fd: .byte 0
    .hword 2 @ sa_family_t : unsigned short -> 2
    .hword 54795 @ sa_port : unsigned short -> 2
    .word 16777343 @ sin_addr : unsigned int -> 4
    .quad 0 @ sin_zero -> 8

socket_fd:
    .word 0

welcome_message:
    .asciz "Hello World !\n"

.section .text

_start:
    mov r7, #0x119 @ socket
    mov r0, #2 @ AF_INET
    mov r1, #1 @ SOCK_STREAM
    mov r2, #0 @ protocol
    svc #0 @ syscall
    cmp r0, #0
    blt exit_failure 
    
    ldr r1, =socket_fd
    str r0, [r1] @ sauvegarde du socket_fd

# r0 -> socket_fd
connect_to_socket:
    mov r7, #283 @ connect
    ldr r1, =sockaddr_in
    mov r2, #16 @ sizeof sockaddr_in
    svc #0
    cmp r0, #0
    bne exit_failure

send_welcome_message:
    mov r7, #289 @ send
    ldr r1, =socket_fd
    ldr r0, [r1]
    push {r0}
    ldr r1, =welcome_message
    mov r0, r1
    bl strlen

    mov r2, r0
    mov r3, #0
    pop {r0}
    swi #0
    
    cmp r0, #0
    blt exit_failure
    b exit_success

recept_message:
    mov r7, #291 @ recv
    
