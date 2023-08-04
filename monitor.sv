`include "defines.sv"
class and_monitor;
//PROPERTIES
  //and transaction class handle
    and_transaction mon_trans;
  //Mailbox for monitor to scoreboard connection
  mailbox #(and_transaction) mbx_ms;
  //Virtual interface with driver modport and it's instance 
    virtual and_if.MON vif;

  //FUNCTIONAL COVERAGE for outputs
  covergroup mon_cg;
    Y: coverpoint mon_trans.y{bins  y1[] ={[0:255]};}
  endgroup

//METHODS
  //Explicitly overriding the constructor to make mailbox connection from monitor
  //to scoreboard, to make mailbox connection from monitor to scoreboard and
  //to connect the virtual interface from monitor to enviornment 
  function new( virtual and_if.MON vif,
               mailbox #(and_transaction) mbx_ms);
    this.vif=vif;
    this.mbx_ms=mbx_ms;
   //Creating the object for covergroup
    mon_cg=new();
  endfunction

   //Task to collect the output from the interface
  task start();
    @(vif.mon_cb); 
    for(int i=0;i<`no_of_trans;i++)
      begin
        mon_trans=new();
        repeat(1) @(vif.mon_cb)
             begin
              mon_trans.y=vif.mon_cb.y;
             // mon_trans.address=vif.mon_cb.address;
             end
        $display("MONITOR PASSING THE DATA TO SCOREBOARD y=%d",mon_trans.y,$time);
        //Putting the collected ouputs to mailbox    
        mbx_ms.put(mon_trans);
        //Sampling the covergroup
        mon_cg.sample();
        $display("OUTPUT FUNCTIONAL COVERAGE = %0d", mon_cg.get_coverage());
         @(vif.mon_cb);
      end
  endtask
endclass      


