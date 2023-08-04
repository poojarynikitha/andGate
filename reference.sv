`include "defines.sv"
class and_reference_model;
//PROPERTIES
  //and transaction class handle
   and_transaction ref_trans;
  //Mailbox for reference model to scoreboard connection
  mailbox #(and_transaction) mbx_rs;
  //Mailbox for driver to reference model connection
  mailbox #(and_transaction) mbx_dr;
  //Virtual interface with driver modport and it's instance
   virtual and_if.REF_SB vif;
  
  //Associative array used for mimicing the functionality of the RAM
  // bit [7:0] MEM [bit [31:0]];

  function new(mailbox #(and_transaction) mbx_dr,
               mailbox #(and_transaction) mbx_rs,
               virtual and_if.REF_SB vif);
    this.mbx_dr=mbx_dr;
    this.mbx_rs=mbx_rs;
    this.vif=vif;
  endfunction

   //Task which mimics the functionality of the RAM
  task start();
    for(int i=0;i<`no_of_trans;i++)
     begin
      ref_trans=new();
     //getting the driver transaction from mailbox 
      mbx_dr.get(ref_trans);
       @(vif.ref_cb)
     //  begin 
       //  if(ref_trans.a)
        // MEM[ref_trans.address]=ref_trans.data_in;
      //  $display("REFERENCE MODEL DATA IN MEMORY MEM[ADDRESS]=%d",MEM[ref_trans.address],$time);
       // if(ref_trans.read_enb)
       //  ref_trans.data_out=MEM[ref_trans.address];
       // $display("REFERENCE MODEL DATA OUT FROM MEMORY data_out=%d",ref_trans.data_out,$time);
    //   end
     //Putting the reference model transaction to mailbox 
      mbx_rs.put(ref_trans);
     end 
  endtask
endclass
 
