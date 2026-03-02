import sys

A=[8,7,6,5,4,3,2,1]
p=0
r=len(A)-1

def Merge(A, p, q, r):
    n1=q-p+1
    n2=r-q
    L=[sys.maxsize]
    R=[sys.maxsize]
    for i in range(n1):
        L.insert(i,i)
        L[i]=A[p+i]
    for j in range(n2):
        R.insert(j,j)
        R[j]=A[q+1+j]
    i=0
    j=0
    for k in range(p, r+1):
        if L[i]<=R[j]:
            A[k]=L[i]
            i+=1
        else:
            A[k]=R[j]
            j+=1
    
def Merge_sort (A, p, r):
    if p<r:
        q=int((p+r)/2)
        Merge_sort(A, p, q)
        Merge_sort(A, q+1, r)
        Merge(A, p, q, r)

print(f"Nesetřízené pole: {A}")
Merge_sort(A, p, r)
print(f"Setřízené pole: {A}")