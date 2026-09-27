`timescale 1ns / 1ps

module tb_elevator_controller;

    reg clk;
    reg reset;
    reg [3:0] floor_req;
    reg emergency_stop;

    wire move_up;
    wire move_down;
    wire motor_stop;
    wire [1:0] current_floor;

    elevator_controller dut (
        .clk(clk),
        .reset(reset),
        .floor_req(floor_req),
        .emergency_stop(emergency_stop),
        .move_up(move_up),
        .move_down(move_down),
        .motor_stop(motor_stop),
        .current_floor(current_floor)
    );

    // Clock: 10 ns period
    always #5 clk = ~clk;


    // Monitor
    initial begin
        $monitor("Time=%0t | Reset=%b | Request=%b | Emergency=%b | Floor=%d | UP=%b | DOWN=%b | STOP=%b",
                 $time,
                 reset,
                 floor_req,
                 emergency_stop,
                 current_floor,
                 move_up,
                 move_down,
                 motor_stop);
    end


    initial begin

        // Initial values
        clk = 0;
        reset = 1;
        floor_req = 4'b0000;
        emergency_stop = 0;

        @(negedge clk);
        reset = 0;


        // =========================
        // TEST 1
        // Floor 0 -> Floor 3
        // =========================

        $display("\nTEST 1: Floor 0 to Floor 3");

        @(negedge clk);
        floor_req = 4'b1000;

        repeat(5) @(negedge clk);

        floor_req = 4'b0000;

        @(negedge clk);


        // =========================
        // TEST 2
        // Floor 3 -> Floor 1
        // =========================

        $display("\nTEST 2: Floor 3 to Floor 1");

        @(negedge clk);
        floor_req = 4'b0010;

        repeat(4) @(negedge clk);

        floor_req = 4'b0000;

        @(negedge clk);


        // =========================
        // TEST 3
        // Emergency Stop
        // =========================

        $display("\nTEST 3: Emergency Stop");

        @(negedge clk);
        floor_req = 4'b1000;

        repeat(2) @(negedge clk);

        emergency_stop = 1;

        repeat(2) @(negedge clk);

        emergency_stop = 0;
        floor_req = 4'b0000;

        @(negedge clk);


        // =========================
        // TEST 4
        // Multiple Requests
        // =========================

        $display("\nTEST 4: Multiple Floor Requests");

        @(negedge clk);
        floor_req = 4'b1010;

        repeat(3) @(negedge clk);

        floor_req = 4'b0000;

        @(negedge clk);


        // =========================
        // END
        // =========================

        $display("\nSimulation completed.");

        $finish;

    end

endmodule