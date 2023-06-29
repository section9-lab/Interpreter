#lang racket
(printf "~a~n" "Hello world!")

(define tree-sum
  (lambda (exp)
    (match exp                         ; 对输入exp进行模式匹配
      [(? number? x) x]                ; exp是一个数x吗？如果是，那么返回这个数x
      [`(,e1 ,e2)                      ; exp是一个含有两棵子树的中间节点吗？
       (let ([v1 (tree-sum e1)]        ; 递归调用tree-sum自己，对左子树e1求值
             [v2 (tree-sum e2)])       ; 递归调用tree-sum自己，对右子树e2求值
         (+ v1 v2))])))                ; 返回左右子树结果v1和v2的和

(tree-sum '(1 2))
;; => 3
(tree-sum '(1 (2 3)))
;; => 6
(tree-sum '((1 2) 3))
;; => 6
(tree-sum '((1 2) (3 4)))
;; => 10

(println "-------------------")

(define calc
  (lambda (exp)
    (match exp                                ; 分支匹配：表达式的两种情况
      [(? number? x) x]                       ; 是数字，直接返回
      [`(,op ,e1 ,e2)                         ; 匹配提取操作符op和两个操作数e1,e2
       (let ([v1 (calc e1)]                   ; 递归调用 calc 自己，得到 e1 的值
             [v2 (calc e2)])                  ; 递归调用 calc 自己，得到 e2 的值
         (match op                            ; 分支匹配：操作符 op 的 4 种情况
           ['+ (+ v1 v2)]                     ; 如果是加号，输出结果为 (+ v1 v2)
           ['- (- v1 v2)]                     ; 如果是减号，乘号，除号，相似的处理
           ['* (* v1 v2)]
           ['/ (/ v1 v2)]))])))


(calc '(+ 1 2))
;; => 3
(calc '(* 2 3))
;; => 6
(calc '(* (+ 1 2) (+ 3 4)))
;; => 21

