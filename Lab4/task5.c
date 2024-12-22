#include <stdio.h>

int main(){
    int star = 1, space = 4, row = 0;
    int m_space = space, m_star = star;
    for(row;row <5;row++){
        for(m_space; m_space >= 0; m_space --){
            printf(" ");
        }
        for(m_star; m_star > 0 ; m_star --){
            printf("*");
        }
        printf("\n");
        space -= 1;
        m_space = space;
        star += 2;
        m_star += star;
    }

}