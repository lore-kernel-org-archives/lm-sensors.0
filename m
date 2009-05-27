From: powah <wong_powah@yahoo.ca>
Date: Wed, 27 May 2009 18:36:58 +0000
Subject: [lm-sensors] false alarm
Message-Id: <loom.20090527T183436-144@post.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The sensors command has this output.
How to determine whether the alarm is valid or false?

# sensors
lm85-i2c-1-2e
Adapter: SMBus I801 adapter at 2020
VCore:      +1.49 V  (min =  +1.45 V, max =  +1.60 V)   ALARM
V3.3:       +3.32 V  (min =  +3.13 V, max =  +3.47 V)
V5:        +5.18 V  (min =  +4.74 V, max =  +5.26 V)
V12:      +11.94 V  (min = +11.38 V, max = +12.62 V)
CPU Fan:   3794 RPM  (min = 4000 RPM)                     ALARM
CPU Temp:    +37 C  (low  =   +10 C, high =   +50 C)
M/B Temp:    +36 C  (low  =   +10 C, high =   +35 C)     ALARM
vid:      +1.525 V    (VRM Version  9.1)



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
