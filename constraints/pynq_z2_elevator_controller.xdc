## PYNQ-Z2 Constraints for 4-Floor Elevator Controller
## Top module: elevator_controller
##
## Board: PYNQ-Z2
## FPGA: XC7Z020-1CLG400C
##
## Inputs:
##   clk             -> 125 MHz onboard clock
##   reset           -> SW0
##   floor_req[0]   -> BTN0
##   floor_req[1]   -> BTN1
##   floor_req[2]   -> BTN2
##   floor_req[3]   -> BTN3
##   emergency_stop  -> SW1
##
## Outputs:
##   move_up         -> LED0
##   move_down       -> LED1
##   motor_stop      -> LED2
##   current_floor[0] -> LED3
##   current_floor[1] -> RGB LED (Blue channel)
##
## IMPORTANT:
## PYNQ-Z2 push-buttons are active-low on the board. The current RTL
## expects active-high request/reset/emergency signals. If programming
## the physical board, input polarity may need to be inverted in RTL
## or through additional logic.

## ============================================================
## Clock - PYNQ-Z2 125 MHz
## ============================================================

set_property -dict {PACKAGE_PIN H16 IOSTANDARD LVCMOS33} [get_ports clk]
create_clock -add -name sys_clk_pin -period 8.000 -waveform {0.000 4.000} [get_ports clk]

## ============================================================
## Switches
## ============================================================

## SW0 -> reset
set_property -dict {PACKAGE_PIN M20 IOSTANDARD LVCMOS33} [get_ports reset]

## SW1 -> emergency_stop
set_property -dict {PACKAGE_PIN M19 IOSTANDARD LVCMOS33} [get_ports emergency_stop]

## ============================================================
## Push Buttons
## ============================================================

## BTN0 -> floor_req[0]
set_property -dict {PACKAGE_PIN D19 IOSTANDARD LVCMOS33} [get_ports {floor_req[0]}]

## BTN1 -> floor_req[1]
set_property -dict {PACKAGE_PIN D20 IOSTANDARD LVCMOS33} [get_ports {floor_req[1]}]

## BTN2 -> floor_req[2]
set_property -dict {PACKAGE_PIN L20 IOSTANDARD LVCMOS33} [get_ports {floor_req[2]}]

## BTN3 -> floor_req[3]
set_property -dict {PACKAGE_PIN L19 IOSTANDARD LVCMOS33} [get_ports {floor_req[3]}]

## ============================================================
## LEDs
## ============================================================

## LED0 -> move_up
set_property -dict {PACKAGE_PIN R14 IOSTANDARD LVCMOS33} [get_ports move_up]

## LED1 -> move_down
set_property -dict {PACKAGE_PIN P14 IOSTANDARD LVCMOS33} [get_ports move_down]

## LED2 -> motor_stop
set_property -dict {PACKAGE_PIN N16 IOSTANDARD LVCMOS33} [get_ports motor_stop]

## LED3 -> current_floor[0]
set_property -dict {PACKAGE_PIN M14 IOSTANDARD LVCMOS33} [get_ports {current_floor[0]}]

## ============================================================
## RGB LED - Blue channel
## current_floor[1]
## ============================================================

set_property -dict {PACKAGE_PIN L15 IOSTANDARD LVCMOS33} [get_ports {current_floor[1]}]
