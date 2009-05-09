From: Hubert Kario <hka@qbs.com.pl>
Date: Sat, 09 May 2009 10:27:09 +0000
Subject: [lm-sensors] Specific configurations - Gigabyte mainboard
Message-Id: <200905091227.09847.hka@qbs.com.pl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hello everybody!
I've created a mainboard specific configuration for Gigabyte EP45-DS3P:

== snip =chip "it87-*" "it8712-*" "it8716-*" "it8718-*" "it8720-*"

        label in0 "Vcore"
        label in1 "Vram"
        label in2 "+3.3V"

        label in3 "+5V"
	# Standard resistor
        compute in3 @ * ( 6.8/10+1), @ / (6.8/10+1)

        ignore in4

        label in5 "+12V"
	# that's a bit weird, as the value (29.6) is close to typical resistor,
	# but it does give proper results (in line with what a multimeter
	# and BIOS show)
        compute in5 @ * (29.6/10+1), @ / (29.6/10+1)

        ignore in6

	# not sure about this one
        label in7 "5VSB"
        compute in7 @ * (6.8/10+1), @ / (6.8/10+1)

        label in8 "Vbat"

	# labels are after the ones printed on the mainboard
        label fan1 "CPU_FAN"
        label fan2 "SYS_FAN2"
        label fan3 "PWR_FAN"
        label fan4 "SYS_FAN1"

        label temp1 "Sys Temp"
        label temp2 "Tcase Temp"
        ignore temp3
== snip =
Hope it helps!
-- 
Hubert Kario
QBS - Quality Business Software
02-656 Warszawa, ul. Ksawerów 30/85
tel. +48 (22) 646-61-51, 646-74-24
www.qbs.com.pl

System Zarządzania Jakością
zgodny z normą ISO 9001:2000

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
