From: ianp <braveheart_leo@yahoo.com>
Date: Thu, 20 Feb 2014 18:29:42 +0000
Subject: [lm-sensors] Sensors configuration for Gigabyte GA-945GCM-S2L
Message-Id: <1392920982.2747.YahooMailNeo@web160506.mail.bf1.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

### Sensors configuration for Gigabyte GA-945GCM-S2L motherboard
### 2014-02-21, ianp <snailbox88-dev -at- yahoo -dot- com>
### Thanks to Jean Delvare
### Comments are welcome.


chip "it8718-*"

### Voltages

=A0=A0 label=A0 in0=A0 "Vcore"
=A0=A0 label=A0 in1=A0 "Vram"=A0=A0=A0 # "DDR18V" in BIOS
=A0=A0 label=A0 in2=A0 "+3.3V"
=A0=A0 ignore in3=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 # no +5V monitor, not us=
ed
=A0=A0 label=A0 in4=A0 "+12V"
=A0=A0 ignore in5=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 # these inputs
=A0=A0 ignore in6=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 # are not used
=A0=A0 ignore in7=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 # by the board

=A0=A0 ### Scale +12V.

=A0=A0 compute=A0 in4=A0 @*3.9633,=A0 @/3.9633

=A0=A0 ### Set in0 according to CPU VID voltage range.
=A0=A0 ### Set min and max values according to preference.

=A0=A0 set in0_min=A0 0.850
=A0=A0 set in0_max=A0 1.362
=A0=A0 set in1_min=A0 1.8
=A0=A0 set in1_max=A0 1.9
=A0=A0 set in2_min=A0 3.3 * 0.95
=A0=A0 set in2_max=A0 3.3 * 1.05
=A0=A0 set in4_min=A0=A0 12 * 0.95
=A0=A0 set in4_max=A0=A0 12 * 1.05

### Temperatures

=A0=A0 ### Ignore temp1 and temp2 as those aren't used.

=A0=A0 ignore temp1
=A0=A0 ignore temp2
=A0=A0 label=A0 temp3=A0 "CPU Temp"

=A0=A0 ### Set according to CPU.

=A0=A0 set temp3_min 20
=A0=A0 set temp3_max 55

### Fans

=A0=A0 ### Ignore fan3 as it isn't used.

=A0=A0 label=A0 fan1=A0 "CPU Fan"
=A0=A0 label=A0 fan2=A0 "CHA Fan"
=A0=A0 ignore fan3

=A0=A0 ### Set according to preference.

=A0=A0 set fan1_min 900
=A0=A0 set fan2_min 0

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
