open Bitstream
open Combinational

(* A circuit represents a collection of registers linked together by
 * combinational logic expressions *)

(* a map with strings as the keys *)
module StringMap : Map.S with type key = string
type 'a map = 'a StringMap.t

(* a type to represent a digital state component *)
type register

(* a type to represent the state of a circuit *)
type circuit

(* [rising_register length logic] is a rising register of length [length]
 * with update logic [logic] *)
val rising_register : int -> comb -> register

(* [falling_register length logic] is a falling register of length [length]
 * with update logic [logic] *)
val falling_register : int -> comb -> register

(* [input length] is a circuit input of length [length] *)
val input : int -> register

(* [output length logic] is a circuit output of length [length]
 * with update logic [logic] *)
val output : int -> comb -> register

(* [circuit regs] is a circuit constructed from the registers named in [regs] *)
val circuit : register map -> circuit

(* formatting function for registers *)
val format_register : Format.formatter -> register -> unit

(* formatting function for circuits *)
val format_circuit : Format.formatter -> circuit -> unit

(* [evaluate circ comb] is the bitstream that results from evaluating
 * [comb] in the context of circuit [circ] *)
val evaluate : circuit -> comb -> bitstream

(* [step circ] is the circuit that results from toggling the state of the clock
 * in [circ] and updating each clocked register *)
val step : circuit -> circuit

(* [step_n circ n] is the circuit that results from stepping [circ] [n] times *)
val step_n : circuit -> int -> circuit

(* [change_input circ in value] is the circuit that results from replacing the
 * value of input [in] in [circ] with [value] and updating and dependent
 * outputs *)
val change_input : circuit -> id -> bitstream -> circuit
