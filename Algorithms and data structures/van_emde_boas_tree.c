#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include <math.h>

// u=16. Povinné jsou metody MIN, MAX, INSERT, SUCCESSOR, print

double u = 16;

typedef struct node{
    int n;
    struct node *summary;
    struct node **cluster;
    int min;
    int max;
} node;

typedef struct veb_tree{
    node *root;
} veb_tree;

node* make_node(int n){
    node *new_node = malloc(sizeof(node));
    assert(new_node);

    new_node->n = n;
    if (n == 2){
        new_node->cluster = NULL;
        new_node->summary = NULL;
    }
    else {
        int size = (int)sqrt(n);
        
        new_node->cluster = malloc(sizeof(node*) * size);
        assert(new_node->cluster);

        for (size_t i = 0; i < size; i++){
            *(new_node->cluster + i) = make_node(size);
        }

        new_node->summary = make_node(size);
    }
    new_node->max = NULL;
    new_node->min = NULL;

    return new_node;
}

veb_tree* make_veb_tree(){
    veb_tree *new_tree = malloc(sizeof(veb_tree));
    assert(new_tree);
    new_tree->root = make_node(u);

    return new_tree;
}

int low(int x){
    return x % (int)sqrt(u);
}

int high(int x){
    return x / (int)sqrt(u);
}

int index(int x, int y){
    return x * (int)sqrt(u) + y;
}

int min(node *n){
    return n->min;
}

int max(node *n){
    return n->max;
}

void empty_tree_insert(node *n, int x){
    n->min = x;
    n->max = x;
}

void insert(node *n, int x){
    int new_value = x;
    if (n->min == NULL){
        empty_tree_insert(n, new_value);
    }
    else {
        if (x < n->min){
            int temp = n->min;
            n->min = new_value;
            new_value = temp;
        }
        if (n->n > 2){
            if (min(&(n->cluster[high(x)])) == NULL){
                insert(n->summary, high(x));
                empty_tree_insert(&(n->cluster[high(x)]), low(x));
            }
            else {
                insert(&(n->cluster[high(x)]), low(x));
            }
        }
        if (new_value > n->max){
            n->max = new_value;
        }
    }
}

int successor(node *n, int x){
    if (n->n == 2){
        if (x == 0 && n->max == 1){
            return 1;
        }
        else {
            return NULL;
        }
    }
    else if (n->min != NULL && x < n->min){
        return n->min;
    }
    else{
        int offset;
        int max_low = max(&(n->cluster[high(x)]));
        if (max_low != NULL && low(x) < max_low){
            offset = successor(&(n->cluster[high(x)]), low(x));
            return index(high(x), offset);
        }
        else {
            int succ_cluster = successor(n->summary, high(x));
            if (succ_cluster != NULL){
                return NULL;
            }
            else {
                offset = min(&(n->cluster[succ_cluster]));
                return index(succ_cluster, offset);
            }
        }
    }
}

void veb_print(){

}


int main(){


    return 0;
}