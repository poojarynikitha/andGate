
`include "defines.sv"
class and_environment;
//PROPERTIES
  //Virtual interfaces for driver, monitor and reference model
  virtual and_if drv_vif;
  virtual and_if mon_vif;
  virtual and_if ref_vif;
  //Mailbox for generator to driver connection
   mailbox #(and_transaction) mbx_gd;
  //Mailbox for driver to reference model connection
   mailbox #(and_transaction) mbx_dr;
  //Mailbox for reference model to scoreboard connection
   mailbox #(and_transaction) mbx_rs;
  //Mailbox for monitor to scoreboard connection
   mailbox #(and_transaction) mbx_ms;
