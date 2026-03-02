#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include <stdbool.h>

typedef enum Color{
    red,
    black
} Color;

typedef struct node{
    int data;
    struct node* parent;
    struct node* right;
    struct node* left;
    Color color;
} node;

typedef struct RBTree{
    node* root;
} RBTree;

node NIL = {0, NULL, NULL, NULL, black};

RBTree* rb_create(){
    RBTree* new_tree = malloc(sizeof(RBTree));
    assert(new_tree);
    new_tree->root = &NIL;
    return new_tree;
}

node* create_node(int data){
    node* new_node = malloc(sizeof(node));
    new_node->data = data;
    new_node->left = &NIL;
    new_node->right = &NIL;
    new_node->color = red;
    return new_node;
}

int tree_insert(node* root, node* added, node* parrent){
    if (root == &NIL){
        root = added;
        added->parent = parrent;
        if (parrent->data > added->data){
            parrent->left = added;
        }
        else {
            parrent->right = added;
        }
        return 1;
    }
    else if (root->data > added->data){
        return tree_insert(root->left, added, root);
    }
    else if (root->data < added->data){
        return tree_insert(root->right, added, root);
    }
    return 0;
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

node* rotate_R(node* root){
    node* x = root->left;
    node* b = x->right;
    set_left_child(root, b);
    set_right_child(x, root);
    return x;
}

node* rotate_L(node* root){
    node* x = root->right;
    node* b = x->left;
    set_right_child(root, b);
    set_left_child(x, root);
    return x;
}


node* local_fix(RBTree* tree, node* z){
    //* Pokud je rodič černý, tak je to ok
    if (z->parent->color != black){
        //* Left
        if (z->parent->data > z->data){//* Left
            //* 1. možnost - strýc je červený - přebarvení 
            if (z->parent->parent->left->color == red){
                z->parent->color = black;
                z->parent->parent->left->color = black;
                z->parent->parent->color = red;
                z = z->parent->parent;
            }
            //* Strýc je černý
            else{
                //* 2. možnost - rotace a přebarvení
                if (z->parent->left == z){
                    rotate_R(z->parent->parent);
                    Color temp = z->parent->color;
                    z->parent->color = z->parent->left->color;
                    z->parent->left->color = temp;
                }
                //*3. Možnost - z míří dovnitř stromu, levá rotace -> další iterace -> 2. možnost
                else{
                    rotate_L(z->parent);
                }
            }
        }
        //* Right
        else{
            //* 1. možnost - strýc je červený - přebarvení R
            if (z->parent->parent->right->color == red){
                z->parent->color = black;
                z->parent->parent->right->color = black;
                z->parent->parent->color = red;
                z = z->parent->parent;
            }
            //* Strýc je černý
            else{
                //* 2. možnost - rotace a přebarvení
                if (z->parent->right == z){
                    rotate_L(z->parent->parent);
                    Color temp = z->parent->color;
                    z->parent->color = z->parent->right->color;
                    z->parent->right->color = temp;
                }
                //*3. Možnost - z míří dovnitř stromu, pravá rotace -> další iterace -> 2. možnost
                else{
                    rotate_R(z->parent);
                }
            }
        }
    }
    return z;
}

void rb_fixup(RBTree* tree, node* actual){
    while (actual != tree->root){
        if (actual->parent->color == black){
            break;
        }
        actual = local_fix(tree, actual);
    }
    tree->root->color = black;
}

int rb_add(RBTree *tree, int data){
    node* added = create_node(data);
    if (tree->root == &NIL){
        added->color = black;
        tree->root = added;
        return 1;
    }
    int x = tree_insert(tree->root, added, tree->root);
    if (x == 1){
        rb_fixup(tree, added);
        return 1;
    }
    return 0;
}

int search_help(node* root, int data){
    if (root == NULL){
        return 0;
    }
    if (root->data == data){
        return 1;
    }
    else if (root->data > data){
        return search_help(root->left, data);
    }
    else{
        return search_help(root->right, data);
    }
}

int rb_search(RBTree *tree, int data){
    return search_help(tree->root, data);
}

typedef struct result{
    node* u;
    Color color;
    //* Používá se pouze v rb_delete_fixup
    bool quit;
} result;

node* tree_min (node* root){
    node* min = root;
    while (min->left != &NIL){
        min = min->left;
    }
    return min;
}

void node_swap (RBTree* tree, node* u, node* v){
    v->color = u->color;
    set_left_child(v, u->left);
    set_right_child(v, u->right);
    if (tree->root == u){
        tree->root = v;
    }
    else {
        node* y = u->parent;
        if (y != &NIL){
            if (u->data == y->left->data){
                set_left_child(y, v);
            }
            else {
                set_right_child(y, v);
            }
        }
    }
}

void tree_swap (RBTree* tree, node* u, node* v){
    if (tree->root == u){
        tree->root = v;
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

result tree_delete(node* root, int data, RBTree* tree){
    if (root == &NIL){
        //* červená
        return (result){&NIL, red};
    }
    else if (root->data > data){
        return tree_delete(root->left, data, tree);
    }
    else if (root->data < data){
        return tree_delete(root->right, data, tree);
    }
    else {
        Color cl;
        //* Nemá ani jednoho potomka
        if (root->left == &NIL && root->right == &NIL){
            node* parent = root->parent;
            if (parent != &NIL){
                //* right
                if (parent->data < root->data){
                    parent->right = &NIL;
                }
                //* left
                else {
                    parent->left = &NIL;
                }
            }
            //* Odstranění kořene (jednoprvkový strom)
            else {
                tree->root =&NIL;
            }
            cl= root->color;
            free(root);
            return (result){parent, cl};
        }
        //* Existuje pravý potomek
        if (root->left == &NIL){
            if (root->parent == &NIL){
                tree->root = root->right;
                tree->root->parent = &NIL;
                cl = root->color;
                free(root);
                return (result){tree->root, cl};
            }
            else {
                node* parent = root->parent;
                tree_swap(tree, root, root->right);
                cl = root->color;
                free(root);
                return (result){parent, cl};
            }
        }
        //* Existuje levý potomek
        if (root->right == &NIL){
            if (root->parent == &NIL){
                tree->root = root->left;
                tree->root->parent = &NIL;
                cl = root->color;
                free(root);
                return (result){tree->root, cl};
            }
            else {
                node* parent = root->parent;
                tree_swap(tree, root, root->left);
                cl = root->color;
                free(root);
                return (result){parent, cl};
            }
        }
        //* uzel má 2 potomky
        node* p = tree_min(root->right);
        cl = p->color;
        int y = p->data;
        tree_delete(root, y, tree);
        node* x = create_node(y);
        if (root->parent == &NIL){
            tree->root = x;
        }
        node_swap(tree, root, x);
        free(root);
        return (result){p->parent, cl};
    }
}

result local_delete_fix(RBTree* tree, node* z){
    bool boolean = false;
    //* Jsme vlevo
    if (z->data < z->parent->data){
        //* První případ - sourozenec je červený
        if (z->parent->right->color == red){
            z->parent->right->color = black;
            z->parent->color = red;
            rotate_R(z->parent->right);
        }
        else{
            //* Druhý případ - sourozenec je černý a oba jeho potomci jsou černí
            if (z->parent->right->left->color == black && z->parent->right->right->color == black){
                z->parent->right->color = red;
                z = z->parent;
            }
            //* Třetí případ - sourozenec je černý a pravý potomek je červený
            else if (z->parent->right->right->color == red){
                z->parent->right->right->color = black;
                rotate_L(z->parent->right);
                boolean = true;
            }
            //* Čtvrtý případ - sourozenec je černý, pravý potomek je černý tedy levý potomek musí být červený -> změna na předchozí případ
            else{
                z->parent->right->left->color = black;
                z->parent->right->color = red;
                rotate_R(z->parent->right->left);
            }
        }
    }   
    //* Jsme vpravo
    else{
        //* První případ - sourozenec je červený
        if (z->parent->left->color == red){
            z->parent->left->color = black;
            z->parent->color = red;
            rotate_L(z->parent->left);
        }
        else{
            //* Druhý případ - sourozenec je černý a oba jeho potomci jsou černí
            if (z->parent->left->right->color == black && z->parent->left->left->color == black){
                z->parent->left->color = red;
                z = z->parent;
            }
            //* Třetí případ - sourozenec je černý a pravý potomek je červený
            else if (z->parent->left->left->color == red){
                z->parent->left->left->color = black;
                rotate_L(z->parent->left);
                boolean = true;
            }
            //* Čtvrtý případ - sourozenec je černý, pravý potomek je černý tedy levý potomek musí být červený -> změna na předchozí případ
            else{
                z->parent->left->right->color = black;
                z->parent->left->color = red;
                rotate_R(z->parent->left->right);
            }
        }
    }
    //! red jen pro doplnění
    return (result){z, red, boolean};
}

void rb_delete_fixup(RBTree* tree, node* z){
    while (z != tree->root){
        if (z->color == red){
            z->color = black;
            break;
        }
        result res = local_delete_fix(tree, z);
        if (res.quit){
            break;
        }
    }
}

int rb_delete(RBTree *tree, int data){
    result res = tree_delete(tree->root, data, tree);
    if (res.color != red){
        rb_delete_fixup(tree, res.u);
        return 1;
    }
    else{
        if (res.u == &NIL){
            return 0;
        }
        return 1;
    }
}

int rb_height_help(node* root){
    if (root == &NIL){
        return 0;
    }
    int left = rb_height_help(root->left);
    int right = rb_height_help(root->right);

    if (left > right){
        return (1 + left);
    }
    else{
        return (1 + right);
    }
}

int rb_height(RBTree *tree){
    return rb_height_help(tree->root);
}

void help_print(node* root) {
    if (root != &NIL) {
        help_print(root->left);
        printf("%d.%u|", root->data, root->color);
        help_print(root->right);
    }
}

void rb_in_order_print(RBTree *tree){
    help_print(tree->root);
    printf("\n");
}

void free_nodes(node* root) {
    if (root != &NIL) {
        free_nodes(root->left);
        free_nodes(root->right);
        free(root);
    }
}

void free_tree(RBTree* tree){
    if (tree != NULL){
        free_nodes(tree->root);
        free(tree);
    }
}

int main(){
    RBTree* stromecek = rb_create();

    rb_add(stromecek, 13);
    rb_add(stromecek, 45);
    rb_add(stromecek, 72);
    rb_add(stromecek, 2);
    rb_add(stromecek, 27);
    rb_add(stromecek, 108);
    rb_add(stromecek, 56);
    rb_add(stromecek, 19);
    rb_add(stromecek, 33);
    rb_add(stromecek, 31);

    rb_in_order_print(stromecek);
    // printf("Výška RB stromu je: %d\n", rb_height(stromecek));

    // int r = rb_search(stromecek, 1);
    // if (r == 1){
    //     printf("Nalezeno\n");
    // }
    // else{
    //     printf("Nenalezeno\n");
    // }

    // r = rb_search(stromecek, 40);
    // if (r == 1){
    //     printf("Nalezeno\n");
    // }
    // else{
    //     printf("Nenalezeno\n");
    // }

    int r = rb_delete(stromecek, 27);
    if (r == 1){
        printf("Úspěšně smazáno\n");
    }
    else{
        printf("Nenalezeno\n");
    }

    rb_in_order_print(stromecek);

    free_tree(stromecek);
    return 0;
}