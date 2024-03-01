# Chaotic spring system

Implementation of chaotic spring system to investigate anticipated synchronization (AS). The chaotic spring system consists of 2 simple harmonic (coupled) oscillators (spring). The coupling strength is determined by a Rössler system.
In order to investigate AS, a system consisting of 3 pairs of springs is implemented.

- Pair 1 : Chaotic springs representing the stimulus (variable `s`).
- Pair 2 : Simple harmonic springs representing the sensory cortex ( variable `c`)
- Pair 3 : Simple harmonic springs representing the (pre)frontal cortex ( variable `f`)


## Description
### Only for visualizing the system
- `cspring_ode.m`:  Continuous version chaotic spring system solved using ode. Best for visualization.
- `cspring_it.m`:  Discreet version chaotic spring system solved iteratively.
### Investigating AS
- `cspring_AS.m`: Proposed AS regime. Stimulus drives sensory cortex. Sensory cortex drives frontal cortex with some delay. Frontal cortex has a self negative time delay.
- `cspring_FF.m`: FeedForward regime. Stimulus drives sensory cortex. Sensory cortex drives frontal cortex with some delay.
- `cspring_FB.m`: FeedBack regime. Stimulus drives sensory cortex. Frontal cortex drives sensory cortex (feedback) with some delay.
