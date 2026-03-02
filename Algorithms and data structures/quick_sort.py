#Quick sort
A=[1,9,8,0,2,6,7,3]
p=0
r=len(A)-1

def partition(A, p, r):
    x=A[r]
    i=p-1
    for j in range(p, r):
        if A[j]<=x:
            i+=1
            change=A[i]
            A[i]=A[j]
            A[j]=change
    chang=A[i+1]
    A[i+1]=A[r]
    A[r]=chang
    return i+1

def quick_sort(A, p, r):
    if p<r:
        q=partition(A, p, r)
        quick_sort(A, p, q-1)
        quick_sort(A, q+1, r)
print(f"Neseřazený {A}")
quick_sort(A, p, r)
print(f"Seřazený {A}")