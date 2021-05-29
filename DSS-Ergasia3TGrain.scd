s.boot

/////////////////////////////////////The Synth/////////////////////////////////////

(
b = Buffer.read(s, Platform.resourceDir +/+ "sounds/a11wlk01.wav");

SynthDef(\t_grain_gui, {|out, amp = 0.1, rate = 0, pan = -1, dur = 0.1, dens = 10, centerPos = 0.1|
	var sig;
	sig = TGrains.ar(2, Impulse.kr(dens), 0, rate, centerPos, dur, pan, amp, 2);
	Out.ar(out, sig);
}).add;
)

//////////////////////////////////////The GUI//////////////////////////////////////

(
w = Window("TGrain", Rect(700, 50, 400, 270))
.front
.alwaysOnTop_(true);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~The Button~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
~button = Button(w, Rect(300, 20, 70, 50))
.states_([
	["STOP", Color.black, Color.gray(0.8)],
	["START", Color.white, Color(0.2, 0.75, 0.95)]
])
.action_({
	arg obj;
	if(
		obj.value == 1,
		{
			x = Synth(\t_grain_gui).register;
		},
		{x.free}
	);
});

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Slider 1~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

~slider1 = Slider(w, Rect(20, 20, 150, 30))
.action_({
	arg obj1;
	var cf1;
	cf1 = obj1.value.linexp(0, 1, 10, 100).postln;
	if(
		x.isPlaying,
		{x.set(\dens, cf1)}
	);
});
~slLabel1 = StaticText(w, Rect(180, 25, 80, 20))
.string_("Density");

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Slider 2~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

~slider2 = Slider(w, Rect(20, 60, 150, 30))
.action_({
	arg obj2;
	var cf2;
	cf2 = obj2.value.linexp(0, 1, 0.1, 1.0).postln;
	if(
		x.isPlaying,
		{x.set(\dur, cf2)}
	);
});
~slLabel2 = StaticText(w, Rect(180, 65, 80, 20))
.string_("Duration");

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Slider 3~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

~slider3 = Slider(w, Rect(20, 100, 150, 30))
.action_({
	arg obj3;
	var cf3;
	cf3 = obj3.value(0.0, 1.0).postln;
	if(
		x.isPlaying,
		{x.set(\rate, cf3)}
	);
});
~slLabel3 = StaticText(w, Rect(180, 105, 80, 20))
.string_("Rate");


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Slider 4~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

~slider4 = Slider(w, Rect(20, 140, 150, 30))
.action_({
	arg obj4;
	var cf4;
	cf4 = obj4.value(0.0, 1.0).postln;
	if(
		x.isPlaying,
		{x.set(\centerPos, cf4)}
	);
});
~slLabel4 = StaticText(w, Rect(180, 145, 80, 20))
.string_("Position");

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Slider 5~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

~slider5 = Slider(w, Rect(20, 180, 150, 30))
.action_({
	arg obj5;
	var cf5;
	cf5 = obj5.value.range(-1.0, 1.0).postln;
	if(
		x.isPlaying,
		{x.set(\pan, cf5)}
	);
});
~alLabel5 = StaticText(w, Rect(180, 185, 80, 20))
.string_("Pan");

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`Slider 6~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

~slide6 = Slider(w, Rect(20, 220, 150, 30))
.action_({
	arg obj7;
	var cf7;
	cf7 = obj7.value.range(0.1, 1.0).postln;
	if(
		x.isPlaying,
		{x.set(\amp, cf7)}
	);
});
~slLabel6 = StaticText(w, Rect(180, 225, 80, 20))
.string_("Amplitude");
)

