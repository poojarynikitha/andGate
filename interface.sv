interface ram_if(input bit clk,reset);
//Declaring signals with width
  logic[1:0] a,b;
  logic y;

  //Clocking block for driver
  clocking drv_cb@(posedge clk);
  //Specifying the values for input and output skews 
    default input #0 output #0;
  //Declaring signals without widths, but specifying the direction
    output a,b;
    input reset;
  endclocking

  //Clocking block for monitor
  clocking mon_cb@(posedge clk);
  //Specifying the values for input and output skews
    default input #0 output #0;
  //Declaring signals without widths, but specifying the direction
    input a,b,reset;
  endclocking

  //clocking block for reference model
  clocking ref_cb@(posedge clk);
  //Specifying the values for input and output skews
    default input #0 output #0;
  //Declaring signals without widths, but specifying the direction
  //  input a,b,reset;
  //  output y;
  endclocking

  //modports for driver, monitor and reference model
  modport DRV(clocking drv_cb);
  modport MON(clocking mon_cb);
  modport REF_SB(clocking ref_cb);
endinterface
