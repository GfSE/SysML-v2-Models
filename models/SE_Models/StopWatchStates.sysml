package StopWatchStates {
     state def StopWatch {
 
          entry;
              then ready;
     
          action def VehicleStartSignal;
          action def VehicleOnSignal;
          action def VehicleOffSignal;
     
          state ready;
          
          transition ready_to_running
               first ready
               accept VehicleStartSignal
               then running;
      
          state running;
      
          transition running_to_stopped
               first running
               accept VehicleOnSignal
               then stopped;
      
          transition running_to_paused
               first running
               accept VehicleOffSignal
               then paused;
       
          state paused;

          transition paused_to_running
               first paused
               accept VehicleOffSignal
               then running;
          transition paused_to_stop
               first paused
               accept VehicleOffSignal
               then stopped;
   
          state stopped;

          transition stopped_to_ready
               first stopped
               accept VehicleOffSignal
               then done;
       
     }
}
