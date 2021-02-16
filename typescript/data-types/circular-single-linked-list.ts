class RingNode<G>{
    value: G;
    next: RingNode<G>;
    constructor(val?: G, mynext?: RingNode<G>){
        if (val) {
            this.value = val;
        }
        else {
            this.value = null;
        }
        if (mynext) {
            this.next = mynext;
        }
        else {
            this.next = undefined;
        }
    }

    setValue(val: G): void{
        this.value = val;
    }

    setNext(mynext: RingNode<G>): void{
        this.next = mynext;
    }
}

class MyRing<G>{
    // current is first
    // Als Maskierung für RingNode implementieren (.next und .value nicht direkt aufrufen)
    current: RingNode<G> = new RingNode<G>();
    length: number = 1;

    constructor(currentval: G) {
        this.current.setNext(this.current);
        this.current.setValue(currentval);
    }

    setNodeValue(sel_node: RingNode<G>, myval: G): void {
        sel_node.setValue(myval);
    }

    insert(new_node: RingNode<G>, myval: G, i: RingNode<G> = this.current): void {
        if (i.next === this.current) {
            i.setNext(new_node);
            new_node.setNext(this.current);
            new_node.setValue(myval);
            length++;
        }
        else {
            return this.insert(new_node, myval, i.next);
        }
    }

    first(): G {
        return this.current.next.value;
    }

    last(i: RingNode<G> = this.current): G {
        if (i.next === this.current) {
            return i.value;
        }
        else {
            return this.last(i.next);
        }
    }

    show(i: RingNode<G> = this.current, out: string = this.current.value.toString()):string {
        if (i.next === this.current){
            return out + ', ' + i.value.toString();
        }
        else{
            return this.show(i.next, out + ', ' + i.value.toString())
        }
    }

    indexAccess(index: number, save: RingNode<G> = this.current): G {
        for (let i = 0; i < index % length; i++) {
            save = save.next;
        }
        return save.value;
    }
}

let a: MyRing<number> = new MyRing<number>(0);
let el: RingNode<number> = new RingNode<number>();

for (let i = 2; i < 10; i++){
    a.insert(new RingNode<number>(), i)
}

a.insert(el, 100);

console.log(el.next.value);

a.current.value = 109000
console.log(a.show())

console.log(a.indexAccess(0))
console.log(a.indexAccess(1))
console.log(a.indexAccess(2))
console.log(a.indexAccess(9))
console.log(a.indexAccess(10))
console.log(a.indexAccess(11))
