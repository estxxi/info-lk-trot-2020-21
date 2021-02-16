class Stack<T> {
    private inhalt: Array<T>;
    constructor(){
      this.inhalt = new Array<T>(); 
    }
    push(x: T): void {
      this.inhalt.push(x);
    }
    pop(): T {
      let erg = this.inhalt.pop();
      if (typeof  erg === "undefined") {
        throw new Error("oh no, anyway");
      } else {
        return erg as T;
      }
    }
    top(): T{
      return this.inhalt[this.inhalt.length-1] as T;
    }
    isEmpty() : boolean {
      return (this.inhalt.length === 0);
    }
    show() : string {
      return this.inhalt.toString();
    }
}

let s = new Stack<number>();

s.push(10);
s.push(100);
console.log(s.top())