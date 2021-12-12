declare name "Pre-Calculated Wavetable Osc";

import("stdfaust.lib");

//define wavetables
table_size = 512;
sin_wave_table = float(ba.time) * 2 * ma.PI / table_size : sin;

//ui elements
ui_freq = hslider("[0]freq", 440, 50, 2000, 0.1) : si.smoo;

// not used. Would need to be adjusted so the max value is exclusive
table_phasor(freq) = (+(freq / ma.SR) ~ ma.frac) * table_size;

/*
rdtable doesn't seem to interpolate between samples as the index can only be an int.
While the oscilloscope appears smooth, the spectroscope shows various higher harmonics (and lower from aliasing).
*/
sin_osc(freq) = int(os.phasor(table_size, freq)) : rdtable(table_size, sin_wave_table);

wave =  sin_osc(ui_freq);
process = os.osc(ui_freq) * 0.5;