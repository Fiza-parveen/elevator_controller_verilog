timescale 1ns / 1ps

    module elevator_controller(
    input clk,
    input reset,
    input [3:0] floor_req,
    input emergency_stop,
    output reg move_up,
    output reg move_down,
    output reg motor_stop,
    output reg [1:0] current_floor
);

parameter idle = 0,
          MOVE_UP = 1,
          MOVE_DOWN = 2,
          emergency = 3;

reg [1:0] state, next_state;
reg [1:0] target_floor;

always @(*) begin
    target_floor = current_floor;

    if (floor_req[0])
        target_floor = 2'd0;
    else if (floor_req[1])
        target_floor = 2'd1;
    else if (floor_req[2])
        target_floor = 2'd2;
    else if (floor_req[3])
        target_floor = 2'd3;
end

always @(posedge clk) begin
    if (reset)
        state <= idle;
    else
        state <= next_state;
end

always @(posedge clk) begin
    if (reset)
        current_floor <= 2'd0;

    else if (!emergency_stop &&
             state == MOVE_UP &&
             current_floor < target_floor)
        current_floor <= current_floor + 1'b1;

    else if (!emergency_stop &&
             state == MOVE_DOWN &&
             current_floor > target_floor)
        current_floor <= current_floor - 1'b1;
end

always @(*) begin

    next_state = state;

    if (emergency_stop) begin
        next_state = emergency;
    end

    else begin

        case (state)

            idle: begin
                if (target_floor > current_floor)
                    next_state = MOVE_UP;
                else if (target_floor < current_floor)
                    next_state = MOVE_DOWN;
            end

            MOVE_UP: begin
                if (current_floor == target_floor)
                    next_state = idle;
                else
                    next_state = MOVE_UP;
            end

            MOVE_DOWN: begin
                if (current_floor == target_floor)
                    next_state = idle;
                else
                    next_state = MOVE_DOWN;
            end

            emergency: begin
                if (!emergency_stop)
                    next_state = idle;
                else
                    next_state = emergency;
            end

            default:
                next_state = idle;

        endcase
    end
end


always @(*) begin

    move_up = 1'b0;
    move_down = 1'b0;
    motor_stop = 1'b0;

    case (state)

        MOVE_UP:
            move_up = 1'b1;

        MOVE_DOWN:
            move_down = 1'b1;

        emergency:
            motor_stop = 1'b1;

        idle:
            motor_stop = 1'b1;

    endcase
end

endmodule