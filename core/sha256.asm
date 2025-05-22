section .text
global sha256_hash
extern SHA256
sha256_hash:
    ; Inputs: rsi (data), rdx (length), rcx (output 32-byte hash)
    push rbx
    mov rdi, rcx         ; output
    mov rcx, rdx         ; length
    call SHA256          ; Call OpenSSL SHA256
    pop rbx
    ret
