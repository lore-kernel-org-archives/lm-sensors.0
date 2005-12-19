From: sf@fcse.co.uk (Jeff Fern)
Date: Mon, 19 Dec 2005 15:21:14 +0000
Subject: [lm-sensors] Ticket #2124, K8N-DL Readings
Message-Id: <50277.193.113.58.233.1135005674.squirrel@mail.fcse.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

With regards ticket number 2124, which was replied by Rudolf end of last
week.

The basic problem was with an Asus K8n-DL motherboard. Following Rudolf's
suggestions, I have been able to get virtually all the problems ironed
out, and although there is the w83627thf chip on the board, it does look
like this is useless, and only the w83792d is valid.

There are just 2 values which are being reported incorrectly. Fan1 is
reporting 11250RPM, however the bios is showing only 5554RPM. I have tried
adjusting the div between 2, 4 and 8 however this has not changed the
reading (the output from sensors does show the change in div value).

Also, comparing the voltage outputs from that of sensors, to those in the
bios, with the exception of VIN1, all the inputs appear correct, and do
match up. However the bios shows a reading of +12V, which is not shown in
sensors. The position within the bios screen is at the same place as VIN1
(which reads +3.14V), and the +3.14V does not show anywhere within the
bios - therefore I am assuming this should be +12V but being misread.

Does anyone have any suggestions for fixing these 2 bugs? I have pasted a
copy of my sensors output below.

Many thanks,

-Jeff Fern

jeff at triton:~$ sensors
w83792d-i2c-0-2f
Adapter: SMBus nForce2 adapter at 1c00
VCoreA:    +1.38 V  (min =  +1.40 V, max =  +1.60 V)       ALARM
VCoreB:    +1.39 V  (min =  +1.40 V, max =  +1.60 V)       ALARM
+3.3V:     +3.29 V  (min =  +3.20 V, max =  +3.39 V)
+12V:      +3.14 V  (min =  +3.09 V, max =  +3.30 V)
+1.5V:     +1.50 V  (min =  +1.39 V, max =  +1.49 V)
+2.5V:     +2.52 V  (min =  +2.59 V, max =  +2.64 V)       ALARM
5VCC:      +5.01 V  (min =  +4.73 V, max =  +5.23 V)
5VSB:      +4.99 V  (min =  +4.73 V, max =  +5.23 V)
VBAT:      +3.04 V  (min =  +2.85 V, max =  +3.14 V)
N/bridge: 11250 RPM  (min =    0 RPM, div = 8)
Rear:     2360 RPM  (min =    0 RPM, div = 4)
Pump:     2191 RPM  (min =    0 RPM, div = 4)
System:    +45.0?C  (high = +127.0?C, hyst =  +0.0?C)
CPU1:      +45.0?C  (high = +80.0?C, hyst = +75.0?C)
CPU2:      +45.5?C  (high = +80.0?C, hyst = +75.0?C)





