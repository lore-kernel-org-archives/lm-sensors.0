From: gbhatia@persistcorp.com (Gagan Bhatia)
Date: Thu, 19 May 2005 06:23:32 +0000
Subject: sensor shows 0 values
Message-Id: <3CDC7E68.20504@persistcorp.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi ,
  Please help newbie. I have read your FAQ but couldnt find the solution 
of this problem.

I have installed lm_sensors and i2c package. kernel version- 2.4.9
I run sensors -s and sensors and get ) values for all the variables.

Please tell me what am I doing wrong ???

Thanks
Gagan
Below is the result from sensor command:
lm84-i2c-2-18
Adapter: Velleman K8000
Algorithm: Bit-shift algorithm
Board:        +0?C  (min =   +0?C, max =   +0?C)
CPU:          +0?C  (min =   +0?C, max =   +0?C)

lm84-i2c-2-19
Adapter: Velleman K8000
Algorithm: Bit-shift algorithm
Board:        +0?C  (min =   +0?C, max =   +0?C)
CPU:          +0?C  (min =   +0?C, max =   +0?C)

lm84-i2c-2-1a
Adapter: Velleman K8000
Algorithm: Bit-shift algorithm
Board:        +0?C  (min =   +0?C, max =   +0?C)
CPU:          +0?C  (min =   +0?C, max =   +0?C)

lm84-i2c-2-29
Adapter: Velleman K8000
Algorithm: Bit-shift algorithm
Board:        +0?C  (min =   +0?C, max =   +0?C)
CPU:          +0?C  (min =   +0?C, max =   +0?C)

lm84-i2c-2-2a
Adapter: Velleman K8000
Algorithm: Bit-shift algorithm
Board:        +0?C  (min =   +0?C, max =   +0?C)
CPU:          +0?C  (min =   +0?C, max =   +0?C)

lm84-i2c-2-2b
Adapter: Velleman K8000
Algorithm: Bit-shift algorithm
Board:        +0?C  (min =   +0?C, max =   +0?C)
CPU:          +0?C  (min =   +0?C, max =   +0?C)

lm84-i2c-2-4c
Adapter: Velleman K8000
Algorithm: Bit-shift algorithm
Board:        +0?C  (min =   +0?C, max =   +0?C)
CPU:          +0?C  (min =   +0?C, max =   +0?C)

lm84-i2c-2-4d
Adapter: Velleman K8000
Algorithm: Bit-shift algorithm
Board:        +0?C  (min =   +0?C, max =   +0?C)
CPU:          +0?C  (min =   +0?C, max =   +0?C)

lm84-i2c-2-4e
Adapter: Velleman K8000
Algorithm: Bit-shift algorithm
Board:        +0?C  (min =   +0?C, max =   +0?C)
CPU:          +0?C  (min =   +0?C, max =   +0?C)

lm80-i2c-2-20
Adapter: Velleman K8000
Algorithm: Bit-shift algorithmVTT:       +0.00 V  (min =  +0.00 V, max 
=  +0.00 V)
+3.3V:     +0.00 V  (min =  +0.00 V, max =  +0.00 V)
+Vcore:    +0.00 V  (min =  +0.00 V, max =  +0.00 V)
+12V:      +0.00 V  (min =  +0.00 V, max =  +0.00 V)
-12V:      +0.00 V  (min =  +0.00 V, max =  +0.00 V)
-5V:       +0.00 V  (min =  +0.00 V, max =  +0.00 V)
fan1:       -1 RPM  (min =   -1 RPM, div = 1)
fan2:       -1 RPM  (min =   -1 RPM, div = 1)
temp:     +0.00 ?C (hot:limit =  +0?C,  hysteresis =  +0?C)
         (os: limit =  +0?C,  hysteresis =  +0?C)

lm80-i2c-2-21
Adapter: Velleman K8000
Algorithm: Bit-shift algorithm
+5V:       +0.00 V  (min =  +0.00 V, max =  +0.00 V)
VTT:       +0.00 V  (min =  +0.00 V, max =  +0.00 V)
+3.3V:     +0.00 V  (min =  +0.00 V, max =  +0.00 V)
+Vcore:    +0.00 V  (min =  +0.00 V, max =  +0.00 V)
+12V:      +0.00 V  (min =  +0.00 V, max =  +0.00 V)
-12V:      +0.00 V  (min =  +0.00 V, max =  +0.00 V)
-5V:       +0.00 V  (min =  +0.00 V, max =  +0.00 V)
fan1:       -1 RPM  (min =   -1 RPM, div = 1)
fan2:       -1 RPM  (min =   -1 RPM, div = 1)
temp:     +0.00 ?C (hot:limit =  +0?C,  hysteresis =  +0?C)
         (os: limit =  +0?C,  hysteresis =  +0?C)

lm80-i2c-2-22
Adapter: Velleman K8000
Algorithm: Bit-shift algorithm
+5V:       +0.00 V  (min =  +0.00 V, max =  +0.00 V)
VTT:       +0.00 V  (min =  +0.00 V, max =  +0.00 V)
+3.3V:     +0.00 V  (min =  +0.00 V, max =  +0.00 V)
+Vcore:    +0.00 V  (min =  +0.00 V, max =  +0.00 V)
+12V:      +0.00 V  (min =  +0.00 V, max =  +0.00 V)
-12V:      +0.00 V  (min =  +0.00 V, max =  +0.00 V)
-5V:       +0.00 V  (min =  +0.00 V, max =  +0.00 V)
fan1:       -1 RPM  (min =   -1 RPM, div = 1)
fan2:       -1 RPM  (min =   -1 RPM, div = 1)
temp:     +0.00 ?C (hot:limit =  +0?C,  hysteresis =  +0?C)
         (os: limit =  +0?C,  hysteresis =  +0?C)

lm80-i2c-2-23
Adapter: Velleman K8000
Algorithm: Bit-shift algorithm
+5V:       +0.00 V  (min =  +0.00 V, max =  +0.00 V)
VTT:       +0.00 V  (min =  +0.00 V, max =  +0.00 V)
+3.3V:     +0.00 V  (min =  +0.00 V, max =  +0.00 V)
+Vcore:    +0.00 V  (min =  +0.00 V, max =  +0.00 V)
+12V:      +0.00 V  (min =  +0.00 V, max =  +0.00 V)
-12V:      +0.00 V  (min =  +0.00 V, max =  +0.00 V)
-5V:       +0.00 V  (min =  +0.00 V, max =  +0.00 V)
fan1:       -1 RPM  (min =   -1 RPM, div = 1)
fan2:       -1 RPM  (min =   -1 RPM, div = 1)
temp:     +0.00 ?C (hot:limit =  +0?C,  hysteresis =  +0?C)
         (os: limit =  +0?C,  hysteresis =  +0?C)

lm80-i2c-2-24
Adapter: Velleman K8000

+5V:       +0.00 V  (min =  +0.00 V, max =  +0.00 V)



............
