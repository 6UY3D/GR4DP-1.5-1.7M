section .text
global matmul
matmul:
    ; Inputs: rsi (matrix A), rdx (matrix B), rcx (output C), r8 (rows A), r9 (cols A), r10 (cols B)
    push rbx
    push r12
    push r13
    xor rax, rax          ; i = 0
    mov rbx, r8           ; rowsA
.outer_loop:
    cmp rax, rbx
    jge .done
    xor r11, r11          ; j = 0
.inner_loop:
    cmp r11, r10
    jge .next_row
    vxorps ymm0, ymm0, ymm0  ; sum = 0
    xor r12, r12          ; k = 0
.dot_product:
    cmp r12, r9
    jge .store
    vmovss xmm1, [rsi + rax*4 + r12*4]  ; A[i,k]
    vmovss xmm2, [rdx + r12*4 + r11*4]  ; B[k,j]
    vfmadd231ps ymm0, xmm1, xmm2        ; sum += A[i,k] * B[k,j]
    inc r12
    jmp .dot_product
.store:
    vmovss [rcx + rax*4 + r11*4], ymm0  ; C[i,j] = sum
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
