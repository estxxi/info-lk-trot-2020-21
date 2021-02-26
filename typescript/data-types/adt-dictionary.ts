function hashNumber(x: number) : number {
    return Math.floor(x/100); 
}

class Pair<T, U> {
    key: T;
    value: U;
    isTombstone: boolean = false;

    constructor(key, value) {
        this.key = key;
        this.value = value;
    }
}

class Dict {
    // null ist hier immer Platzhalter -> nicht einfügen
    dict: Array<Pair<any, any>> = [];
    hash: (key: any) => number;
    size: number;
    max_size: number; // begrenzt durch hash Fkt. Wertebereich/Speicherplatz
    filled_places: number = 0; 
    // filled_places wir in insert und remove geupdated, tombstones werden nicht gezählt
    // Dadurch werden lookups langsamer, aber wir sparen Speicherplatz, da wir seltener die dictionary
    // vergrößern
    
    constructor(hash: (any) => number, size: number, max_size: number) {
        this.hash = hash;
        this.size = size;
        this.max_size = max_size;
        for (let i = 0; i < size; i++) {
            this.dict.push(new Pair<any, any>(null, null));
        }
    }

    show() : Array<Pair<any, any>> {
        console.log(this.dict);
        return this.dict;
    }

    private isLookupBreakpoint(index: number) : boolean {
        return this.dict[index].key == null && !this.dict[index].isTombstone;
    }
 
    lookup(key: any) : any {
        // wenn key und hashfunktion inkompatibel sind, kommt hier ein error
        let hash_index = this.hash(key) % this.size;

        for (let i = hash_index; i < hash_index + this.size; i++) {
            if (this.dict[i % this.size].key == key) {
                return this.dict[i % this.size].value;
            }
            else if (this.isLookupBreakpoint(i % this.size)) {
                return null;
            }
        }
        return null;
    }

    private isValidInsertPosition(index: number) : boolean {
        return this.dict[index].key == null || this.dict[index].isTombstone || this.dict[index].key;
    }

    insert(key: any, value: any) : boolean {
        // wenn key und hashfunktion inkompatibel sind, kommt hier ein error
        let hash_index = this.hash(key) % this.size;
        
        for (let i = hash_index; i < hash_index + this.size; i++) {
            if (this.isValidInsertPosition(i % this.size)) {
                this.dict[i % this.size].key = key; 
                this.dict[i % this.size].value = value;
                this.dict[i % this.size].isTombstone = false;
                this.filled_places += 1; 
                this.sizecheck()
                return true;
            }
        } 
        return false;
    }

    remove(key: any) : boolean {
        // wenn key und hashfunktion inkompatibel sind, kommt hier ein error
        let hash_index = this.hash(key) % this.size;

        for (let i = hash_index; i < hash_index + this.size; i++) {
            if (this.dict[i % this.size].key == key) {
                this.dict[i % this.size].key = null;
                this.dict[i % this.size].value = null;
                this.dict[i % this.size].isTombstone = true; 
                this.sizecheck;
                this.filled_places -= 1
                return true;
            }
            else if (this.isLookupBreakpoint(i % this.size)) {
                return false;
            }
        }
        return false;
    }

    containsKey(key: any) : boolean {
        // wenn key und hashfunktion inkompatibel sind, kommt hier ein error
        let hash_index = this.hash(key) % this.size;

        for (let i = hash_index; i < hash_index + this.size; i++) {
            if (this.dict[i % this.size].key == key) {
                return true;
            }
            else if (this.isLookupBreakpoint(i % this.size)) {
                return false;
            }
        }
        return false;
    }

    keys() : Array<any> {
        let keys = [];

        for (let i of this.dict) {
            if (i.key != null) {
                keys.push(i.key);
            }
        }
        return keys;
    }

    items() : Array<any> {
        let items = [];

        for (let i of this.dict) {
            if (i.value != null) {
                items.push(i.value);
            }
        }
        return items;
    }

    // returns if there was a resize
    private sizecheck() : boolean {
        // Man könnte noch verkleinern, ist aber genau gleich
        let load_factor = this.filled_places % this.size;
        
        if (load_factor > 0.75) {
            if (this.size * 2 > this.max_size) {
                this.resize(Math.floor(this.max_size/this.size)); // maximum resize
                return true;
            }
            else {
                this.resize(2);
                return true;
            }
        }
        else {
            console.log("The dictionary is getting too full")
        }
    }

    private resize(factor: number) {
        let old_dict = this.dict; // alte dict speichern
        this.size *= 2; // Größe anpassen

        // neue dict initialisieren
        this.dict = [];
        for (let i = 0; i < this.size; i++) {
            this.dict.push(new Pair<any, any>(null, null));
        }

        // alte Elemente übertragen
        for (let i of old_dict) {
            if ((i.key != null || i.value != null) && !i.isTombstone) {
                this.insert(i.key, i. value);
            }
        }

        console.log("resized by factor" + factor.toString())
    }
}

let myDict = new Dict(hashNumber, 5, 25);

myDict.insert(1001, 1);
myDict.insert(400, 2);
myDict.insert(110, 3);
myDict.remove(100);
console.log(myDict.lookup(110));
myDict.insert(900, 4); 
myDict.insert(950, 5);