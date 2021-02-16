class HangMe {
    private valid_chars: Array<string>;
    private wordlist: Array<string>; 

    private word: string;
    private letters: Set<string>;
    private guessed_letters: Set<string>;
    private lives: number = 10;

    constructor(lives: number = 10, valid_chars: Array<string> = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "ä", "ö", "ü"], wordlist: Array<string> = ["Beispiel", "p&"]) {
        // validity check für chars und wörter
        for (let i = 0; i < wordlist.length; i++) {
            for (let j = 0; j < wordlist[i].toLowerCase().length; j++) {
                console.log("In snd for" + wordlist[i].toLowerCase()[j] + wordlist[i].toLowerCase().length.toString() + j.toString() + valid_chars.indexOf(wordlist[i].toLowerCase()[j]).toString())
                if (valid_chars.indexOf(wordlist[i].toLowerCase()[j]) < 0) { // funktioniert nicht? Kein error bei &
                    Error("valid_chars and wordlist don't match");
                }
            }
        }
        
        // Wenn kein Error kommt
        this.valid_chars = valid_chars;
        this.wordlist = wordlist;
        this.lives = lives;
        console.log(Math.floor(Math.random() * this.wordlist.length))

        this.word = this.wordlist[Math.floor(Math.random() * this.wordlist.length)]

        this.letters = new Set();
        for (let i = 0; i < this.word.length; i++) {
            if (this.word[i] != " ") {
                this.letters.add(this.word.toLowerCase()[i]);
            }
        }
        console.log("constructed game");
    }

    private isGuessed() : boolean {
        return this.letters === this.guessed_letters;
    }

    private isAlive() : boolean {
        return this.lives > 0;
    }

    private isValidGuess(guess: string) : boolean {
        return guess.length === 1 && (this.valid_chars.indexOf(guess) >= 0) && !(this.guessed_letters.has(guess));
    }

    private isCorrectGuess(guess: string) : boolean {
        // isValidGuess wird angenommen
        return this.letters.has(guess);
    }

    getValidLetters() {
        return this.valid_chars;
    }

    getGuessedLetters() {
        return this.guessed_letters;
    }

    getLives() {
        return this.lives;
    }

    status() : [boolean, boolean] {
        return [this.isAlive(), this.isGuessed()]
    }

    // Return codes:
    // -1: dead before guess; -2: guessed before guess; -3: invalid guess
    // Succesful guess: (boolean, boolean) -> (this.isAlive(), this.isGuessed())
    guess(guess: string) : number | [boolean, boolean] {
        guess = guess.toLowerCase()
        if (!this.isAlive()) {
            console.log("Ha! You're dead.");
            return -1;
        }
        else if (this.isGuessed()) {
            console.log("Sod off, you already found it.");
            return -2;
        }
        else if (!this.isValidGuess(guess)) {
            console.log(guess.toString() + " is not a valid guess, knobhead.");
            return -3;
        }
        else {
            this.guessed_letters.add(guess);

            if (!this.isCorrectGuess(guess)) {
                console.log("Guess what? You guessed wrong.");
                this.lives -= 1;
                return this.status();
            }
            else {
                console.log("Oh, you guessed right.");
                return this.status();
            }
        }
    }
}   

class Guesser {
    static modes = [0];
    // 0 - random guess
    private mode: number;
    private game: HangMe;

    constructor(mode: number, game: HangMe){
        if (Guesser.modes.indexOf(mode) >= 0){
            this.mode = mode;
        }
        else {Error("Invalid mode")}

        this.game = game;
    }

    // God function
    // true wenn erraten wird, sonst false (oder Error)
    do() : boolean {
        console.log("In do()")
        if (this.mode === 0) {
            let game_state: number | [boolean, boolean] = this.game.status();
            console.log(game_state)
            // Bedingung erfüllt, geht aber nicht in while Schleife???
            while (game_state == [true, false]) { // [isAlive, isGuessed]
                console.log("In while")
                let guessable_chars = this.game.getValidLetters().filter(item => this.game.getGuessedLetters().has(item));             
                let random_val = Math.floor(Math.random() * guessable_chars.length);
                let guess = guessable_chars[random_val];

                console.log("I'm guessing " + guess);
                game_state = this.game.guess(guessable_chars[random_val]);
            }

            // Ergebnisse überprüfen
            if (game_state === [true, true]) { // isAlive, isGuessed
                console.log("Yeyy, I won")
                return true;
            }
            else if (game_state === [false, false]){
                console.log("* dead *")
                return false;
            }
            else if (typeof(game_state) === "number") {
                Error("gamemode 0 received return code from game, weird " + game_state.toString())
            }
            else {
                Error("gamemode 0 guessed and is dead?")
            }
        }
    }
}

let std_game = new HangMe();
let random_guesser = new Guesser(0, std_game);

let isWon: boolean = random_guesser.do();

if (isWon) {
    console.log("random_guesser won std_game.")
}
else {
    console.log("random_guesser lost std_game.")
}