From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date: Sat, 02 Oct 2010 02:41:01 +0000
Subject: [lm-sensors] W38795ADG sensors.conf for SuperMicro C7X58/X8SAX
Message-Id: <20101002024101.GA6862@khazad-dum.debian.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="r5Pyd7+fXNt84Ff3"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Please add this to the lm-sensors wiki, and any relevant userspace config
files being shipped in lm-sensors userspace.

The BIOS does not set the correct limits for VTT, but it is wired.

I still haven't found how the PWM outputs are wired in this board, though,
due to my mix of PWM and non-PWM fans I cannot enable fan control.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="01_SuperMicro_C7X58.conf"

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

--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--r5Pyd7+fXNt84Ff3--
