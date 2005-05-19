From: claudio.frizziero@nereal.com (Claudio Frizziero)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: ticket #1626
Message-Id: <1080408107.11029.1448.camel@delta>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thank you for reply (ticket #1626):

> the negative voltages may not be connected, you can ignore them.
> If you changed the sensor type and uncommented the line and then
> ran ?sensors -s? and the tempreature reading didn?t change, I?m
surprised.
> But I don?t know what to tell you to do next, maybe ask the
motherboard
> manufacturer for recommendations or information on how the chip is
connected.
> Sorry we couldn?t help you more.

The temperature reading don't change. I tried to:

1) change sensors type editing sensors.conf:

---

[...]
# Adujst and uncomment the appropriate lines below.
# The old method (modprobe it87 temp_type=0xXX) is no longer supported.
#
# 2 = thermistor; 3 = thermal diode; 0 = unused
   set  sensor1 2
   set  sensor2 2
   set  sensor3 2
[...]

---

2) run sensors -s, and again without any options:

---

[root@radium etc]# sensors -s
[root@radium etc]# sensors
it87-isa-0290
Adapter: ISA adapter
VCore 1:   +1.54 V  (min =  +1.42 V, max =  +1.57 V)
VCore 2:   +2.61 V  (min =  +2.40 V, max =  +2.61 V)   ALARM
+3.3V:     +3.36 V  (min =  +3.14 V, max =  +3.46 V)
+5V:       +4.33 V  (min =  +4.74 V, max =  +5.24 V)   ALARM
+12V:     +12.16 V  (min = +11.40 V, max = +12.60 V)
-12V:     -15.93 V  (min = -12.63 V, max = -11.41 V)   ALARM
-5V:       -8.10 V  (min =  -5.24 V, max =  -4.76 V)   ALARM
Stdby:     +2.74 V  (min =  +4.74 V, max =  +5.24 V)   ALARM
VBat:      +4.08 V
fan1:     2721 RPM  (min =    0 RPM, div = 8)
fan2:        0 RPM  (min = 3013 RPM, div = 8)
fan3:        0 RPM  (min = 3013 RPM, div = 8)          ALARM
M/B Temp:    +25?C  (low  =   +15?C, high =   +40?C)   sensor thermistor
CPU Temp:    +25?C  (low  =   +15?C, high =   +45?C)   sensor thermistor
Temp3:       +74?C  (low  =   +15?C, high =   +45?C)   sensor thermistor

---

3) change sensors type again:

---

[...]
# Adujst and uncomment the appropriate lines below.
# The old method (modprobe it87 temp_type=0xXX) is no longer supported.
#
# 2 = thermistor; 3 = thermal diode; 0 = unused
   set  sensor1 3
   set  sensor2 3
   set  sensor3 3
[...]

---

4) sensors -s and sensors again:

---

[root@radium etc]# sensors -s
[root@radium etc]# sensors
it87-isa-0290
Adapter: ISA adapter
VCore 1:   +1.54 V  (min =  +1.42 V, max =  +1.57 V)
VCore 2:   +2.61 V  (min =  +2.40 V, max =  +2.61 V)   ALARM
+3.3V:     +3.36 V  (min =  +3.14 V, max =  +3.46 V)
+5V:       +4.33 V  (min =  +4.74 V, max =  +5.24 V)   ALARM
+12V:     +12.16 V  (min = +11.40 V, max = +12.60 V)
-12V:     -15.93 V  (min = -12.63 V, max = -11.41 V)   ALARM
-5V:       -8.10 V  (min =  -5.24 V, max =  -4.76 V)   ALARM
Stdby:     +1.92 V  (min =  +4.74 V, max =  +5.24 V)   ALARM
VBat:      +4.08 V
fan1:     2721 RPM  (min =    0 RPM, div = 8)
fan2:        0 RPM  (min = 3013 RPM, div = 8)
fan3:        0 RPM  (min = 3013 RPM, div = 8)          ALARM
M/B Temp:    +25?C  (low  =   +15?C, high =   +40?C)   sensor = diode
CPU Temp:    +25?C  (low  =   +15?C, high =   +45?C)   sensor = diode
Temp3:       +74?C  (low  =   +15?C, high =   +45?C)   sensor = diode

---

I'll try to ask Gigabyte, if I will find useful informations I'll write
you!

Thank you again!

Bye,
    Claudio

