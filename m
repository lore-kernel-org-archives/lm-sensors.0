From: TheOneAndOnlySM@hot.rr.com (Immanuel Kant)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: pc87360 sensor-driver results
Message-Id: <408C6B9A.1080701@hot.rr.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <408B1888.8050802@hot.rr.com>
In-Reply-To: <408B1888.8050802@hot.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

lm_sensors2 cvs 04/25/04 @ 8:30 est

I haven't been able to notice any changes from yesterday's cvs, but I 
probably don't know exactly what to look for.

I cat'ed around in my /proc/sys/dev/sensors/pc87366-isa-ecc0 area, and 
the temperatures reported seem to be accurate farhenheit temperatures, 
but I don't know if this is coincidence.
My bios only shows 1 temperature reading, and it says exactly: CPU 
Temperature  46 C / 114.5 F (and the numbers keep rising).

Here are the outputs of the isadumps:
output of isadump 0x2e 0x2f 0x09 7
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 00 00 00 00 00 00 00 09 00 00 00 00 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: e9 15 bd a3 35 01 00 0a 00 00 0a 43 07 59 00 00
30: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: ec c0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 03 00 00 04 04 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: fc 07 07 00 00 00 00 00 00 00 00 00 00 00 00 00

output of isadump 0x2e 0x2f 0x0d 7
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 00 00 00 00 00 00 00 0d 00 00 00 00 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: e9 15 bd a3 35 01 00 0a 00 00 0a 43 07 59 00 00
30: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: ec d0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 03 00 00 04 04 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

output of isadump 0x2e 0x2f 0x0e 7
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 00 00 00 00 00 00 00 0e 00 00 00 00 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: e9 15 bd a3 35 01 00 0a 00 00 0a 43 07 59 00 00
30: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: ec f0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 03 00 00 04 04 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

output of isadump -f 0xecc0
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 80 31 00 1a ff ff 00 10 00 00 00 00 00 00 3f 1b
10: 00 00 00 00 00 00 00 00 00 00 04 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
80: ff 10 00 00 df 12 00 00 ff 00 1f 04 00 00 00 00
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: 00 ff 00 ff 00 ff a0 00 04 a0 00 26 ff 00 64 00
d0: 00 00 00 00 00 00 1f 05 02 0a 81 8c ff 00 00 00
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
f0: 05 00 00 00 00 00 00 00 02 02 81 34 7f c9 7f 00

output of isadump -f 0xecd0
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 80 31 00 1a ff ff 00 10 00 00 00 00 00 00 3f 1b
10: 00 00 00 00 00 00 00 00 00 00 04 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
80: ff 10 00 00 df 12 00 00 ff 00 1f 04 00 00 00 00
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: 00 ff 00 ff 00 ff a0 00 04 a0 00 26 ff 00 64 00
d0: 00 00 00 00 00 00 1f 05 02 0a 81 8d ff 00 00 00
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
f0: 05 00 00 00 00 00 00 00 02 02 81 34 7f c9 7f 00

output of isadump -f 0xecf0
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 80 31 00 1a ff ff 00 10 00 00 00 00 00 00 3f 1b
10: 00 00 00 00 00 00 00 00 00 00 04 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
80: ff 10 00 00 df 12 00 00 ff 00 1f 04 00 00 00 00
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: 00 ff 00 ff 00 ff a0 00 04 a0 00 26 ff 00 64 00
d0: 00 00 00 00 00 00 1f 05 02 0a 81 8c ff 00 00 00
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
f0: 05 00 00 00 00 00 00 00 02 02 81 33 7f c9 7f 00

I used the echo command to set the fan divisors for fans 1 and 2 to 1 2. 
I get more updates, and they are very close to what my bios reports:
CPU Fan Speed   3614RPM
System Fan Speed 2194RPM

I also tried echoing minimum values for these fans (3000 and 1500 for 
fans 1 and 2) but nothing changed in sensors, but the proc entries for 
fan1 and fan2 did get updated. I echoed a value of 3000 for fan2, but 
only the proc fan2 file got updated, and no physical change (I was 
guessing that if I upped the minimum value, i could increase the speed). 
It might already be at a maxed out speed, so is there a way to test the 
fans by decreasing the speed?

pwmconfig can still turn off the fans, but there are still overflow 
messages in "sensors" and they don't go away (I left the computer idle 
for about half an hour to see if there would be any change).

here is the full output of sensors:
pc87366-isa-ecc0
Adapter: ISA adapter
in0:       +0.00 V  (min =  +0.00 V, max =   0.00 V)
in1:       +1.26 V  (min =  +0.00 V, max =   2.97 V)
in2:       +1.34 V  (min =  +0.00 V, max =   2.97 V)
in3:       +0.00 V  (min =  +0.00 V, max =   0.00 V)
in4:       +0.00 V  (min =  +0.00 V, max =   0.00 V)
in4:       +0.00 V  (min =  +0.00 V, max =   0.00 V)
in5:       +1.37 V  (min =  +0.00 V, max =   2.97 V)
in6:       +1.41 V  (min =  +0.00 V, max =   2.97 V)
in7:       +1.65 V  (min =  +0.00 V, max =   2.97 V)
in8:       +0.00 V  (min =  +0.00 V, max =   0.00 V)
in9:       +0.00 V  (min =  +0.00 V, max =   0.00 V)
in10:      +1.64 V  (min =  +0.00 V, max =   2.97 V)
fan1:     3692 RPM  (min =    0 RPM, div = 1)
fan2:     2162 RPM  (min =    0 RPM, div = 2)
fan3:       -1 RPM  (min =    0 RPM, div = 8)          OVERFLOW
temp1:      +128 C  (low  =  +201 C, high =    -1 C)
temp1_crit:
            +201 C
temp2:      +128 C  (low  =  +201 C, high =    -1 C)
temp2_crit:
            +201 C
temp3:       -76 C  (low  =  +201 C, high =    -1 C)
temp3_crit:
            +201 C

output of cat temp1
-1 201 201 128

temp1_status
131

temp2
-1 201 201 128

temp2_status
131

temp3
-1 201 201 -76

temp3_status
129

I am wondering where all this chip is measuring the temperature; my bios 
reports only the cpu temp. Once again, I am not sure if these readings 
above are correct (for farhenheit) or just a coincidental bug.

I am going to go and see if there is a bios update for my motherboard 
(my bios is an AwardBios on an Asus board) so that I can see other 
sensor readings.

If there is anything specific you guys would like me to do, I will 
gladly see to it.
