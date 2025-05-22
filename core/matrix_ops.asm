; matrix_ops.asm: Optimized matrix operations for neural networks using SIMD
section .text
global matmul
global relu

; Matrix multiplication: C = A * B
; Inputs: rsi (A), rdx (B), rcx (C), r8 (rows A), r9 (cols A), r10 (cols B)
matmul:
    push rbx
    push r12
    push r13
    xor rax, rax
    mov rbx, r8           ; rows A
.outer_loop:
    cmp rax, rbx
    jge .done
    xor r11, r11          ; col index for C
.inner_loop:
    cmp r11, r10
    jge .next_row
    vxorps ymm0, ymm0, ymm0 ; Accumulator
    xor r12, r12          ; col index for A
.dot_product:
    cmp r12, r9
    jge .store
    ; Load A[rax,r12] and B[r12,r11]
    vmovss xmm1, [rsi + rax*4 + r12*4]
    vmovss xmm2, [rdx + r12*4 + r11*4]
    vfmadd231ps ymm0, xmm1, xmm2
    inc r12
    jmp .dot_product
.store:
    vmovss [rcx + rax*4 + r11*4], ymm0
    inc r11
    jmp .inner_loop
.next_row:
    inc rax
    jmp .outer_loop
.done:
    pop r13
    pop r12
    pop rbx
    ret

; ReLU activation: output = max(0, input)
; Inputs: rsi (input/output), rdx (size)
relu:
    push rbx
    xor rax, rax
    mov rbx, rdx
    vxorps ymm0, ymm0, ymm0 ; Zero register
.loop:
    cmp rax, rbx
    jge .done
    vmovss xmm1, [rsi + rax*4]
    vmaxps xmm1, xmm1, xmm0
    vmovss [rsi + rax*4], xmm1
    inc rax
    jmp .loop
.done:
    pop rbx
    ret
