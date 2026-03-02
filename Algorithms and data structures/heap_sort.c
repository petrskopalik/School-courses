#include <stdio.h>

int paretn(int i){
    return (i-1)/2;
}

int left(int i){
    return 2*i+1;
}

int right(int i){
    return 2*i+2;
}

void Max_heapify(int A[], int i, int heapsize){
    int l=left(i);
    int r=right(i);
    int largest;
    if (l<heapsize && A[l]>A[i]){
        largest=l;
    }
    else{
        largest=i;
    }
    if (r<heapsize && A[r]>A[largest]){
        largest=r;
    }
    if (largest!=i){
        int temp=A[i];
        A[i]=A[largest];
        A[largest]=temp;
        Max_heapify(A, largest, heapsize);
    }
}

void Build_max_heap(int A[], int n, int heapsize){
    for (int i=((n/2)-1); i>=0;i-=1){
        Max_heapify(A, i, heapsize);
        heapsize-=1;
    }
}

void Heap_sort(int A[], int n){
    int heapsize=n;
    Build_max_heap(A, n, heapsize);
    for (int i=n-1; i>0; i-=1){
        int temp=A[i];
        A[i]=A[0];
        A[0]=temp;
        heapsize-=1;
        Max_heapify(A, 0, heapsize);
    }
}

int main(){

    int velikost=10;

    int A[]={12,9,8,9,7,6,7,5,3,4};
    for (int i=0; i<velikost; i+=1){
        printf("%d|", A[i]);
    }
    printf("\n");

    Heap_sort(A, (sizeof(A)/sizeof(A[0])));

    for (int i=0; i<velikost; i+=1){
        printf("%d|", A[i]);
    }
    printf("\n");


    return 0;
}