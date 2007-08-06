From: Dawn Light <dawnlight@lavabit.com>
Date: Mon, 06 Aug 2007 07:18:23 +0000
Subject: [lm-sensors] sensors.conf for Abit KN9 Ultra motherboard
Message-Id: <200708060718.23871.dawnlight@lavabit.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Boundary-00=_/sstGCLfi9UQTd6"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--Boundary-00=_/sstGCLfi9UQTd6
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Here's another one. I've posted this one as a ticket before but i've notice=
d it didn't get on the wiki so here it is.
=2D-=20
Dawn Light
=D7=A9=D7=97=D7=A8 =D7=90=D7=95=D7=A8	050-7966664

--Boundary-00=_/sstGCLfi9UQTd6
Content-Type: text/plain;
  charset="utf-8";
  name="sensors.conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sensors.conf"

# "My best guesses at my ABIT KN9 Ultra" Contributed by Dawn Light
# Based on "Winbond W83627EHF configuration originally contributed by Leon Moonen"

chip "w83627ehf-*"

    label in0 "CPU Core"
    label in1 "DDR2"
    label in2 "AVCC"
    label in3 "3VCC"
    label in4 "DDR2 VTT"
    label in5 "PCIE"
    label in6 "ATX +5V"
    label in7 "VSB"
    label in8 "VBAT"
    label in9 "ATX +12V"
    compute in1 @*(1+(10/10)),  @/(1+(10/10))
    compute in6 @*(1+(22/10)),  @/(1+(22/10))
    compute in9 @*(1+(61/10)),  @/(1+(61/10))
    set in0_min   1.15
    set in0_max   1.25
    set in1_min   2.05
    set in1_max   2.15
    set in4_min   0.95
    set in4_max   1.15
    set in5_min   1.50*0.95
    set in5_max   1.50*1.05
    set in6_min   5.0*0.95
    set in6_max   5.0*1.05
    set in9_min   12.0*0.95
    set in9_max   12.0*1.05

# Set the 3.3V
    set in2_min   3.3*0.95
    set in2_max   3.3*1.05
    set in3_min   3.3*0.95
    set in3_max   3.3*1.05
    set in7_min   3.3*0.95
    set in7_max   3.3*1.05
    set in8_min   3.3*0.90
    set in8_max   3.3*1.10

# Fans
   label fan1      "SYS Fan"
   label fan2      "CPU Fan"
   label fan3      "AUX1 Fan"
   label fan4      "AUX2 Fan"
#  ignore fan3
   ignore fan4
   set fan1_min    400
   set fan2_min    2500
   set fan3_min    890

# Temperatures
   label temp1     "Sys Temp"
   label temp2     "CPU Temp"
   label temp3     "PWM Temp"

#  ignore temp3
  set temp1_over  41
  set temp1_hyst  50
  set temp2_over  50
  set temp2_hyst  60
  set temp3_over  50
  set temp3_hyst  60

--Boundary-00=_/sstGCLfi9UQTd6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--Boundary-00=_/sstGCLfi9UQTd6--

