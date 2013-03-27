From: Bryan Guidroz <bryanguidroz@hotmail.com>
Date: Wed, 27 Mar 2013 16:18:13 +0000
Subject: Re: [lm-sensors] MSI MS-9832 Sensor Help
Message-Id: <BLU173-W37F2031468F4945B9C5B22D1D10@phx.gbl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130327083917.040a96de@endymion.delvare>
In-Reply-To: <20130327083917.040a96de@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

First, I can't thank you enough for your help.
I've learned quite a bit and that's always greatly appreciated.

I've read the article and tried to understand it as best as I can.
With your suggestions, the article, and the sample config I found that was =
similar, I've come up with the following config for this system.
I did my best to take multiple samples (5 all together) and so far, everyth=
ing seems to be pretty close.
I also tried to vary the load of the system (using stress to try to raise c=
pu temps and fan speeds.)
Unless you see something that's obviously incorrect or concerning, I think =
I'm gonna go with it.
Really, the biggest differences had to do with Vbat and VSB which I'm now i=
gnoring in my conf.
The BIOS HW monitor always displays Vbat and VSB at 3.42v where sensors has=
 them slightly above or below.
Guessing not a big deal and possibly normal behavior.
And, I realize my layout of this conf is probably not standard, but I put i=
t in the order I was figuring it out with comments (some taken directly fro=
m your replies) to hopefully remind me of things if needed in the future.

-------------------------------------------------------
[root@gateway ~]# nano /etc/sensors.d/MSI-MS-9832.conf
chip "f71882fg-isa-0a10"

# Ignore - Voltage
# The F71882FG uses an 8-bit, 8 mV LSB ADC for voltage monitoring.
# This means that it can measure up to 2.04 V directly. This is the value
# of in2, in3 and in6 on the MSI MS-9832, which means these inputs
# are saturated. This means these inputs are unused.

=A0=A0 ignore in2
=A0=A0 ignore in3
=A0=A0 ignore in6

# Ignore - Fans
# The MSI MS-9832 uses fan1 (CPU Fan) and fan2 (System Fan).
# This means other fans are unused.

=A0=A0 ignore fan3
=A0=A0 ignore fan4

# Ignore - Temps
# The MSI MS-9832 uses temp1 (CPU temp) and temp3 (System temp).
# This means temp2 is unused.

=A0=A0 ignore temp2

# Other - Voltages
# in0 (+3.3v), in7 (3VSB), and in8 (Vbat) are internally monitored voltages
# with internal dividers. This means the values are properly set and do not
# need to be defined in this configuration as they should be reported prope=
rly.

# Voltages
=A0=A0 label in1 "Vcore"
=A0=A0 label in4 "+5V"
=A0=A0 label in5 "+12V"

=A0=A0 compute in4=A0 @*(1+200/47),=A0 @/(1+200/47)
=A0=A0 compute in5=A0 @*(1+200/20),=A0 @/(1+200/20)

=A0=A0 set in1_min=A0 1.2 * 0.95
=A0=A0 set in1_max=A0 1.2 * 1.05
=A0=A0 set in4_min=A0 5.0 * 0.95
=A0=A0 set in4_max=A0 5.0 * 1.05
=A0=A0 set in5_min 12.0 * 0.95
=A0=A0 set in5_max 12.0 * 1.05

# Fans
=A0=A0 label fan1 "CPU Fan"
=A0=A0 label fan2 "Sys Fan"

=A0=A0 set fan1_min 2100
=A0=A0 set fan2_min 1400

# Temperatures
=A0=A0 label temp1 "CPU Temp"
=A0=A0 label temp3 "Sys Temp"

=A0=A0 set temp1_max=A0=A0 60
=A0=A0 set temp1_max_hyst=A0 58
=A0=A0 set temp3_max=A0=A0 50
=A0=A0 set temp3_hyst=A0 48
--------------------------------------------------

Sensors now displays nearly identical results to BIOS HW monitor.

--------------------------------------------------
[root@gateway ~]# sensors
coretemp-isa-0000
Adapter: ISA adapter
Core 0:=A0=A0=A0=A0=A0 +26.0=B0C=A0 (high =3D +70.0=B0C, crit =3D +90.0=B0C=
)=20
Core 1:=A0=A0=A0=A0=A0 +28.0=B0C=A0 (high =3D +70.0=B0C, crit =3D +90.0=B0C=
)=20

f71882fg-isa-0a10
Adapter: ISA adapter
+3.3V:=A0=A0=A0=A0=A0=A0 +3.42 V
Vcore:=A0=A0=A0=A0=A0=A0 +1.16 V=A0 (max =3D=A0 +2.04 V)=A0=20
+5V:=A0=A0=A0=A0=A0=A0=A0=A0 +5.09 V
+12V:=A0=A0=A0=A0=A0=A0 +12.23 V
3VSB:=A0=A0=A0=A0=A0=A0=A0 +3.39 V
Vbat:=A0=A0=A0=A0=A0=A0=A0 +3.41 V
CPU Fan:=A0=A0=A0 4587 RPM
Sys Fan:=A0=A0=A0 2901 RPM
CPU Temp:=A0=A0=A0 +46.0=B0C=A0 (high =3D +85.0=B0C, hyst =3D +81.0=B0C)=20
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (crit =3D +=
100.0=B0C, hyst =3D +96.0=B0C)=A0 sensor =3D transistor
Sys Temp:=A0=A0=A0 +40.0=B0C=A0 (high =3D +70.0=B0C, hyst =3D +68.0=B0C)=20
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (crit =3D +=
85.0=B0C, hyst =3D +83.0=B0C)=A0 sensor =3D transistor
-------------------------------------------------------

Your thoughts?
Thanks


----------------------------------------
> Date: Wed, 27 Mar 2013 08:39:17 +0100
> From: khali@linux-fr.org
> To: bryanguidroz@hotmail.com
> CC: lm-sensors@lm-sensors.org
> Subject: Re: [lm-sensors] MSI MS-9832 Sensor Help
>
> On Tue, 26 Mar 2013 22:21:08 -0500, Bryan Guidroz wrote:
> > I'm about to start on your article, but just wanted to put this out the=
re to be sure I'm heading in the right direction.
> > I rebooted the machine and recorded the following from the BIOS HW moni=
tor:
> >
> > CPU Temp: 51
> > Sys Temp: 37
> > CPU Fan: 4615
> > Sys Fan: 2901
> > CPU Vcore: 1.16
> > 3.3v: 3.424
> > 5v: 5.087
> > 12v 12.232
> > VSB: 3.42
> > VBAT: 3.42
>
> As stated in the article, it is better to gather more than one sample
> per input. For voltages it is the only way to guarantee you get the
> labels and scaling factors right.
>
> > I googled f71882fg-isa-0a10 and came across this to try to help me get =
started.
> > (again, hoping for simplicity)
> > http://www.spinics.net/lists/lm-sensors/msg20054.html
>
> Same board vendor and same chip, but vastly different platform. Thus
> zero guarantee that this configuration file will work for you.
>
> > In the config from that site (no idea if it's valid in any way,) I only=
 modified the Aux Temp and Sys Temp (as it appears they were backwards in m=
y system) and came up with this config.
> > I placed it in /etc/sensors.d/MSI-MS-9832.conf (leaving /etc/sensors3.c=
onf alone)
> >
> > ----------------------------------------------------------------
> > chip "f71882fg-*"
> > # Voltages
> >    label in0 "+3.3V"
> >    label in1 "Vtt1.2V"
> >    label in2 "Vram"
> >    label in3 "Vchip"
> >    label in4 "+5V"
> >    label in5 "+12V"
> >    label in6 "Vcc1.5V"
> >    label in7 "Vcore"
> >    label in8 "5VSB"
> >
> >    # in0 is scaled internally
> >    compute in0  @*2, @*2
> >    compute in2  @*(1+100/100), @/(1+100/100)
> >    compute in3  @*(1+100/47),  @/(1+100/47)
> >    compute in4  @*(1+200/47),  @/(1+200/47)
> >    compute in5  @*(1+200/20),  @/(1+200/20)
> >    compute in8  @*(1+100/46),  @/(1+100/46)
> >
> >    # in0 is the chip's own VCC.
> >    #set in0_min  3.0
> >    #set in0_max  3.6
> >
> >    #set in1_min  1.2 * 0.95
> >    #set in1_max  1.2 * 1.05
> >    #set in2_min  2.5 * 0.95
> >    #set in2_max  2.6 * 1.05
> >    #set in3_min  3.3 * 0.95
> >    #set in3_max  3.3 * 1.05
> >    #set in4_min  5.0 * 0.95
> >    #set in4_max  5.0 * 1.05
> >    #set in5_min 12.0 * 0.95
> >    #set in5_max 12.0 * 1.05
> >    #set in6_min  1.5 * 0.95
> >    #set in6_max  1.5 * 1.05
> >    # in7 nominal value depends on the CPU model
> >    #set in7_min  1.4 * 0.95
> >    #set in7_max  1.4 * 1.05
> >    #set in8_min  5.0 * 0.95
> >    #set in8_max  5.0 * 1.05
> >
> > # Fans
> >    label fan1 "CPU Fan"
> >    label fan2 "Sys Fan"
> >    label fan3 "Aux Fan"
> >
> >    #set fan1_min 2100
> >    #set fan2_min 1400
> >    #set fan3_min 1400
> >    ignore fan3
> >    ignore fan4
> >
> > # Temperatures
> >    label temp1 "CPU Temp"
> >    label temp2 "Aux Temp"
> >    label temp3 "Sys Temp"
> >
> >    set temp1_max   60
> >    set temp1_max_hyst  58
> >    set temp2_max   50
> >    set temp2_max_hyst  48
> >    ignore temp2
> >    set temp3_max   50
> >    set temp3_hyst  48
> > -----------------------------------------------------
> >
> > Now, sensors looks a little better, but still wrong.
>
> I'm not surprised...
>
> > Hoping the article will help me figure this out.
> >
> > -----------------------------------------------------
>
> I recommend that you remove the copied configuration file while you go
> through the article's instructions. Then you can compare your findings
> with what the configuration file was doing, and fix it before putting
> it back.
>
> Note : the F71882FG uses an 8-bit, 8 mV LSB ADC for voltage monitoring.
> This means that it can measure up to 2.04 V directly. This is the value
> of in2, in3 and in6 in your original report, which means these inputs
> are saturated. This means these inputs are unused. So you can start
> your new configuration file with:
>
> chip "f71882fg-isa-0a10"
>
> ignore in2
> ignore in3
> ignore in6
>
> This will simplify your comparison work.
>
> > (...)
> > But, these mb vendors/sensor vendors/whoever need to standardize this.
> > Like... 3.3v should just be 3.3v and CPU temp should just be CPU temp.
> > Guessing there is a good reason it isn't so straight forward that's way=
 beyond my pay grade.
>
> I'm dreaming of something like this. Unfortunately there is no standard
> interface in this area for now.
>
> --
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html 		 	   		 =20
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
