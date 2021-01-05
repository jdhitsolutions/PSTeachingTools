using System;
namespace PSTeachingTools {

//enums used by the class
public enum VegStatus {
    Raw,
    Boiled,
    Steamed,
    Sauteed,
    Fried,
    Baked,
    Roasted,
    Grilled
}

public enum VegColor {
    green,
    red,
    white,
    yellow,
    orange,
    purple,
    brown
}
    public class PSVegetable {
        //properties
       public string Name {get; private set;}
       public int Count {get;set;}
       public int UPC {get; private set;}
       public VegStatus CookedState {get;set;}
       public bool IsRoot {get; private set;}
       public bool IsPeeled {get;set;}
       public VegColor Color {get; private set;}

        //methods
        public void Peel() {
            this.IsPeeled = bool.Parse("true");
        }

        public void Prepare(VegStatus State) {
            this.CookedState = State;
        }

        //custom constructor
        public PSVegetable(string VegetableName,bool Root,VegColor VegetableColor,int UPCCode)  {
            Name = VegetableName;
            IsRoot = Root;
            Color = VegetableColor;
            UPC = UPCCode;
        }

  } //class definition
} //namespace
