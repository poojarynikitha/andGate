class and_test;
//PROPERTIES
  //Virtual interfaces for driver, monitor and reference model
  virtual and_if drv_vif;
  virtual and_if mon_vif;
  virtual and_if ref_vif;
  //Declaring handle for environment
  and_environment env;

//METHODS
  //Explicitly overriding the constructor to connect the virtual interfaces
  //from driver, monitor and reference model to test
  function new(virtual and_if drv_vif,
               virtual and_if mon_vif,
               virtual and_if ref_vif);
    this.drv_vif=drv_vif;
    this.mon_vif=mon_vif;
    this.ref_vif=ref_vif;
  endfunction

    task run();
    env=new(drv_vif,mon_vif,ref_vif);
    env.build;
    env.start;
  endtask
endclass
