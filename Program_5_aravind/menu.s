.global menu
.extern printf
.section .data

menu_prompt:
    .asciz "\nCalculator App\n1 - Add\n2 - Subtract\n3 - Multiply\n4 - Divide\n5 - Exit\n"
    @ String used as a menu prompt for the calculator

.section .text

menu:
    push {lr}     				@ Save the link register onto the stack
    ldr r0, =menu_prompt			@ Load the addr of 'menu_prompt' into register r0
    bl printf     				@ Call printf to display the menu prompt
    pop {lr}      				@ Pop out the link register from the stack
    bx lr         				@ Return from the function, branching back to the caller

.section .note.GNU-stack,"",%progbits

