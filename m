From: faza@ansi.pl (Jacek =?iso-8859-2?Q?Zi=F3=B3kowski?=)
Date: Sun, 31 Jul 2005 11:20:17 +0000
Subject: [lm-sensors] smsc47m1 keep reporting 0rpms
Message-Id: <1122808680.18766.16.camel@peanut>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I've got a problem as stated in the subject: smsc47m1 keeps reporting
0rpms on both fans. It detects presence/absence of a fan (it shows an
ALARM when i plug a fan and set divisor to a values below 8) but never
shows actual rpms, despite the fans are working. 
Files 'fanX_input' in /sys/bus/i2c/devices/0-0800/ also report 0rpms.

Any help appreciated.

Tech-info:
I use FedoraCore4 with kernel 2.6.11-1.1369_FC4. The system is an IBM
NetVista (type 6579-PDG) with Intel i815 m/b.

I'm using lm_sensors ver. 2.8.8-5 (from FC4) and i2c from kernel tree.

Sensors-detect also detects lm75.

This is the dump of smsc47m1

isadump -f 0x0800 0x80
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 00 00 00 00 38 6f 01 ff 00 00 00 00 00 00 00 00
10: 02 00 81 df c5 00 00 00 00 00 00 00 00 00 02 00
20: 00 00 00 00 80 01 01 01 01 01 01 00 01 01 00 01
30: 01 01 01 05 05 01 01 00 01 04 04 04 04 84 04 05
40: 05 05 04 05 04 05 04 01 01 00 00 6e 05 0f 00 57
50: 03 00 00 00 00 00 00 00 f0 a4 1c 60 60 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

lsmod | grep i2c reports
i2c_i801                8781  0
i2c_algo_bit            9289  0
i2c_isa                 2241  0
i2c_sensor              3521  2 lm75,smsc47m1
i2c_core               21569  6
lm75,i2c_i801,i2c_algo_bit,smsc47m1,i2c_isa,i2c_sensor

Many thanks in advance!

Jacek

