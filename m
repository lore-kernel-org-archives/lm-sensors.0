From: TheOneAndOnlySM@hot.rr.com (Sandeep Mehta)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: pc87360 sensor-driver results
Message-Id: <40919E45.2050702@hot.rr.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <408B1888.8050802@hot.rr.com>
In-Reply-To: <408B1888.8050802@hot.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

lm_sensors2 cvs 04/29/04 @ 6:00 pm EST

The temperature and voltage monitoring are working just as they have.

For fans, it definitely is strange how this board is handling the fans' 
invertedness, but this cvs seems to have fixed the problem. All the pwm 
files say "255 1" before any of the values are changed.

I can echo new pwm values to pwm1 and pwm2 in the proc entry, and I can 
hear the speeds change. However, no fan speeds are updated; overflow 
flags are still shown when pwm values below 228 are issued and the 
fan#_status file displays "4". Whenever there is an overflow flag, the 
speed is reported as -1.

Pwmconfig is working a lot better now. It creates a correlation list, 
but only for pwm values 255 and 240, then reports "-1" for everything 
else. Strangely, depending on the fan divisor, those 2 correlation 
values either make sense (the first is larger than the second) and 
sometimes it doesn't (the second value is larger).

Here is the pwmconfig output when the fan_div file says "8 8 8"

Found the following PWM controls:
   pc87366-isa-ecc0/pwm1
   pc87366-isa-ecc0/pwm2
   pc87366-isa-ecc0/pwm3

Found the following fan sensors:
   pc87366-isa-ecc0/fan1     current speed: 3750 RPM
   pc87366-isa-ecc0/fan2     current speed: 2222 RPM
   pc87366-isa-ecc0/fan3     current speed: 0 ... skipping!

Warning!!! This program will stop your fans, one at a time,
for approximately 5 seconds each!!!
This may cause your processor temperature to rise!!!
If you do not want to do this hit control-C now!!!
Hit return to continue:

Testing pwm control pc87366-isa-ecc0/pwm1 ...
  pc87366-isa-ecc0/fan1 ... speed was 3750 now -1
    It appears that fan pc87366-isa-ecc0/fan1
    is controlled by pwm pc87366-isa-ecc0/pwm1
Would you like to generate a detailed correlation (y)?
Would you like to generate a graphical plot using gnuplot (y)? n
    PWM 255 FAN 3750
    PWM 240 FAN 3529
    PWM 225 FAN -1
    PWM 210 FAN -1
    PWM 195 FAN -1
    PWM 180 FAN -1
    PWM 165 FAN -1
    PWM 150 FAN -1
    PWM 135 FAN -1
    PWM 120 FAN -1
    PWM 105 FAN -1
    PWM 90 FAN -1
    PWM 75 FAN -1
    PWM 60 FAN -1
    PWM 45 FAN -1
    PWM 30 FAN -1
    PWM 15 FAN -1
    PWM 0 FAN -1

  pc87366-isa-ecc0/fan2 ... speed was 2222 now 2222
    no correlation

Testing pwm control pc87366-isa-ecc0/pwm2 ...
  pc87366-isa-ecc0/fan1 ... speed was 3750 now 3529
    no correlation
  pc87366-isa-ecc0/fan2 ... speed was 2222 now -1
    It appears that fan pc87366-isa-ecc0/fan2
    is controlled by pwm pc87366-isa-ecc0/pwm2
Would you like to generate a detailed correlation (y)?
Would you like to generate a graphical plot using gnuplot (y)? n
    PWM 255 FAN 2222
    PWM 240 FAN 2222
    PWM 225 FAN -1
    PWM 210 FAN -1
    PWM 195 FAN -1
    PWM 180 FAN -1
    PWM 165 FAN -1
    PWM 150 FAN -1
    PWM 135 FAN -1
    PWM 120 FAN -1
    PWM 105 FAN -1
    PWM 90 FAN -1
    PWM 75 FAN -1
    PWM 60 FAN -1
    PWM 45 FAN -1
    PWM 30 FAN -1
    PWM 15 FAN -1
    PWM 0 FAN -1


Testing pwm control pc87366-isa-ecc0/pwm3 ...
  pc87366-isa-ecc0/fan1 ... speed was 3750 now 3750
    no correlation
  pc87366-isa-ecc0/fan2 ... speed was 2222 now 2222
    no correlation

No correlations were detected.
There is either no fan connected to the output of pc87366-isa-ecc0/pwm3,
or the connected fan has no rpm-signal connected to one of
the tested fan sensors. (Note: not all motherboards have
the pwm outputs connected to the fan connectors,
check out the hardware database on http://www.almico.com/forumindex.php)

Did you see/hear a fan stopping during the above test (n)?

Testing is complete.
Please verify that all fans have returned to their normal speed.

And pwmconfig output when fan_div says "1 2 8"

Found the following fan sensors:
   pc87366-isa-ecc0/fan1     current speed: 3692 RPM
   pc87366-isa-ecc0/fan2     current speed: 2162 RPM
   pc87366-isa-ecc0/fan3     current speed: 0 ... skipping!

Warning!!! This program will stop your fans, one at a time,
for approximately 5 seconds each!!!
This may cause your processor temperature to rise!!!
If you do not want to do this hit control-C now!!!
Hit return to continue:

Testing pwm control pc87366-isa-ecc0/pwm1 ...
  pc87366-isa-ecc0/fan1 ... speed was 3692 now -1
    It appears that fan pc87366-isa-ecc0/fan1
    is controlled by pwm pc87366-isa-ecc0/pwm1
Would you like to generate a detailed correlation (y)?
Would you like to generate a graphical plot using gnuplot (y)?
    PWM 255 FAN 3692
    PWM 240 FAN 3692
    PWM 225 FAN -1
    PWM 210 FAN -1
    PWM 195 FAN -1
    PWM 180 FAN -1
    PWM 165 FAN -1
    PWM 150 FAN -1
    PWM 135 FAN -1
    PWM 120 FAN -1
    PWM 105 FAN -1
    PWM 90 FAN -1
    PWM 75 FAN -1
    PWM 60 FAN -1
    PWM 45 FAN -1
    PWM 30 FAN -1
    PWM 15 FAN -1
    PWM 0 FAN -1
    Hit return to continue...

  pc87366-isa-ecc0/fan2 ... speed was 2162 now 2162
    no correlation

Testing pwm control pc87366-isa-ecc0/pwm2 ...
  pc87366-isa-ecc0/fan1 ... speed was 3692 now 3428
    no correlation
  pc87366-isa-ecc0/fan2 ... speed was 2162 now -1
    It appears that fan pc87366-isa-ecc0/fan2
    is controlled by pwm pc87366-isa-ecc0/pwm2
Would you like to generate a detailed correlation (y)?
Would you like to generate a graphical plot using gnuplot (y)? n
    PWM 255 FAN 2162
    PWM 240 FAN 2181
    PWM 225 FAN -1
    PWM 210 FAN -1
    PWM 195 FAN -1
    PWM 180 FAN -1
    PWM 165 FAN -1
    PWM 150 FAN -1
    PWM 135 FAN -1
    PWM 120 FAN -1
    PWM 105 FAN -1
    PWM 90 FAN -1
    PWM 75 FAN -1
    PWM 60 FAN -1
    PWM 45 FAN -1
    PWM 30 FAN -1
    PWM 15 FAN -1
    PWM 0 FAN -1


Testing pwm control pc87366-isa-ecc0/pwm3 ...
  pc87366-isa-ecc0/fan1 ... speed was 3692 now 3692
    no correlation
  pc87366-isa-ecc0/fan2 ... speed was 2162 now 2162
    no correlation

No correlations were detected.
There is either no fan connected to the output of pc87366-isa-ecc0/pwm3,
or the connected fan has no rpm-signal connected to one of
the tested fan sensors. (Note: not all motherboards have
the pwm outputs connected to the fan connectors,
check out the hardware database on http://www.almico.com/forumindex.php)

Did you see/hear a fan stopping during the above test (n)?

Testing is complete.
Please verify that all fans have returned to their normal speed.

Other than this issue, I don't see any other problems.

Output of sensors: (echo 200 > pwm2)

pc87366-isa-ecc0
Adapter: ISA adapter
in0:       +1.58 V  (min =  +0.00 V, max =   0.00 V)
in1:       +1.27 V  (min =  +0.00 V, max =   2.97 V)
in2:       +1.33 V  (min =  +0.00 V, max =   2.97 V)
in3:       +0.09 V  (min =  +0.00 V, max =   0.00 V)
in4:       +1.58 V  (min =  +0.00 V, max =   0.00 V)
in5:       +1.37 V  (min =  +0.00 V, max =   2.97 V)
in6:       +1.41 V  (min =  +0.00 V, max =   2.97 V)
in7:       +1.64 V  (min =  +0.00 V, max =   2.97 V)
in8:       +2.33 V  (min =  +0.00 V, max =   0.00 V)
in9:       +0.00 V  (min =  +0.05 V, max =   0.00 V)
in10:      +1.63 V  (min =  +0.00 V, max =   2.97 V)
fan1:     3692 RPM  (min =    0 RPM, div = 1)
fan2:       -1 RPM  (min =    0 RPM, div = 2)          OVERFLOW
fan3:       -1 RPM  (min =    0 RPM, div = 8)          OVERFLOW
temp1:      -128 C  (low  =   -55 C, high =  +127 C)  ALARM
temp1_crit:
            +127 C
temp2:      -128 C  (low  =   -55 C, high =  +127 C)  ALARM
temp2_crit:
            +127 C
temp3:       +52 C  (low  =   -55 C, high =   +45 C)  ALARM
temp3_crit:
            +127 C


In order to play with fanconfig, I want to be able to see my cpu 
temperature (so I don't burn it out when I turn off the fans for too 
long), so would you know how easy/difficult it would be to get the chip 
to record the cpu temperature the "normal" way, considering it is 
already being monitored using the chip's other channels? If this will 
require soldering, please let me know.

Thanks!
