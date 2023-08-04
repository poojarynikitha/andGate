`include "defines.sv"
class and_generator;
//PROPERTIES
  //and transaction class handle 
  and_transaction  blueprint;
  //Mailbox for generator to driver connection
  mailbox #(and_transaction)mbx_gd;
  //METHODS
  //Explicitly overriding the constructor to make mailbox connection 
  //from generator to driver
  function new(mailbox #(and_transaction)mbx_gd);
    this.mbx_gd=mbx_gd;
    blueprint=new();
  endfunction
   //Task to generate the random stimuli
  task start();
    for(int i=0;i<`no_of_trans;i++)
      begin
      //Randomizing the inputs
        blueprint.randomize();
      //Putting the randomized inputs to mailbox    
        mbx_gd.put(blueprint.copy());  
        $display("GENERATOR Randomized transaction a=%d,b=%d,",
                  blueprint.a,blueprint.b,$time);
      end
  endtask
endclass

