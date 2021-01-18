// NUR INSERT; CODE NUR VIELLEICHT FUNKTIONSFÄHIG (NICHT GETESTET)
// grundsätzlich auf schöne Implementierung geachtet, haha
// Red-Black Tree
enum Colour {
    r = "red",
    b = "black",
    n = "NaN"
}

class MyNodeRB<T> {
    // null bei leaves
    value: T | null; 
    colour: Colour; 
    left: MyNodeRB<T> | undefined;
    right: MyNodeRB<T> | undefined;
    // undefined als Standardwert, bzw. wenn wir parent von root erfragen
    parent: MyNodeRB<T> | undefined;

    constructor(value: T, colour: Colour, parent: MyNodeRB<T> = undefined) {
        // value und colour müssen beim erstellen immer übergeben werden
        this.value = value;
        this.colour = colour;

        // Wir erstellen automatisch die Kinder als nodes, diese sind beim Einfügen leaves, haben also 
        // value null. Das tolle: Wir verlinken automatisch alle Verwandten. Achtung: Die Verwandten 
        // können auch undefined sein. Damit spart man sich alle findparent etc Funktionen! Ist aber 
        // Speicherintensiver. 
        this.left = new MyNodeRB<T>(null, Colour.b, parent = this)
        this.right = new MyNodeRB<T>(null, Colour.b, parent = this)

        // Einfach Parameterzuordnung
        this.parent = parent;
    }

    getValue() : T {return this.value}
    setValue(x: T) : void{this.value = x}

    getColour() : Colour {return this.colour}
    setColour(x: Colour) : void {this.colour = x}

    getLeft() : MyNodeRB<T> {return this.left}
    setLeft(left: MyNodeRB<T>) : void {this.left = left}
    getRight() : MyNodeRB<T> {return this.right}
    setRight(right: MyNodeRB<T>) : void {this.right = right}

    getParent() : MyNodeRB<T> {return this.parent}
    setParent(x: MyNodeRB<T>) : void {this.parent = x}

    getGrandparent() : MyNodeRB<T> {
        if (this.getParent != undefined) {
            return this.getParent().getParent();
        }
        else {
            return undefined;
        }
    }

    getSibling() : MyNodeRB<T> {
        if (this.getParent() != undefined) {
            if (this.getParent().getLeft() === this) {
                return this.getParent().getLeft();
            }
            else if (this.getParent().getRight() === this) {
                return this.getParent().getRight();
            }
        }
        else {
            return undefined;
        }
    }

    getUncle() : MyNodeRB<T> {return this.getParent().getSibling()}
}

class Tree<T> {
    root: MyNodeRB<T>;
    // Beim initialisieren muss root einen Wert kriegen (in dieser Implementierung)
    constructor(rootval: T){
        // Bei der root sind alle Verwandten undefined, sie ist schwarz
        this.root = new MyNodeRB<T>(rootval, Colour.b);
    }

    private replaceSubtree(old_node: MyNodeRB<T>, new_node: MyNodeRB<T>) {
        // Schlecht für Speicher, da zwar der neue subtree verlinkt wird,
        // der alte aber nicht gelöscht wird
        if (old_node.getParent().getValue() > old_node.getValue()) {
            old_node.getParent().setRight(new_node);
        }
        else {
            old_node.getParent().setLeft(new_node);
        }
        new_node.setParent(old_node.getParent())
        // new node kann nicht den Wert von old_node parent haben, da es sonst nicht
        // eingefügt werden würde
    }

    private rotateRight(base: MyNodeRB<T>) : void {
        // Wir bauen einen neuen subtree unter new_base und ersetzen am Ende den alten
        // War nicht die ursprüngliche Idee, aber ich hab vergessen, dass Änderungen in base
        // nicht auf die entsprechende node übertragen werden
        // Deshalb der Speicherintensive replaceSubtree Ansatz

        // Rechter Subtree vom linken subtree von base geht über -> Kopie
        let init_base: MyNodeRB<T> = base;
        let shifting_subtree: MyNodeRB<T> = base.getLeft().getRight();
        let new_base: MyNodeRB<T> = base.getLeft();
        
        // Neue Eltern werden zugeordnet:
        // linke subnode kriegt Elter von base, bei root undefined
        // base kriegt seine linke subnode
        // Shifting subtree kriegt base
        new_base.setParent(base.getParent()) // set parent auf undefined
        base.setParent(new_base);
        shifting_subtree.setParent(base);
        // Neue left/rights werden zugeordnet
        // linke subnode von base kriegt base als rechten node
        // linker subtree wird zur root
        // base kriegt links shifting subtree (anstelle von neuer root)
        new_base.setRight(base);
        base.setLeft(shifting_subtree);
        
        this.replaceSubtree(init_base, new_base)

        if (base.getParent === undefined) { // Fall base ist root
            this.root = new_base
        }
    }

    private rotateLeft(base: MyNodeRB<T>) : void {
        let init_base: MyNodeRB<T> = base;
        let shifting_subtree: MyNodeRB<T> = base.getRight().getLeft();
        let new_base: MyNodeRB<T> = base.getRight();
            
        new_base.setParent(base.getParent()) // set parent auf undefined
        base.setParent(new_base);
        shifting_subtree.setParent(base);

        new_base.setLeft(base);
        base.setLeft(shifting_subtree); 

        this.replaceSubtree(init_base, new_base)

        if (base.getParent() === undefined) { // Fall base ist root
            this.root = base.getLeft()
        }
    }

    insert(x: T, start: MyNodeRB<T> = this.root) : void {
        // zuerst ganz basic binary tree insert
        if (start.getValue() === null) { 
            let init_start: MyNodeRB<T> = start.getParent();
            // wir sind bei einem leaf angekommen
            // wir bewegen uns hoch und gucken, ob wir beim linken oder rechten
            // leaf einfügen müssen
            if (start.getParent().getValue() > x) {
                start.getParent().setRight(new MyNodeRB<T>(x, Colour.r, start.getParent()))
                // this.insertCase(start.getParent().getRight())
            }
            else if (start.getParent().getValue() < x) {
                start.getParent().setLeft(new MyNodeRB<T>(x, Colour.r, start.getParent()))
                // this.insertCase(start.getParent().getLeft())
            }
            // Wie bei rot, start.getParent() ist jetzt der neu gebaute Baum
            this.replaceSubtree(init_start, start.getParent())
        } 
        else if (start.getValue() > x) {return this.insert(x, start.getRight())}
        else if (start.getValue() < x) {return this.insert(x, start.getLeft())}
        else {return}
        // else case wäre x === start.getValue(), also x ist schon Element
        // Da passiert einfach nichts
    }

    insertCase(n_node: MyNodeRB<T>) : void{
        let init_n_node: MyNodeRB<T> = n_node;
        // Neue node wird übergeben
        // Erster Fall: Node ist root (für spätere Fälle relevant, bei dieser Implementierung
        // wird nie root eingefügt, sondern direkt initalisiert)
        if (n_node === this.root) {
            n_node.setColour(Colour.b);
            this.replaceSubtree(init_n_node, n_node);
        }
        // Zweiter Fall: Parent ist schwarz -> Baum noch valide, fertig
        else if (n_node.getParent().getColour() === Colour.b) {return}
        // Dritter Fall: parent und uncle sind rot
        else if (n_node.getUncle().getValue() != null && n_node.getUncle().getColour() === Colour.r) {
            n_node.getParent().setColour(Colour.b);
            n_node.getUncle().setColour(Colour.b);
            n_node.getGrandparent().setColour(Colour.r);

            this.replaceSubtree(init_n_node.getGrandparent(), n_node.getGrandparent());

            return this.insertCase(n_node.getGrandparent()); // geht auch wenn grandp root ist
        }
        // Vierter Fall: parent rot, uncle schwarz
        else {
            let p: MyNodeRB<T> = n_node.getParent();
            let g: MyNodeRB<T> = n_node.getGrandparent();
            // alt_node ist die neue n_node, wenn n_node nach außen gehen muss
            let alt_node: MyNodeRB<T>;
            // node, die für das finale replaceSubtree nötig ist
            let final_top: MyNodeRB<T>;
            // n_node ist "innen" -> durch entsprechende Rotation nach außen drehen
            // Dabei können p und n "Plätze tauschen", farblich ist das äq.
            if (n_node === p.getRight() && p === g.getLeft()){
                this.rotateLeft(p);
                let alt_node = n_node.getLeft();
            }
            else if (n_node === p.getLeft() && p === g.getRight()){
                this.rotateRight(p);
                let alt_node = n_node.getRight();
            }
            else {let alt_node = n_node}
            // n_node ist jetzt auf jeden Fall außen 
            if (alt_node === p.getLeft()) {
                this.rotateRight(g);
                final_top = g.getLeft().getParent()
            }
            else {
                this.rotateRight(g);
                final_top = g.getRight().getParent()
            }

            this.replaceSubtree(init_n_node.getGrandparent().getParent(), final_top)
        }
    }
}

let try_me = new Tree<number>(0);
console.log(try_me.root.getValue())