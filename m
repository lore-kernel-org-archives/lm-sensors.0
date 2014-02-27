From: ianp <braveheart_leo@yahoo.com>
Date: Thu, 27 Feb 2014 18:06:50 +0000
Subject: [lm-sensors] Sensors configuration for Asus P5PE-VM motherboard
Message-Id: <1393524410.49402.YahooMailNeo@web160503.mail.bf1.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

I wish to share this configuration if Jean or somebody else could verify wh=
at I have done so far and add this to the wiki.

Here's the default sensors output (only the unconfigured inputs are shown):

$ sensors -u
in1:
=A0 in1_input: 1.856
=A0 in1_min: 2.040
=A0 in1_max: 1.712
=A0 in1_alarm: 1.000
in4:
=A0 in4_input: 1.648
=A0 in4_min: 1.520
=A0 in4_max: 1.680
=A0 in4_alarm: 0.000
in5:
=A0 in5_input: 1.632
=A0 in5_min: 1.488
=A0 in5_max: 1.648
=A0 in5_alarm: 0.000
in6:
=A0 in6_input: 0.184
=A0 in6_min: 1.976
=A0 in6_max: 1.520
=A0 in6_alarm: 1.000
in9:
=A0 in9_input: 0.184
=A0 in9_min: 1.248
=A0 in9_max: 0.872
=A0 in9_alarm: 1.000

For the +12V scaling:

+12V BIOS samples: 12.196, 12.249, 12.302

12.249 - 12.196 =3D 0.053
12.302 - 12.249 =3D 0.053

12.249 / (1+56/10) =3D 1.855909091

1.855909091 is close enough to in1 (1.856)


To verify the scaling factor:


231 * 0.008 * (1+56/10) =3D 12.1968
232 * 0.008 * (1+56/10) =3D 12.2496
233 * 0.008 * (1+56/10) =3D 12.3024

and it almost matches exactly to each BIOS samples. The compute statement f=
or +12V scaling is:

compute=A0 in1=A0 @*(1+56/10), @/(1+56/10)



For the +5V scaling:


+5V BIOS samples: 5.094, 5.145, 5.171, 5.196

5.145 - 5.094 =3D 0.051
5.171 - 5.145 =3D 0.026
5.196 - 5.171 =3D 0.025

(5.196 - 5.094) / (2 + 1 + 1) =3D 0.0255

5.196 / (255/80) =3D 1.630117647

1.614117647 is close enough to in5 (1.632)

But when I tried to verify the scaling factor:

202 * 0.008 * (255/80) =3D 5.151
203 * 0.008 * (255/80) =3D 5.1765
204 * 0.008 * (255/80) =3D 5.202

So I'm not so sure if this is acceptable. If I made a mistake from my above=
 calculations please let me know. The compute statement for +5V scaling is:


compute=A0 in5=A0 @*(255/80), @/(255/80)


And this is the entire configuration:

### Sensors configuration for Asus P5PE-VM motherboard
### 2014-02-28, ianp <snailbox88-dev -at- yahoo -dot- com>
### Comments are welcome.


chip "w83627ehf-*"


### Voltages

=A0=A0 label=A0 in1=A0 "+12V"
=A0=A0 ignore in4=A0=A0=A0=A0=A0=A0=A0=A0=A0 # ignored (not used?)
=A0=A0 label=A0 in5=A0 "+5V"
=A0=A0 ignore in6=A0=A0=A0=A0=A0=A0=A0=A0=A0 # ignore these
=A0=A0 ignore in9=A0=A0=A0=A0=A0=A0=A0=A0=A0 # as well (not used)
=A0=A0 ignore cpu0_vid=A0=A0=A0=A0 # Always at 0 in my case, so ignore it

=A0=A0 ### Scale +5V and +12V.

=A0=A0 compute=A0 in5=A0 @*(255/8), @/(255/80)
=A0=A0 compute=A0 in1=A0 @*(1+56/10), @/(1+56/10)

=A0=A0 ### Set in0 according to CPU nominal voltage.

=A0=A0 set in0_min=A0=A0 1.2000
=A0=A0 set in0_max=A0=A0 1.3375
=A0=A0 set in5_min=A0=A0 5 * 0.95
=A0=A0 set in5_max=A0=A0 5 * 1.05
=A0=A0 set in1_min=A0 12 * 0.95
=A0=A0 set in1_max=A0 12 * 1.05

### Temperatures

=A0=A0 # temp3 is unidentified

=A0=A0 label=A0 temp1=A0 "M/B Temp"
=A0=A0 label=A0 temp2=A0 "CPU Temp"

=A0=A0 ### Set according to preference.

=A0=A0 set temp1_max=A0=A0=A0=A0=A0 60
=A0=A0 set temp1_max_hyst 55
=A0=A0 set temp2_max=A0=A0=A0=A0=A0 60
=A0=A0 set temp2_max_hyst 55

### Fans

=A0=A0 ### Ignore fan3 and fan5. There are
=A0=A0 ### only 2 fan connectors on this board.
=A0=A0 ### fan4 is missing.

=A0=A0 label=A0 fan1=A0 "CHA Fan"
=A0=A0 label=A0 fan2=A0 "CPU Fan"
=A0=A0 ignore fan3
=A0=A0 ignore fan5

=A0=A0 ### Set according to preference.

=A0=A0 set fan1_min 0
=A0=A0 set fan2_min 900

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
