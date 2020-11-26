class MyNode<G>{
    value: G;
    next: MyNode<G> = null;
    constructor(g?: G){
        if (g) {
            this.value = g;
        } else {
            this.value = null;
        }
    }
    setNext(k: MyNode<G>): void{
        this.next=k;
    }
    setValue(v: G): void {
        this.value=v;
    }
}

class MyList<G> {
    root: MyNode<G> = new MyNode<G>();
    insert(k: MyNode<G>): void {
        k.setNext(this.root);
        this.root = k;
    }
    first(): G {
        return this.root.value;
    }
    // last funktioniert so nicht.
    last(): G {
        let current: MyNode<G> = this.root;
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
let k: MyNode<number> = new MyNode<number>(1);

list.insert(k);
list.insert(new MyNode<number>(2));
list.insert(new MyNode<number>(3));


console.log(list.last());