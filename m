From: dolney@astro.physics.upenn.edu (Derek Dolney)
Date: Thu, 19 May 2005 06:23:51 +0000
Subject: Problem with "sensors -s"
Message-Id: <3E7EA3D2.60309@astro.physics.upenn.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I run sensors -s (as root!) and get this message:

----------------------snip-------------------------
it87-isa-0290: Can't access /proc file for writing;
Run as root?
----------------------snip-------------------------

The i2c-proc IS inserted.

I am using lm_sensors-2.7.0. I am using a 2.4.20 kernel patched with 
i2c-2.7.0 support.

Mostly my setup seems to work OK, since sensors gives this output:

it87-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore 1:   +1.76 V  (min =  +1.53 V, max =  +1.87 V)
VCore 2:   +2.48 V  (min =  +2.25 V, max =  +2.75 V)
+3.3V:     +6.52 V  (min =  +2.96 V, max =  +3.60 V)   ALARM
+5V:       +4.99 V  (min =  +4.50 V, max =  +5.48 V)
+12V:     +12.00 V  (min = +11.36 V, max = +13.80 V)
-12V:      -1.13 V  (min = -15.86 V, max = -13.40 V)   ALARM
-5V:       -9.22 V  (min = -10.13 V, max =  -9.44 V)   ALARM
Stdby:     +5.07 V  (min =  +4.50 V, max =  +5.48 V)
VBat:      +3.40 V
fan1:     5443 RPM  (min = 3000 RPM, div = 2)
fan2:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
fan3:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
Temp1/MB:    +11?C  (min =  +20?C, max =  +60?C)
Temp2/CPU:  -108?C  (min =  +20?C, max =  +60?C)
Temp3:       +45?C  (min =  +20?C, max =  +60?C)

But I seem to be limited not being able to do sensors -s.

What should I do? Please help!

-- 
-----------------------------------
Derek M. Dolney
Department of Physics and Astronomy
University of Pennsylvania
dolney@astro.physics.upenn.edu
-----------------------------------
