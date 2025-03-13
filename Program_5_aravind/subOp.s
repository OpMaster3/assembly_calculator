.global subOp

.extern printf
.extern scanf

.section .data

prompt_operand1: .asciz "Enter Operand 1 > "            @ Prompt asking the user to input the first operand
prompt_operand2: .asciz "Enter Operand 2 > "            @ Prompt asking the user to input the second operand

format_num: .asciz "%lf"                                @ Format specifier for scanning an integer input
format_result: .asciz "%0.0lf%.2lf - %.2lf = %.2lf\n"   @ Format specifier for displaying the subtraction results

.section .text

addOp:
        push {lr}                       @ Save the link register onto the stack

        sub sp, sp, #24                 @ Allocate space for 3 doubles (8 bytes each)

        ldr r0, =prompt_operand1        @ Load address of prompt_operand1 into r0
        bl printf                       @ Call printf to display the first operand prompt

        ldr r0, =format_num             @ Load address of format specifier
        mov r1, sp                      @ Load operand1 to the address of sp
        bl scanf                        @ Call scanf to read the first operand input

        ldr r0, =prompt_operand2        @ Load address of prompt_operand2 into r0
        bl printf                       @ Call printf to display the second operand prompt

        ldr r0, =format_num             @ Load address of format specifier
        add r1, sp, #8                  @ Load operand2 to the address of sp
        bl scanf                        @ Call scanf to red the second operand input

        vldr.f64 d0, [sp]               @ Load d0 from stack
        vldr.f64 d1, [sp, #8]           @ Load d1 from stack

        vsub.f64 d2, d0, d1             @ Subtraction Operation of the two operands
        vstr.f64 d2, [sp, #16]          @ Load result into the stack

        ldr r0, =format_result          @ Load address of format_result string
        vldr.f64 d0, [sp]               @ Load operand1 form stack
        vldr.f64 d1, [sp, #8]           @ Load operand2 from stack
        vldr.f64 d2, [sp, #16]          @ Load result from stack
        bl printf                       @ Call printf to display the result of the addition

        add sp, sp, #24                 @ Restore stack to original state

        pop {lr}                        @ Restore the lin register
        bx lr                           @ Return to calc

.section .note.GNU-stack,"",%progbits

