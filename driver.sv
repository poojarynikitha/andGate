`include "defines.sv"
class and_driver;
//PROPERTIES  
  //and transaction class handle
   and_transaction drv_trans;
  //Mailbox for generator to driver connection
  mailbox #(and_transaction)mbx_gd;
  //Mailbox for driver to reference model connection
  mailbox #(and_transaction)mbx_dr;
  //Virtual interface with driver modport and it's instance 
   virtual and_if.DRV vif;
  //FUNCTIONAL COVERAGE for inputs
covergroup drv_cg;
  A:   coverpoint drv_trans.a { bins a1[]={0,1};}
  B:   coverpoint drv_trans.b { bins  b1[]={0,1};}
 // A1xB1: cross A,B;
endgroup

  //METHODS
  function new(mailbox #(and_transaction)mbx_gd,
               mailbox #(and_transaction)mbx_dr,
               virtual and_if.DRV vif);
    this.mbx_gd=mbx_gd;
    this.mbx_dr=mbx_dr;
    this.vif=vif;
   //Creating the object for covergroup
    drv_cg=new();
  endfunction
  
   task start();
   @(vif.drv_cb);
    for(int i=0;i<`no_of_trans;i++)
      begin
        drv_trans=new();
       //Getting the transaction from generator
        mbx_gd.get(drv_trans);
         vif.drv_cb.a<=drv_trans.a;
               vif.drv_cb.b<=drv_trans.b;
        $display("DRIVER A DRIVING DATA TO THE INTERFACE a=%d,b=%d,",vif.drv_cb.a,vif.drv_cb.b,$time); 
               vif.drv_cb.a<=0;
               //Putting the randomized inputs to mailbox    
               mbx_dr.put(drv_trans);
               //Sampling the covergroup
               drv_cg.sample();
               $display("INPUT FUNCTIONAL COVERAGE = %0d", drv_cg.get_coverage());
        end
     end
  endtask
endclass

