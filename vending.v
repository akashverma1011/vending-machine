module vending_machine();

   output reg out;
   output reg [1:0] change;
   input [1:0] in;// 01=5 rs ,10=10rs
   input      clk,rst;
   
   
   reg [1:0]   c_state;
   reg [1:0]   n_state;


   parameter  s0=2'b00;
   parameter  s1=2'b01;
   parameter  s2=2'b10;
  


   always @(posedge clk)
     begin
        if (rst==1) // reset all the variable
           begin
              c_state=0;
              n_state=0;
              change=2'00;
           end
        
       else
         c_state=n_state;
     


      
        case (c_state)
     s0: //state 0: 0 rs
       
           if (in==2'b00)
               begin
                  n_state=s0;
                  out=0;
                  change=2'b00;
                end  
           
           else if (in==2'b01) //01 means 5 rs
              begin 
                   n_state=s1;
                   out=0;
                   change=2'b00;
              end
           
          
         else if (in==2'b10)
          begin
            n_state=s2;
            out=0;
           change=2'b00;
          end
       s1:  // state 1 :5 rs
          
         if (in==2'b00)
               begin
                  n_state=s0;
                  out=0;
                  change=2'b01;
                end  
           
           else if (in==2'b01)//01 means 5 rs
              begin 
                   n_state=s2;
                   out=0;
                   change=2'b00;
              end
           
          
         else if (in==2'b10)
          begin
            n_state=s1;
            out=1;
           change=2'b00;
          end
       s2:
         if (in==2'b00)
               begin
                  n_state=s0;
                  out=0;
                  change=2'b10;
                end  
           
           else if (in==2'b01)
              begin //01 means 5 rs
                   n_state=s0;
                   out=1;
                   change=2'b00;
              end
           
          
           else if (in==2'b10)  // adding 10 rs means already have 10 rs so return
                                // 5 rs and out is 1.
          begin
            n_state=s0;
            out=1;
           change=2'b01;
          end
       
    endcase // case (state)
     


  
 
endmodule
