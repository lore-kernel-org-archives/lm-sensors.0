From: "David Mathog" <mathog@caltech.edu>
Date: Tue, 23 Nov 2010 19:19:35 +0000
Subject: [lm-sensors] Supermicro H8DC8 gotcha
Message-Id: <E1PKyOt-0005T4-0b@mendel.bio.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

(Sent to the list without subscribing.)

For a long time I have been running an H8DC8 motherboard with the
adm1026 module loaded, but no corresponding sensors.conf.  Revisited
this issue a couple of days ago and found an h8dc8 sensors.conf on the
lm_sensors site.  Loaded it, it seemed to work, and it appeared that
everything was fine.  But it wasn't.  The BIOS is set to fan control
mode "2" =3D "server mode".  The motherboard adjusts the speed of the 4
system fans to keep the system cool.  With just adm1026 loaded they
mostly hover around 5100 RPM, with a bit of noise but no obvious
oscillation (see below).  Visited the machine room today for the first
time since this change and heard an odd noise, with a 7 second cycle.=20
It turned out to be the H8DC8 system's fans cycling up and down between
5700RPM and 6300RPM.  Reloading the original sensors.conf did not
resolve the problem, but rebooting did, and afterwords loading the
modules but not the sensors.conf put things back as they were before.=20

lm_sensors 2.10.5

These are the modules which are loaded:
MODULE_0=3Di2c-isa
MODULE_1=ADm1026
MODULE_2=3Dk8temp

and this is the problematic sensors.conf file (just the active lines):

chip "adm1026-i2c-*-2c"
  label fan0 "FAN0"
  label fan1 "FAN1"
  label fan2 "FAN2"
  label fan3 "FAN3"
  label fan4 "FAN4"
  label fan5 "FAN5"
  label fan6 "FAN6"
  label fan7 "FAN7"
  set fan0_div 8
  set fan1_div 8
  set fan2_div 8
  set fan3_div 8
  set fan4_div 8
  set fan5_div 8
  set fan6_div 8
  set fan7_div 8
  label in0 "+5VSB"
  compute in0 @*2,@/2
  set in0_min 5*0.90
  set in0_max 5*1.1
  ignore in1
  label in2 "+1.5V"
  set in2_min 1.5*0.95
  set in2_max 1.5*1.05
  label in3 "DIMM"
  set in3_min 2.5*0.95
  set in3_max 2.5*1.05
  ignore in4
  ignore in5
  ignore in6
  label in7 "VCore2"
  set in7_min 1.35*0.95
  set in7_max 1.35*1.05
  ignore in8
  ignore in9
  label in10 "BatV"
  set in10_min 3*0.95
  set in10_max 3*1.05
  label in11 "3.3VSTDBY"
  set in11_min 3.3*0.95
  set in11_max 3.3*1.05
  label in12 "3.3V Main"
  set in12_min 3.3*0.95
  set in12_max 3.3*1.05
  label in13 "+5V"
  set in13_min 5*0.95
  set in13_max 5*1.05
  label in14 "VCore1"
  set in14_min 1.35*0.95
  set in14_max 1.35*1.05
  label in15 "+12V"
  set in15_min 12*0.95
  set in15_max 12*1.05
  label in16 "-12V"
  set in16_max -12*0.95
  set in16_min -12*1.05
  label temp1 "SysTemp"
  set temp1_min 18
  set temp1_max 40
  label temp2 "CPU1Temp"
  set temp2_min 20
  set temp2_max 45
  label temp3 "CPU2Temp"
  set temp3_min 20
  set temp3_max 45

My best guess is that the fan divisor set is the problem, but since this
is my main file server I really don't want to experiment.  With just the
module loaded the system fans read either 5113 or 5273,
and that is noise, not the BIOS adjusting them.  That probably says
something about the default divisor, but I'm not sure what.

Regards,

David Mathog
mathog@caltech.edu
Manager, Sequence Analysis Facility, Biology Division, Caltech

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
