#include <stdio.h>
#include <stdlib.h>

typedef struct node{
    int key;
    struct node *child;
    struct node *sibling;
    int degree;
    struct node *parent;
} node;

typedef struct tree{
    struct node *root;
} tree;

tree* make_tree(){
    tree* new_tree = malloc(sizeof(tree));
    new_tree->root = NULL;
    return new_tree;
}

void binomial_link(node *y, node *z){
    y->parent = z;
    y->sibling = z->child;
    z->child = y;
    z->degree += 1;
}

tree* merge(tree *t1, tree *t2){
    tree *new_tree = make_tree();

    node *r1 = t1->root;
    node *r2 = t2->root;
    node *tail = new_tree->root;
    node *min = NULL;

    while (r1 != NULL && r2 != NULL){
        if (r1->degree <= r2->degree){
            min = r1;
            r1 = r1->sibling;
        } else{
            min = r2;
            r2 = r2->sibling;
        }
        if (new_tree->root == NULL){
            new_tree->root = min;
            tail = min;
        } else{
            tail->sibling = min;
            tail = min;
        }
    }
    node *rest = (r1 != NULL) ? r1 : r2;

    if (tail != NULL){
        tail->sibling = rest;
    } else {
        new_tree->root = rest;
    }
    return new_tree;
}

tree* tree_union(tree *t1, tree *t2){
    tree *new_tree = merge(t1, t2);

    if (new_tree->root == NULL){
        return new_tree;
    }

    node *previous = NULL;
    node *x = new_tree->root;
    node *next = x->sibling;

    if (next == NULL){
        new_tree->root = x;
        return new_tree;
    }

    while (next != NULL){
        if (x->degree != next->degree || (next->sibling != NULL && next->sibling->degree == x->degree)){
            previous = x;
            x = next; 
        }
        else if (x->key <= next->key){
            x->sibling = next->sibling;
            binomial_link(next, x);
        }
        else if (previous == NULL){
            new_tree->root = next;
            binomial_link(x, next);
            x = next;
        }
        else{
            previous->sibling = next;
            binomial_link(x, next);
            x = next;
        }
        next = x->sibling;
    }

    return new_tree;
}

void insert(tree *t, int key){
    tree *new_tree = make_tree();
    node *new_node = malloc(sizeof(node));
    new_node->parent = NULL;
    new_node->child = NULL;
    new_node->sibling = NULL;
    new_node->degree = 0;
    new_node->key = key;    
    new_tree->root = new_node;
    tree *union_tree = tree_union(t, new_tree);
    t->root = union_tree->root;
    free(union_tree);
    free(new_tree);
}

node* min(tree *t){
    node *actual_node = t->root;
    node *minimal = NULL;
    int min = INT16_MAX;

    while (actual_node != NULL){
        if (actual_node->key < min){
            min = actual_node->key;
            minimal = actual_node;
        }
        actual_node = actual_node->sibling;
    }

    return minimal;
}

node* extract_min(tree *t){
    node *actual_node = t->root;
    node *minimal = NULL;
    node *older_sibling = NULL;
    node *previous = NULL;
    int min_key = INT16_MAX;

    while (actual_node != NULL){
        if (actual_node->key < min_key){
            min_key = actual_node->key;
            minimal = actual_node;
            older_sibling = previous;
        }
        previous = actual_node;
        actual_node = actual_node->sibling;
    }

    tree *new_tree = make_tree();
    node *next = minimal->child;
    node *sibling = NULL;
    new_tree->root = next;
    next = next->sibling;
    new_tree->root->sibling = NULL;
    while (next != NULL){
        sibling = next->sibling;
        next->sibling = new_tree->root;
        new_tree->root = next;
        next->parent = NULL;
        next = sibling;
    }

    if (older_sibling == NULL){
        t->root = new_tree->root;
        free(new_tree);
        return minimal;
    }

    older_sibling->sibling = minimal->sibling;
    tree* union_tree = tree_union(t, new_tree);
    t->root = union_tree->root;

    free(union_tree);
    free(new_tree);

    return minimal;
}

void swap_keys(node *x, node *y){
    int temp = x->key;
    x->key = y->key;
    y->key = temp;
}

void decrease_key(tree *t, node *x, int key){
    if (key > x->key){
        printf("Nový klíč je moc velký");
        return;
    }

    x->key = key;
    node *current = x;
    node *parent = x->parent;

    while (parent != NULL && current->key < parent->key){
        swap_keys(parent, current);
        current = parent;
        parent = current->parent;
    }
}

typedef struct array{
    int array[20];
    int tail;
} array;

void print_node_help(array *family_tree, int offset){
    printf("\n");
    int happpend = 0;
    for (int x = 0; x < offset; x++){
        if (x != 0){
            for (int i = 0; i < family_tree->tail; i++){
                if (x == family_tree->array[i]){
                    printf("|");
                    happpend = 1;
                    break;
                }
            }
        }
        if (happpend == 1){
            happpend = 0;
            continue;
        }
        printf(" ");
    }
}

void print_node(node *n, int space, int new_line, int offset, array* family_tree){
    if (n == NULL){
        return;
    }
    
    int new_offset = offset;
    if (new_line == 1){
        print_node_help(family_tree, offset);
    }
    if (offset){
        printf("-");
        new_offset++;
    }

    printf("(%d)", n->key);

    array *new_family_tree;
    int alocated = 0;
    if (n->sibling != NULL){
        new_family_tree = malloc(sizeof(array));
        alocated = 1;
        for (int i = 0; i < family_tree->tail; i++){
            new_family_tree->array[i] = family_tree->array[i];
        }
        new_family_tree->tail = family_tree->tail + 1;
        new_family_tree->array[family_tree->tail] = offset;
    }
    else{
        new_family_tree = family_tree;
    }

    print_node(n->child, 1, 0, new_offset+3, new_family_tree);

    if (n->sibling != NULL){
        print_node_help(family_tree, offset);
        if(offset == 0){
            printf(" ");
        }
        printf("|");
        print_node(n->sibling, 0, 1, offset, new_family_tree);
    }
    if (alocated == 1){
        free(new_family_tree);
    }
}

void print_tree(tree *t){
    array *fam_tree = malloc(sizeof(array));
    fam_tree->tail = 0;
    print_node(t->root, 0, 0, 0, fam_tree);
    printf("\n\n");
    free(fam_tree);
}

void free_nodes(node *n){
    if (n != NULL){
        if (n->child != NULL){
            free_nodes(n->child);
        }
        if (n->sibling != NULL){
            free_nodes(n->sibling);
        }
        free(n);
    }
}

void cascade_free(tree *t){
    free_nodes(t->root);
    free(t);
}

int main(){
    // tree *t = make_tree();

    // insert(t, 1);
    // printf("Insert 1:\n");
    // print_tree(t);

    // insert(t, 2);
    // printf("Insert 2:\n");
    // print_tree(t);

    // insert(t, 3);
    // printf("Insert 3:\n");
    // print_tree(t);

    // insert(t, 4);
    // printf("Insert 4:\n");
    // print_tree(t);

    // insert(t, 5);
    // printf("Insert 5:\n");
    // print_tree(t);

    // insert(t, 6);
    // printf("Insert 6:\n");
    // print_tree(t);

    // insert(t, 7);
    // printf("Insert 7:\n");
    // print_tree(t);

    // insert(t, 8);
    // printf("Insert 8:\n");
    // print_tree(t);

    // printf("Minumum: %d\n\n", min(t)->key);
    // node *extracted_minimum = extract_min(t);
    // printf("Extracted minimum: %d\n", extracted_minimum->key);
    // print_tree(t);
    // printf("Minumum: %d\n\n", min(t)->key);

    // insert(t, 9);
    // printf("Insert 9:\n");
    // print_tree(t);

    // node *big_child = t->root;
    // for (int i = 0; i < 3; i++){
    //     big_child = big_child->child;
    // }
    // printf("Decrease 8 to 1:\n");
    // decrease_key(t, big_child, 1);
    // print_tree(t);

    // free(extracted_minimum);

    tree *t = make_tree();
    insert(t, 10);
    insert(t, 12);
    insert(t, 20);
    insert(t, 15);
    insert(t, 50);
    insert(t, 70);
    insert(t, 50);
    insert(t, 40);
    insert(t, 80);
    insert(t, 85);
    insert(t, 65);

    print_tree(t);

    node *extracted_minimum = extract_min(t);
    printf("Extracted minimum: %d\n", extracted_minimum->key);
    free(extracted_minimum);
    print_tree(t);

    node *big_child = t->root->sibling;
    for (int i = 0; i < 3; i++){
        big_child = big_child->child;
    }
    decrease_key(t, big_child, 0);
    print_tree(t);

    cascade_free(t);
    return 0;
}