import("stdfaust.lib");

freq = hslider("freq", 440, 50, 2000, 0.1) : si.smoo; // smoo is a specific lowpass for ui inputs
phasor(freq) = (+(freq / ma.SR) ~ ma.frac); // SR = sample rate, frac = get fraction component
osc(freq) = sin(phasor(freq) * 2 * ma.PI);

process =  freq : osc;