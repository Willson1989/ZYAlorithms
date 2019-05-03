
//
//  Trie.c
//  Play-with-Alorithms
//
//  Created by WillHelen on 2018/9/9.
//  Copyright © 2018年 ZhengYi. All rights reserved.
//

#include "Trie.h"
#include <stdlib.h>
#include <stdio.h>
#include <strings.h>

#define NODE_MAX_NUM 26

typedef struct TrieNode {
    
    struct TrieNode * child[NODE_MAX_NUM];
    int count;
    
} Trie;

/** Initialize your data structure here. */
Trie* trieCreate() {
    TrieNode * node = (TrieNode *)malloc(sizeof(TrieNode));
    memset(node, 0, sizeof(TrieNode));
    return node;
}

/** Inserts a word into the trie. */
void trieInsert(Trie* obj, char* word) {
    if (obj == NULL || *word == '\0') {
        return;
    }
    
    TrieNode *t = obj;
    char *p = word;
    
    while (*p != '\0') {
        //如果没有该字符，则创建一个Node并插入
        if (t->child[*p-'a'] == NULL) {
            TrieNode *node = trieCreate();
            t->child[*p-'a'] = node;
        }
        t = t->child[*p-'a'];
        p++;
    }
    t->count ++;
}

/** Returns if the word is in the trie. */
bool trieSearch(Trie* obj, char* word) {
    
    return false;
}

/** Returns if there is any word in the trie that starts with the given prefix. */
bool trieStartsWith(Trie* obj, char* prefix) {
    
    return false;
}

void trieFree(Trie* obj) {
    
}

/**
 * Your Trie struct will be instantiated and called as such:
 * struct Trie* obj = trieCreate();
 * trieInsert(obj, word);
 * bool param_2 = trieSearch(obj, word);
 * bool param_3 = trieStartsWith(obj, prefix);
 * trieFree(obj);
 */
