class ListNode<G>{
    value: G;
    next: ListNode<G> = null;
    constructor(g?: G){
        if (g) {
            this.value = g;
        } 
        else {
            this.value = null;
        }
    }
    setNext(k: ListNode<G>): void{
        this.next=k;
    }
    setValue(v: G): void {
        this.value=v;
    }
}

class MyList<G> {
    root: ListNode<G> = new ListNode<G>();
    insert(k: ListNode<G>): void {
        k.setNext(this.root);
        this.root = k;
    }
    first(): G {
        return this.root.value;
    }
    // last funktioniert so nicht.
    last(): G {
        let current: ListNode<G> = this.root;
        while (current.next!=null){
            console.log(current.value+" - "+current.next);
            if (current.value!=null){
                current=current.next;
            }
        }
        return current.value;
    }
}

let list: MyList<number> = new MyList<number>();
let k: ListNode<number> = new ListNode<number>(1);

list.insert(k);
list.insert(new ListNode<number>(2));
list.insert(new ListNode<number>(3));


console.log(list.last());