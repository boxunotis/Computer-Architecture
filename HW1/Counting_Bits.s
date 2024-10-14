    .data
    .text
    .globl main

main:
    li a0, 5             
    jal ra, countBits    
    li t1, 0             

print_loop:
    lw t2, 0(sp)         
    li a7, 1             
    mv a0, t2            
    ecall                

    addi sp, sp, 4      
    addi t1, t1, 1      
    li t3, 5            
    bgt t1, t3, print_done  

    j print_loop       

print_done:
    li a7, 10            
    ecall                


my_clz:
    addi sp, sp, -8      
    sw ra, 0(sp)
    sw t0, 4(sp)

    li t0, 0            
    li t1, 31           

clz_loop:
    sll t2, a0, t1       
    bnez t2, clz_done   
    addi t0, t0, 1       
    addi t1, t1, -1     
    bgez t1, clz_loop   

clz_done:
    mv a0, t0            
    lw ra, 0(sp)         
    lw t0, 4(sp)         
    addi sp, sp, 8       
    ret
    
count_ones:
    addi sp, sp, -8      
    sw ra, 0(sp)
    sw t0, 4(sp)

    li t0, 0             
    jal ra, my_clz       
    mv t1, a0            
    li t2, 31            
    sub t2, t2, t1      

ones_loop:
    sll t3, a0, t2       
    bnez t3, increment   
    j skip_increment    

increment:
    addi t0, t0, 1       

skip_increment:
    addi t2, t2, -1      
    bgez t2, ones_loop   

    mv a0, t0            
    lw ra, 0(sp)         
    lw t0, 4(sp)         
    addi sp, sp, 8       
    ret

countBits:
    addi sp, sp, -8      
    sw ra, 0(sp)
    sw t0, 4(sp)

    addi t0, a0, 1       
    slli t0, t0, 2       
    li a1, 0             
    mv a1, sp            
    add sp, sp, t0       

    li t1, 0             
count_bits_loop:
    mv a0, t1            
    jal ra, count_ones   
    sw a0, 0(a1)         

    addi a1, a1, 4       
    addi t1, t1, 1       
    bgt t1, a0, count_bits_done 

    j count_bits_loop    

count_bits_done:
    lw ra, 0(sp)         
    lw t0, 4(sp)         
    addi sp, sp, 8       
    ret
