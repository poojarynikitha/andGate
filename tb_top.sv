`include "and.v"
`include "and_if.sv"
`include "and_pkg.sv"
module top( );
  //Importing the ram package
    import and_pkg ::*; 
  //Declaring variables for clock and reset
    bit clk;
    bit reset;
  //Generating the clock
  initial
    begin
     forever #10 clk=~clk;
    end
  //Asserting and de-asserting the reset
  initial
    begin
       @(posedge clk);
      reset=0;
      @(posedge clk);
      reset=1;
    end
 
  //Instantiating the interface
    ram_if intrf(clk,reset);
  //Instantiating the DUV
  AND DUV(.a(a),.b(b),.y(y)
            .clk(clk),
            .reset(reset)
           );
  //Instantiating the Test 
             );
  //Instantiating the Test 
    and_test tb1 = new(intrf.DRV,intrf.MON,intrf.REF_SB);
    //test1 tb1= new(intrf.DRV,intrf.MON);
    //test2 tb2= new(intrf.DRV,intrf.MON);
    //test3 tb3= new(intrf.DRV,intrf.MON);
    //test4 tb4= new(intrf.DRV,intrf.MON);
    //test_regression tb_regression= new(intrf.DRV,intrf.MON,intrf.REF_SB);

//Calling the test's run task which starts the execution of the testbench architecture 
  initial
   begin
   // tb_regression.run();
    tb1.run();
    $finish();
   end
endmodule
