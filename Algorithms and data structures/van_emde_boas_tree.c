#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

typedef struct node{
    double u;
    struct node *summary;
    struct node **cluster;
    int min;
    int max;
} node;

typedef struct veb_tree{
    node *root;
} veb_tree;

int sqrt_up(double x){
    return pow(2, ceil(log2(x)/2));
}

int sqrt_down(double x){
    return pow(2, floor(log2(x)/2));
}

node* make_node(double u){
    node *new_node = malloc(sizeof(node));
    assert(new_node);

    new_node->u = u;
    if (u == 2){
        new_node->cluster = NULL;
        new_node->summary = NULL;
    }
    else {
        int size = sqrt_up(u);
        
        new_node->cluster = malloc(sizeof(node*) * size);
        assert(new_node->cluster);

        for (int i = 0; i < size; i++){
            *(new_node->cluster + i) = make_node(size);
        }

        new_node->summary = make_node(size);
    }
    new_node->max = -1;
    new_node->min = -1;

    return new_node;
}

veb_tree* make_veb_tree(double u){
    veb_tree *new_tree = malloc(sizeof(veb_tree));
    assert(new_tree);
    new_tree->root = make_node(u);

    return new_tree;
}

int low(int x, double u){
    return x % sqrt_down(u);
}

int high(int x, double u){
    return x / sqrt_down(u);
}

int veb_index(int x, int y, double u){
    return x * sqrt_down(u) + y;
}

int node_min(node *n){
    return n->min;
}

int node_max(node *n){
    return n->max;
}

int min(veb_tree *t){
    return node_min(t->root);
}

int max(veb_tree *t){
    return node_max(t->root);
}

void empty_node_insert(node *n, int x){
    n->min = x;
    n->max = x;
}

void node_insert(node *n, int x){
    int new_value = x;
    if (n->min == -1){
        empty_node_insert(n, new_value);
    }
    else {
        if (x < n->min){
            int temp = n->min;
            n->min = new_value;
            new_value = temp;
        }
        if (n->u > 2){
            if (node_min(n->cluster[high(x, n->u)]) == -1){
                node_insert(n->summary, high(x, n->u));
                empty_node_insert(n->cluster[high(x, n->u)], low(x, n->u));
            }
            else {
                node_insert(n->cluster[high(x, n->u)], low(x, n->u));
            }
        }
        if (new_value > n->max){
            n->max = new_value;
        }
    }
}

void insert(veb_tree *t, int x){
    node_insert(t->root, x);
}

int node_successor(node *n, int x){
    if (n->u == 2){
        if (x == 0 && n->max == 1){
            return 1;
        }
        else {
            return -1;
        }
    }
    else if (n->min != -1 && x < n->min){
        return n->min;
    }
    else{
        int offset;
        int max_low = node_max(n->cluster[high(x, n->u)]);
        if (max_low != -1 && low(x, n->u) < max_low){
            offset = node_successor(n->cluster[high(x, n->u)], low(x, n->u));
            return veb_index(high(x, n->u), offset, n->u);
        }
        else {
            int succ_cluster = node_successor(n->summary, high(x, n->u));
            if (succ_cluster == -1){
                return -1;
            }
            else {
                offset = node_min(n->cluster[succ_cluster]);
                return veb_index(succ_cluster, offset, n->u);
            }
        }
    }
}

int successor(veb_tree *t, int x){
    return node_successor(t->root, x);
}

void print_offset(int offset, int *links){
    for (int i = 0; i < offset; i++){
        if (links[i] == 1){
            printf("│   ");
        }
        else {
            printf("    ");
        }
    }
}

void print_node(node *n, int offset, int cluster, int last, int *links){
    if (n == NULL){
        printf("Error: printing NULL node");
        return;
    }

    if (cluster == 0){
        print_offset(offset, links);
    }
    
    if (offset != 0 && cluster == 0){
        printf((last == 1) ? "└─" : "├─");
    }

    printf("vEB(u=%d", (int)n->u);
    if (n->min == -1 || n->max == -1){
        printf(", min=/, max=/)\n");
    }
    else {
        printf(", min=%d, max=%d)\n", n->min, n->max);
    }

    if (n->u == 2){
        return;
    }

    print_offset(offset+1, links);
    printf("├─summary:\n");
    links[offset+1] = 1;
    print_node(n->summary, offset+2, 0, 1, links);
    links[offset+1] = 0;

    print_offset(offset+1, links);
    printf("└─clusters:\n");
    links[offset+2] = 1;
    int size = sqrt_up(n->u);
    for (int i = 0; i < size; i++){
        print_offset(offset+2, links);
        printf((i == size-1) ? "└─[%d]" : "├─[%d]", i);
        if (i == size-1){
            links[offset+2] = 0;
            print_node(*(n->cluster + i), offset+2, 1, 1, links);
            print_offset(offset+1, links);
            printf("\n");
        }
        else {
            print_node(*(n->cluster + i), offset+2, 1, 0, links);
        }
    }
}

void print_veb(veb_tree *t){
    printf("\nvan Emde Boas tree:\n\n");
    int *empty = malloc(sizeof(int) * 10);
    assert(empty);
    print_node(t->root, 0, 0, 0, empty);
    free(empty);
}

void free_node(node *n){
    if (n->u != 2){
        free_node(n->summary);
        for (size_t i = 0; i < (size_t)sqrt(n->u); i++){
            free_node(*(n->cluster + i));
        }
    }
    free(n);
}

void free_veb_tree(veb_tree *t){
    free_node(t->root);
    free(t);
}

int main(){

    veb_tree* tree = make_veb_tree(16);
    print_veb(tree);

    // insert(tree, 2);
    // insert(tree, 3);
    // insert(tree, 4);
    // insert(tree, 5);
    // insert(tree, 7);
    // insert(tree, 14);
    // insert(tree, 15);


    insert(tree, 2);
    insert(tree, 5);
    insert(tree, 6);
    insert(tree, 7);
    insert(tree, 13);

    print_veb(tree);

    printf("Min: %d\nMax: %d\n", min(tree), max(tree));
    printf("Successor pro 2: %d\n", successor(tree, 2));
    printf("Successor pro 13: %d\n\n", successor(tree, 13));

    free_veb_tree(tree);

    return 0;
}