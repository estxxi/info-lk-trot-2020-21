abstract class CarShop{
    constructor(){

    }
    abstract createVehicle()

    giveVehicle():Vehicle{
        return 
    }
}

class Tesla(){
    createCar() 
}

class MAN(){

}

interface Car{
    model():string;
    drive():string;
}

class TIR implements Car{
    license_plate: string;
    constructor(license_plate:string){
        this.license_plate = license_plate;
    };

    model():string{
        return "SUV";
    }

    drive():string{
        return "Vroom vroom hust hust";
    }
}

class Coupe implements Car{
    license_plate: string;
    constructor(license_plate:string){
        this.license_plate = license_plate;
    };

    model():string{
        return "SUV";
    }

    drive():string{
        return "Vroom vroom hust hust";
    }
}
