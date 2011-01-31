From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date: Mon, 31 Jan 2011 17:11:01 +0000
Subject: Re: [lm-sensors] W83795AG on SuperMicro 7046T-NTR+ board
Message-Id: <20110131171101.GE16932@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D44621B.40506@earthlink.net>
In-Reply-To: <4D44621B.40506@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Here is the latest version of my C7X58 config, for reference.  I did
have to ask supermicro for clarifications, to derive a correct formula
for in5.  The first data they sent was bogus.

#
# Data for SuperMicro C7X58 and X8SAX boards, revision 1.1 or 2.0
# Scaling factors kindly provided by SuperMicro support.
# 
# Board has two sensor chips, w83627dhg is not used for temperature,
# fans or voltage sensing.  BIOS allows one to set w83795adg
# parameters, such as voltage or PWM fan control and default strategy.
#

chip "w83795adg-*"

label fan1 "CPU Fan"

label in0  "CPU Core"
label in2  "DIMM"
label in3  "+5V"
label in4  "+12V"
label in5  "-12V"
label in11 "VTT"
label in12 "+3.3V"
label in13 "+3.3Vsb"
label in14 "Vbatt"

label temp6 "System temperature"
label temp7 "CPU temperature"

compute in3 @*4, @/4
compute in4 @*6.62, @/6.62
compute in5 (@-2.048)*24.2 + 2.048, ((@-2.048)/24.2)+2.048

chip "w83627dhg-*"

# SuperIO chip used only for the FDC, UARTs and GPIO
# SENSORS ARE NOT WIRED
# Power Supply Failure, GP31(From W83627DHG-P)    1 = Good, 0 = Bad

ignore fan1
ignore fan2
ignore fan3
ignore fan4
ignore fan5
ignore temp1
ignore temp2
ignore temp3
ignore in0
ignore in1
ignore in2
ignore in3
ignore in4
ignore in5
ignore in6
ignore in7
ignore in8
ignore cpu0_vid

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
