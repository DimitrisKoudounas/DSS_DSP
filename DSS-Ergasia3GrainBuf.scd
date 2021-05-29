s.boot

//////////////////////////////////////The Synth////////////////////////////////////

(
var winenv;

b = Buffer.read(s, Platform.resourceDir +/+ "sounds/a11wlk01-44_1.aiff");
winenv = Env([0, 1, 0], [0.5, 0.5], [8, -8]);
z = Buffer.sendCollection(s, winenv.discretize, 1);


SynthDef(\grain_buf_gui, {|out, gate = 1, amp = 0.1, pan = -1, gdens = 10, gdur = 0.1, rate = 0, pos = 0.1 sndbuf, envbufnum = -1|
    var sig, env, freqdev;
    env = EnvGen.kr(
        Env([0, 1, 0], [1, 1], \sin, 1),
        gate,
        doneAction: Done.freeSelf
		) * amp;
	sig = GrainBuf.ar(2, Impulse.kr(gdens), gdur, sndbuf, rate, pos, 2, pan, envbufnum) * env;
Out.ar(out,sig);

}).add;
)

//////////////////////////////////////The GUI//////////////////////////////////////

(
w = Window("GrainBuf", Rect(750, 50, 400, 310))
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
			x = Synth(\grain_buf_gui).register;
		},
		{x.free}
	);
});

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Slider 1~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
~slider1 = Slider(w, Rect(20, 20, 150, 30))
.action_({
	arg obj1;
	var cf1;
	cf1 = obj1.value.linexp(0, 1, 10, 40).postln;
	if(
		x.isPlaying,
		{x.set(\gdens, cf1)}
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
		{x.set(\gdur, cf2)}
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
		{x.set(\pos, cf4)}
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
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Slider 6~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
~slide6 = Slider(w, Rect(20, 220, 150, 30))
.action_({
	arg obj6;
	var cf6;
	cf6 = obj6.value.linlin(0, 1, -1.0, 1.0).postln;
	if(
		x.isPlaying,
		{x.set(\envbufnum, cf6)}
	);
});
~slLabel6 = StaticText(w, Rect(180, 225, 80, 20))
.string_("EnvBufNum");
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Slider 7~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
~slide7 = Slider(w, Rect(20, 260, 150, 30))
.action_({
	arg obj7;
	var cf7;
	cf7 = obj7.value.range(0.1, 1.0).postln;
	if(
		x.isPlaying,
		{x.set(\amp, cf7)}
	);
});
~slLabel7 = StaticText(w, Rect(180, 265, 80, 20))
.string_("Amplitude");
)

