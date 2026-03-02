#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include <stdbool.h>

typedef struct node{
    char name;
    int **length_matrix;
    bool visited;
}node;

typedef struct Graph{
    node **matrix;
    node *s;
}Graph;

typedef struct node_list{
    node* uzel;
    struct node_list* next;
} node_list;

typedef struct queue {
    node_list* front;
    node_list* rear;
} queue;

node_list* create_node_list (node* uzel){
    node_list* new = (node_list*)malloc(sizeof(node_list));
    new->uzel = uzel;
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

void enqueue (queue* fronta, node* uzel){
    node_list* new = create_node_list(uzel);
    new->uzel = uzel;
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
        node* uzel = temp->uzel;
        fronta->front = fronta->front->next;
        if (fronta->front == NULL){
            fronta->rear = NULL;
        }
        free(temp);
        return uzel;
    }
}

int dijkstra(Graph *g, int n){
    node* s = g->s;
    node result[n];
    queue *Q = create_queue();
    enqueue(Q, s);

}



int main(){


    return 0;
}