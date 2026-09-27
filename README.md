# 4-Floor Elevator Controller --- Verilog HDL

A **4-floor elevator controller** designed in Verilog HDL using a finite
state machine (FSM).\
The project focuses on RTL design, sequential/combinational logic,
state-machine implementation, and functional verification through a
Verilog testbench.

## Project Overview

This project implements the control logic of a simple elevator serving
**4 floors (0--3)**.

The controller: - Accepts floor requests through a 4-bit request
input. - Determines the target floor. - Moves the elevator one floor at
a time in the required direction. - Stops automatically when the
requested floor is reached. - Supports an emergency-stop condition. -
Handles multiple simultaneous floor requests using a defined priority. -
Keeps the elevator floor within the valid range of 0--3.

## Main Features

-   4-floor elevator control
-   FSM-based RTL architecture
-   Up/down movement control
-   Current-floor tracking
-   Floor-request handling
-   Emergency-stop state
-   Automatic motor-stop control
-   Multiple-request priority handling
-   Verilog testbench with multiple functional test cases

## FSM States

The controller uses four states:

  State         Description
  ------------- -----------------------------
  `idle`        Elevator is stationary
  `MOVE_UP`     Elevator is moving upward
  `MOVE_DOWN`   Elevator is moving downward
  `emergency`   Emergency stop is active

### State Flow

``` text
             Target > Current
        +------------------------+
        |                        v
     +------+                +---------+
     | IDLE |                | MOVE_UP |
     +------+                +---------+
        ^                        |
        |     Target reached     |
        +------------------------+

             Target < Current
        +------------------------+
        |                        v
     +------+                +-----------+
     | IDLE |                | MOVE_DOWN |
     +------+                +-----------+
        ^                        |
        |     Target reached     |
        +------------------------+

              Emergency Stop
        +------------------------+
        |                        v
     +------+                +-----------+
     | Any  | -------------->| EMERGENCY |
     +------+                +-----------+
```

## Inputs

  ------------------------------------------------------------------------
  Signal                                       Width Description
  --------------------- ---------------------------- ---------------------
  `clk`                                        1 bit System clock

  `reset`                                      1 bit Resets controller to
                                                     floor 0

  `floor_req`                                 4 bits Floor request input;
                                                     bits correspond to
                                                     floors 0--3

  `emergency_stop`                             1 bit Activates emergency
                                                     stop
  ------------------------------------------------------------------------

## Outputs

  Signal               Width Description
  ----------------- -------- --------------------------------------
  `move_up`            1 bit Indicates upward movement
  `move_down`          1 bit Indicates downward movement
  `motor_stop`         1 bit Indicates that the motor should stop
  `current_floor`     2 bits Current elevator floor

## Floor Request Priority

If multiple floor requests are active at the same time, the controller
uses the following priority:

``` text
Floor 0 > Floor 1 > Floor 2 > Floor 3
```

For example:

``` text
floor_req = 4'b1010
```

contains requests for floors 1 and 3. The controller selects **floor 1**
because of the implemented priority logic.

## Emergency Stop

When `emergency_stop` becomes active:

1.  The controller enters the `emergency` state.
2.  `motor_stop` is asserted.
3.  The current floor does not change while the emergency condition is
    active.
4.  After the emergency condition is cleared, the controller returns to
    the idle state.

## Project Files

``` text
elevator_controller/
│
├── elevator_controller.v
├── tb_elevator_controller.v
└── README.md
```

### `elevator_controller.v`

Contains the RTL implementation of the elevator controller, including:

-   Target-floor selection
-   FSM state register
-   Current-floor register
-   Next-state logic
-   Output logic

### `tb_elevator_controller.v`

Contains the simulation testbench, including:

-   Clock generation
-   Reset sequence
-   Floor movement tests
-   Emergency-stop test
-   Multiple-request test
-   `$monitor` output
-   Simulation completion

## Verification / Test Cases

The testbench verifies the following scenarios:

### Test 1 --- Floor 0 → Floor 3

The elevator receives a request for floor 3 and moves:

``` text
0 → 1 → 2 → 3 → STOP
```

### Test 2 --- Floor 3 → Floor 1

The elevator receives a request for floor 1 and moves:

``` text
3 → 2 → 1 → STOP
```

### Test 3 --- Emergency Stop

The elevator starts moving, then `emergency_stop` is asserted.

Expected behavior:

``` text
Movement → Emergency Stop → Floor remains unchanged
```

### Test 4 --- Multiple Floor Requests

Multiple requests are applied simultaneously to verify the implemented
request priority.

Example:

``` text
floor_req = 1010
```

The controller selects floor 1 according to the implemented priority.

## Simulation Result

The RTL was functionally verified using the testbench.

The simulation confirmed:

-   Correct upward movement
-   Correct downward movement
-   Correct floor tracking
-   Correct stopping at the target floor
-   Correct emergency-stop behavior
-   Correct handling of multiple floor requests

## Tools & Technologies

-   **Verilog HDL**
-   **RTL Design**
-   **Finite State Machine (FSM)**
-   **Digital Logic Design**
-   **Behavioral Simulation**
-   **Vivado / XSim project environment**
-   **Verilog Testbench**

## What I Practiced

Through this project, I worked on:

-   Designing an FSM from a real-world control problem
-   Separating combinational and sequential logic
-   Using registers for state and floor tracking
-   Writing next-state logic
-   Handling external conditions such as emergency stop
-   Creating a functional test environment
-   Debugging RTL and simulation setup issues
-   Understanding how a practical digital controller can be represented
    at RTL

## Future Improvements

Possible extensions include:

-   Door open/close control
-   Door obstruction detection
-   Internal and external floor buttons
-   Request queuing instead of simple priority selection
-   Seven-segment/display interface
-   Floor sensors
-   Timing-based motor control
-   FPGA implementation on a development board
-   Formal assertions and more extensive verification

## Author

**Fiza Parveen**\
Electronics & Communication Engineering

------------------------------------------------------------------------

### Project Summary

This project is a small RTL implementation of an elevator controller
designed to strengthen practical understanding of **Verilog, FSMs,
sequential logic, combinational logic, and digital-system
verification**.
