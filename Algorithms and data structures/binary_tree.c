#include <stdio.h>
#include <stdlib.h>

typedef struct node{
    int data;
    struct node* parent;
    struct node* left;
    struct node* right;
} node;

typedef struct tree{
    node* root;
} tree;

node* create_node (int data, node* parent){
    node* new_node = (node*)malloc(sizeof(node));
    new_node->parent = parent;
    new_node->data = data;
    new_node->left = NULL;
    new_node->right = NULL;
    return new_node;
}

node* add_node (node* tree, int data, node* parent){
    if (tree == NULL){
        return create_node(data, parent);
    }
    if (data < tree->data){
        tree->left = add_node(tree->left, data, tree);
    }
    else {
        tree->right = add_node(tree->right, data, tree);
    }
    return tree;    
}

void add (tree* t, int data){
    t->root = add_node(t->root, data, t->root);
}


void help_print(node* t) {
    if (t != NULL) {
        help_print(t->left);
        if (t->parent != NULL){
            printf("Uzel: %d Parrent: %d\n", t->data, t->parent->data);
        }
        else {
            printf("Uzel: %d Parrent: nemá rodiče\n", t->data);
        }
        help_print(t->right);
    }
}

void print_in_order(tree t){
    help_print(t.root);
}


void free_tree(node* t) {
    if (t != NULL) {
        free_tree(t->left);
        free_tree(t->right);
        free(t);
    }
}

int depth_help (node* t){
    if (t == NULL){
        return -1;
    }
    int left = depth_help(t->left);
    int right = depth_help(t->right);

    if (left > right){
        return (1 + left);
    }
    else{
        return (1 + right);
    }
}

int depth(tree t){
    return depth_help(t.root);
}

int tree_min (node* root){
    node* min = root;
    while (min->left != NULL){
        min = min->left;
    }
    return min->data;
}

int tree_max (node* root){
    node* max = root;
    while (max->right != NULL){
        max = max->right;
    }
    return max->data;
}

void set_left_child (node* parent, node* child){
    parent->left = child;
    if (child != NULL){
        child->parent = parent;
    }
}

void set_right_child (node* parent, node* child){
    parent->right = child;
    if (child != NULL){
        child->parent = parent;
    }
}

void tree_swap (tree* strom, node* u, node* v){
    if (strom->root == u){
        strom->root = v;
    }
    else {
        node* y = u->parent;
        if (u == y->left){
            set_left_child(y, v);
        }
        else {
            set_right_child(y, v);
        }
    }
}

void node_swap (tree* strom, node* u, node* v){
    set_left_child(v, u->left);
    set_right_child(v, u->right);
    if (strom->root == u){
        strom->root = v;
    }
    else {
        node* y = u->parent;
        if (y != NULL){
            if (u->data == y->left->data){
                set_left_child(y, v);
            }
            else {
                set_right_child(y, v);
            }
        }
    }
}

int tree_remove_help(node* uzel, int data, tree* t){
    if (uzel == NULL){
        return 0;
    }
    else if (uzel->data > data){
        return tree_remove_help(uzel->left, data, t);
    }
    else if (uzel->data < data){
        return tree_remove_help(uzel->right, data, t);
    }
    else {
        if (uzel->left == NULL && uzel->right == NULL){
            if (uzel->parent != NULL){
                if (uzel->parent->data < uzel->data){
                    uzel->parent->right = NULL;
                }
                else {
                    uzel->parent->left = NULL;
                }
            }
            else {
                t->root = NULL;
            }
            free(uzel);
            return 1;
        }
        if (uzel->left == NULL){
            if (uzel->parent == NULL){
                t->root = uzel->right;
                t->root->parent = NULL;
            }
            else {
                tree_swap(t, uzel, uzel->right);
            }
            return 1;
        }
        if (uzel->right == NULL){
            if (uzel->parent == NULL){
                t->root = uzel->left;
                t->root->parent = NULL;
            }
            else {
                tree_swap(t, uzel, uzel->left);
            }
            return 1;
        }
        int y = tree_min(uzel->right);
        tree_remove_help(uzel, y, t);
        node* x = create_node(y, NULL);
        if (uzel->parent == NULL){
            t->root = x;
        }
        node_swap(t, uzel, x);
        free(uzel);
        return 1;
    }
}

int tree_remove (tree* t, int data){
    return tree_remove_help(t->root, data, t);
}

typedef struct node_list{
    node* uzel_strom;
    struct node_list* next;
} node_list;

typedef struct queue {
    node_list* front;
    node_list* rear;
} queue;

node_list* create_node_list (node* uzel_strom){
    node_list* new = (node_list*)malloc(sizeof(node_list));
    new->uzel_strom = uzel_strom;
    new->next = NULL;
    return new;
}

queue* create_queue (){
    queue* nova_fronta = (queue*)malloc(sizeof(queue));
    nova_fronta->front = NULL;
    nova_fronta->rear = NULL;
    return nova_fronta;
}

int is_empty (queue* fronta){
    if (fronta->front == NULL && fronta->rear == NULL){
        return 1;
    }
    return 0;        
}

void enqueue (queue* fronta, node* uzel_strom){
    node_list* new = create_node_list(uzel_strom);
    new->uzel_strom = uzel_strom;
    new->next = NULL;
    if (fronta->rear == NULL){
        fronta->front = new;
        fronta->rear = new;
    }
    else {
        fronta->rear->next = new;
        fronta->rear = new;
    }
}

node* dequeue (queue* fronta){
    if (is_empty(fronta)){
        printf("Fronta je prázdná!\n");
        return NULL;
    }
    else {
        node_list* temp = fronta->front;
        node* uzel_strom = temp->uzel_strom;
        fronta->front = fronta->front->next;
        if (fronta->front == NULL){
            fronta->rear = NULL;
        }
        free(temp);
        return uzel_strom;
    }
}

void print_bft_help(node* uzel){
    if (uzel != NULL){
        queue* fronta = create_queue();
        enqueue(fronta, uzel);
        while (!is_empty(fronta)){
            node* now = dequeue(fronta);
            printf("%d|", now->data);
            if (now->left != NULL){
                enqueue(fronta, now->left);
            }
            if (now->right != NULL){
                enqueue(fronta, now->right);
            }
        }
        printf("\n");
        free(fronta);
    }
}

void print_bft(tree *t){
    print_bft_help(t->root);
}

int main(){
    tree strom;
    strom.root = NULL;

    add(&strom, 10);
    add(&strom, 8);
    add(&strom, 12);
    add(&strom, 7);
    add(&strom, 9);
    add(&strom, 11);
    add(&strom, 13);

    // add(&strom, 15);
    // add(&strom, 10);
    // add(&strom, 20);
    // add(&strom, 5);
    // add(&strom, 8);
    // add(&strom, 3);
    // add(&strom, 1);
    // add(&strom, 7);
    // add(&strom, 9);


    printf("Průchod stromu:\n");
    print_in_order(strom);
    printf("\n");
    printf("Hloubka je: %d\n", depth(strom));
    printf("Minumum je: %d\n", tree_min(strom.root));
    printf("Maximum je: %d\n\n", tree_max(strom.root));
    int i = tree_remove(&strom, 50);
    if (i == 1){
        printf("Průchod stromu:\n");
        print_in_order(strom);
        printf("\n");
    }   
    else {
        printf("Číslo nebylo nalezeno.\n\n");
    }

    printf("Průchod stromem do šířky: ");
    print_bft(&strom);

    free_tree(strom.root);
    return 0;
}