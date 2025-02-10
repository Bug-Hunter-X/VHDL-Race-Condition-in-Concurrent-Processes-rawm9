# VHDL Race Condition Bug Report

This repository demonstrates a race condition bug in a VHDL design.  Two processes attempt to write to a shared signal concurrently without proper synchronization mechanisms (e.g., semaphores, mutexes).  This results in unpredictable output.

The `bug.vhd` file contains the buggy code.  The `bugSolution.vhd` file provides a corrected version of the code using a mutex to ensure mutual exclusion.

## Bug Description

The primary issue is the lack of synchronization between the two concurrent processes, `process_a` and `process_b`.  Both attempt to update the shared signal `shared_signal` simultaneously, leading to undefined behavior, as the final value depends on the execution order, which is nondeterministic in VHDL concurrent processes.

## Solution

The solution uses a mutex (a boolean signal `mutex`) to prevent simultaneous access to `shared_signal`.  Only one process can acquire the mutex at a time, ensuring exclusive access to the shared resource.