class D_Knoten<T>{
    private _before: D_Knoten<T>;
    public get before(): D_Knoten<T> {
        return this._before;
    }
    public set before(value: D_Knoten<T>) {
        this._before = value;
    }
    private _after: D_Knoten<T>;
    public get after(): D_Knoten<T> {
        return this._after;
    }
    public set after(value: D_Knoten<T>) {
        this._after = value;
    }
    private _value: T;
    public get value(): T {
        return this._value;
    }
    public set value(value: T) {
        this._value = value;
    }

    constructor(before ?: D_Knoten<T> , after ?: D_Knoten<T> , value ?: T){
        this._before = before;
        this._after = after;
        this._value = value;
    }

}

class D_List<T>{
    private first : D_Knoten<T> = null;
    private _length: number = 0;
    public get length(): number {
        return this._length;
    }
    public set length(value: number) {
        this._length = value;
    }
    constructor(init ?: Array<T>){
        if(init){
            for(let value of init){
                this.insert(value);
            }
        }
    }
    insert(value : T){
        if(this.first === null){
            this.first = new D_Knoten<T>();
            this.first.after = this.first;
            this.first.before = this.first;
            this.first.value = value;
            this._length++;
        } else {
            let newNode = new D_Knoten<T>(this.first.before,this.first,value);
            this.first.before.after = newNode;
            this.first.before = newNode;
            this._length++;
        }
    }
    at(index : number) : T{
        let node : D_Knoten<T> = this.first;
        if(index >= this._length){
            throw Error("Index out of bounds")
        }
        if(index > (this._length / 2)){
            index--;
            while(index != 0){
                node = node.before;
                index--;
            }
            return node.value;
        } else {
            while(index != 0){
                node = node.after;
                index--;
            }
            return node.value;
        }
    }
    to_string() : string{
        let node : D_Knoten<T> = this.first;
        let l = this.length;
        let res : string = "[";
        while(l>1){
            res += node.value + ", ";
            node = node.after;
            l--;
        }
        res += node.value + "]"
        return res;
    }
}

let l = new D_List<number>([1,4,6,465,746,84]);
console.log(l.to_string());