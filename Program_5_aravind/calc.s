.global main

.extern menu
.extern addOp
.extern subOp

.extern printf
.extern scanf

.section .data
.align 4

prompt_choice: .asciz "\nEnter Choice > "               @ Prompt asking user to enter a choice
exit_msg: .asciz "Application Exit!\n"                  @ Message displayed when exiting the program
invalid_input: .asciz "Invalid choice, try again.\n"    @ Message displayed for invalid input
format_int: .asciz "%d"                                 @ Format specifier for scanning integer input
format_str: .asciz "%*s"                                @ Format specifier for any non-numerical input

.section .bss
choice: .space 4            @ Allocate 4 bytes for storing user choice

.section .text

main:
    push {lr}               @ Save the link register onto the stack

main_loop:
    bl menu                 @ Call the menu function to display options

    ldr r0, =prompt_choice  @ Load the address of the prompt message into r0
    bl printf               @ Call printf to display the prompt

    ldr r0, =format_int     @ Load address of format specifier
    ldr r1, =choice         @ Load address of choice

    bl scanf                @ Call scanf to read user input

    mov r2, r0		    @ Load r0 into r2 to validate input
    cmp r2, #0		    @ Compare input with 0
    beq clear_buffer	    @ Branch to clear_buffer

    ldr r0, =choice         @ Load address of choice
    ldr r0, [r0]            @ Dereference to get the actual choice value

    @ Branching out, based on user's choice

    cmp r0, #1              @ Compare input with 1
    beq add                 @ If equal, branch to add

    cmp r0, #2              @ Compare input with 2
    beq subtract            @ If equal, branch to subtract

    cmp r0, #5              @ Compare input with 5
    beq exit_program        @ If equal, branch to exit_program

    @ Handles the issue with invalid inputs

    ldr r0, =invalid_input  @ Load the address of the invalid input into r0
    bl printf		    @ Call printf to display the message
    b main_loop		    @ Go back to the main loop

clear_buffer:
    ldr r0, =format_str	    @ Load address of format specifier
    bl scanf		    @ Call scanf to read user input
    ldr r0, =invalid_input  @ Load the address of the invalid input into r0
    bl printf		    @ Call printf to display the message
    b main_loop		    @ Go back to the main loop

add:
    bl addOp                @ Call addOp function
    b main_loop             @ Go back to the main loop

subtract:
    bl subOp                @ Call subOp function
    b main_loop             @ Go back to the main loop

exit_program:
    ldr r0, =exit_msg       @ Load address of exit message
    bl printf               @ Call printf to display exit message
    pop {lr}                @ Restore the link register
    bx lr                   @ Return to caller

.section .note.GNU-stack,"",%progbits
