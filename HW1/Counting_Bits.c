#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

static inline int my_clz(uint32_t x) {
    int count = 0;
    for (int i = 31; i >= 0; --i) {
        if (x & (1U << i))
            break;
        count++;
    }
    return count;
}


int count_ones(uint32_t x) {
    int count = 0;
    int leading_zeros = my_clz(x);
    for (int i = 31 - leading_zeros; i >= 0; --i) {
        if (x & (1U << i))
            count++;
    }
    return count;
}

int* countBits(int n, int* returnSize) {
    *returnSize = n + 1;
    int* result = (int*)malloc((*returnSize) * sizeof(int));
    
    for (int i = 0; i <= n; ++i) {
        result[i] = count_ones(i);  
    }
    
    return result;
}

int main() {
    int n = 5;  
    int returnSize;
    int* result = countBits(n, &returnSize);
    
    for (int i = 0; i < returnSize; ++i) {
        printf("%d ", result[i]);
    }
    printf("\n");

    free(result); 
    return 0;
}
