From: TheOneAndOnlySM@hot.rr.com (Immanuel Kant)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: pc87360 sensor-driver results
Message-Id: <408B1888.8050802@hot.rr.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I downloaded lm_sensors2 from cvs on 04/24/04 at around 7:30 EST. It 
compiled and installed successfully on a 2.4.26 kernel with i2c 2.8.4. 
The sensors-chip driver for my pc87366 was detected by sensors-detect 
and I can now see output from the driver using gkrellm or by output from 
"sensors". (Full output at the end of document)

My BIOS only displays sensor information about my 2 fans and the 
temperature of my cpu. The fan sensors are accurate, but the I do not 
understand the temperature readings.

Bios reports cpu fan speed of between 3614 and 3840 rpm; sensors reports 
fan 1 to be 3750 rpm
Bios reports case fan to be 2194 rpm; sensors reports 2142 rpm

Oddity: Running pwmconfig will restart both my fans correctly, but 
reports that "fan has not returned to speed". Rerunning sensors states 
that there is an overflow, and the rpm is reported to be -1. Also, I 
only have 2 fans controlled by this nat.semi. chip, but pwmconfig speaks 
strangely of 3 fans, and controllers overlapping. (Output of pwmconfig 
at end of document).

As for temperatures, I am not certain how they are to be read. I do not 
think they are getting updated. Both the closed case and open case 
reveal the exact same temperature (according to gkrellm). I am not sure 
how to use the offset or factor, or how to determine what really is my 
temperature before using those to adjust the numbers.

Here is output of sensors (before pwmconfig):
pc87366-isa-ecc0
Adapter: ISA adapter
in0:       +0.00 V  (min =  +0.07 V, max =   0.00 V)
in1:       +1.36 V  (min =  +0.00 V, max =   2.97 V)
in2:       +1.40 V  (min =  +0.00 V, max =   2.97 V)
in3:       +0.02 V  (min =  +0.00 V, max =   0.05 V)
in4:       +0.00 V  (min =  +0.00 V, max =   0.00 V)
in4:       +0.00 V  (min =  +0.00 V, max =   0.00 V)
in5:       +1.43 V  (min =  +0.00 V, max =   2.97 V)
in6:       +1.46 V  (min =  +0.00 V, max =   2.97 V)
in7:       +1.64 V  (min =  +0.00 V, max =   2.97 V)
in8:       +0.09 V  (min =  +0.00 V, max =   0.00 V)
in9:       +1.58 V  (min =  +0.00 V, max =   0.00 V)
in10:      +1.63 V  (min =  +0.00 V, max =   2.97 V)
fan1:     3529 RPM  (min =    0 RPM, div = 8)
fan2:     2142 RPM  (min =    0 RPM, div = 8)
fan3:       -1 RPM  (min =    0 RPM, div = 8)          OVERFLOW
temp1:       +64 C  (low  =  +201 C, high =    -1 C)  ALARM
temp1_crit:
            +128 C
temp2:       +19 C  (low  =  +201 C, high =    -1 C)
temp2_crit:
            +128 C
temp3:       +19 C  (low  =  +201 C, high =    -1 C)  ALARM
temp3_crit:
             -79 C

Output of Sensors (fans, after pwmconfig)
fan1:       -1 RPM  (min =    0 RPM, div = 8)          OVERFLOW
fan2:       -1 RPM  (min =    0 RPM, div = 8)          OVERFLOW
fan3:       -1 RPM  (min =    0 RPM, div = 8)          OVERFLOW

Output of pwmconfig:
Found the following PWM controls:
   pc87366-isa-ecc0/pwm1
   pc87366-isa-ecc0/pwm2
   pc87366-isa-ecc0/pwm3

Found the following fan sensors:
   pc87366-isa-ecc0/fan1     current speed: 3750 RPM
   pc87366-isa-ecc0/fan2     current speed: 2142 RPM
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
    Fan pc87366-isa-ecc0/fan1 has not returned to speed, please investigate!
  pc87366-isa-ecc0/fan2 ... speed was 2142 now 2142
    no correlation

Testing pwm control pc87366-isa-ecc0/pwm2 ...
  pc87366-isa-ecc0/fan1 ... speed was 3750 now -1
    It appears that fan pc87366-isa-ecc0/fan1
    is controlled by pwm pc87366-isa-ecc0/pwm2
    Fan pc87366-isa-ecc0/fan1 has not returned to speed, please investigate!
  pc87366-isa-ecc0/fan2 ... speed was 2142 now -1
    It appears that fan pc87366-isa-ecc0/fan2
    is controlled by pwm pc87366-isa-ecc0/pwm2
    Fan pc87366-isa-ecc0/fan2 has not returned to speed, please investigate!

Testing pwm control pc87366-isa-ecc0/pwm3 ...
  pc87366-isa-ecc0/fan1 ... speed was 3750 now -1
    It appears that fan pc87366-isa-ecc0/fan1
    is controlled by pwm pc87366-isa-ecc0/pwm3
    Fan pc87366-isa-ecc0/fan1 has not returned to speed, please investigate!
  pc87366-isa-ecc0/fan2 ... speed was 2142 now -1
    It appears that fan pc87366-isa-ecc0/fan2
    is controlled by pwm pc87366-isa-ecc0/pwm3
    Fan pc87366-isa-ecc0/fan2 has not returned to speed, please investigate!

Testing is complete.
Please verify that all fans have returned to their normal speed.

Screenshot of gkrellm with all sensors turned on with default values for 
offset and factor:
http://www.angelfire.com/ny3/mitechnologies/linux/snapshot6.jpeg

If possible, I would like to know if the temperature readings are a bug 
or if there is way to adjust them to display correct temperatures (my 
bios never reads more than about 130 degrees fahrenheit or about 55 
degrees celcius).

Thanks!
