.global exit_success
.global exit_failure
.global strlen

.section .text
@ r0 -> string pointer
strlen:
    push {r1}
    push {r2}
    eor r2, r2
@ r1 -> stores value
@ r2 -> counter
_strlen_loop:
    eor r1, r1
    ldrb r1, [r0]
    add r0, r0, #1
    @ lsr r1, r1, #24
    add r2, r2, #1
    cmp r1, #0
    bne _strlen_loop

    mov r0, r2
    pop {r2}
    pop {r1}
    bx lr

print_char:
    mov r7, 4 @ write
    mov r0, 1 @ stdout

exit_success:
    mov r7, #1 @ exit
    mov r0, #0 @ EXIT_SUCCESS
    svc #0

exit_failure:
    mov r7, #1 @ exit
    mov r0, #1 @ EXIT_FAILURE
    svc #0
