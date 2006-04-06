From: jo.lodewyckx@edpnet.be (Jo Lodewyckx)
Date: Thu, 06 Apr 2006 11:21:52 +0000
Subject: [lm-sensors] ali1563 problems
Message-Id: <000001c6596c$50f0b490$937ba8c0@genesis>
List-Id: <lm-sensors.vger.kernel.org>
References: <000001c657ef$bd81d2c0$937ba8c0@genesis>
In-Reply-To: <000001c657ef$bd81d2c0$937ba8c0@genesis>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Thank you very much!
That was indeed the problem.
I upgraded to the unstable hardened kernel (2.6.16-hardened) and the problem
was solved.

regawebdev jo # sensors
w83627hf-isa-0290
Adapter: ISA adapter
VCore 1:   +1.46 V  (min =  +0.00 V, max =  +0.00 V)       ALARM
VCore 2:   +1.49 V  (min =  +0.00 V, max =  +0.00 V)       ALARM
+3.3V:     +3.28 V  (min =  +3.14 V, max =  +3.47 V)
+5V:       +5.03 V  (min =  +4.76 V, max =  +5.24 V)
+12V:     +12.10 V  (min = +10.82 V, max = +13.19 V)
-12V:      +1.46 V  (min = -13.18 V, max = -10.80 V)       ALARM
-5V:       +2.34 V  (min =  -5.25 V, max =  -4.75 V)       ALARM
V5SB:      +5.64 V  (min =  +4.76 V, max =  +5.24 V)       ALARM
VBat:      +3.25 V  (min =  +2.40 V, max =  +3.60 V)
fan1:     2909 RPM  (min = 2163 RPM, div = 8)
fan2:     3245 RPM  (min = 2812 RPM, div = 8)
fan3:        0 RPM  (min =    0 RPM, div = 2)
temp1:       +26 C  (high =   +51 C, hyst =  +120 C)   sensor = thermistor

temp2:     +31.5 C  (high =   +80 C, hyst =   +75 C)   sensor = thermistor

temp3:     +30.5 C  (high =   +80 C, hyst =   +75 C)   sensor = thermistor

vid:      +0.000 V  (VRM Version 2.4)
alarms:
beep_enable:
          Sound alarm enabled


