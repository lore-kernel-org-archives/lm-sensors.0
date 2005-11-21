From: johannes.beekhuizen@duinheks.xs4all.nl (johannes.beekhuizen@duinheks.xs4all.nl)
Date: Mon, 21 Nov 2005 16:46:08 +0000
Subject: [lm-sensors] ALARM messages - why ?
Message-Id: <20051121154527.6F4D34BEC5@duinheks.xs4all.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo,

I just installed lm_sensors 2.9.2 on my system. Motherboard
Intel D845EBG2, kernel 2.6.13.4. When I run sensors, I see
two alarms which I don't understand. Does somebody know why
I get them and how I should interpret them?
Thanking you in advance.

Groetjes,

           Hans.

jdh punt beekhuizen bij duinheks punt xs4all punt nl

== import =smsc47m1-isa-0680
Adapter: ISA adapter
fan1:     3150 RPM  (min =  640 RPM, div = 8)
fan2:        0 RPM  (min =  640 RPM, div = 8)

adm1025-i2c-0-2d
Adapter: SMBus I801 adapter at e000
+2.5V:     +1.51 V  (min =  +2.25 V, max =  +2.75 V)   ALARM
VCore:     +1.48 V  (min =  +1.43 V, max =  +1.57 V)
+3.3V:     +3.35 V  (min =  +2.97 V, max =  +3.63 V)
+5V:       +5.05 V  (min =  +4.50 V, max =  +5.50 V)
+12V:      +0.00 V  (min = +10.81 V, max = +13.19 V)   ALARM
VCC:       +3.30 V  (min =  +2.97 V, max =  +3.63 V)
CPU Temp:  +34.0 C  (low  =   +10 C, high =   +60 C)
M/B Temp:  +34.0 C  (low  =   +10 C, high =   +45 C)
vid:      +1.500 V  (VRM Version 9.0)

== tropmi =
--- GoldED+/LNX 1.1.5/050823
 * Origin: The Wizard is using MBSE/Linux (2:280/1018)
