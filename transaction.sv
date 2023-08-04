class and_transaction;
//PROPERTIES
//INPUTS declare as rand variables
  rand bit [1:0] a;
  rand bit [1:0] b;
  //Output
  bit y;
  constraint ip_a{inside{0,1};}
    constraint ip_b{inside{0,1};}  
  /METHODS
//Copying objects for blueprint This is a deep copy function
 virtual function and_transaction copy();
  copy = new();
  copy.a=this.a;
  copy.b=this.b;
 
  return copy;
  endfunction
endclass 
