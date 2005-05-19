From: christophe.dr@free.fr (christophe)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: adt7463 on asus w1n laptop
Message-Id: <200502191801.36808.christophe.dr@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502141545.03330.christophe.dr@free.fr>
In-Reply-To: <200502141545.03330.christophe.dr@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> "i2cdetect 0" will list the addresses on your SMBus. Then use these
> address as parameters to i2cdump. Most likely You need to do "i2cdump 0
> 0x2e".

First, these commands failed because there were no /dev/i2c* files. I solved 
this by inserting the i2c-dev module (also in /etc/sysconfig/lm_sensors). And 
here is the result :

#i2cdetect 0
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0.
  I will probe address range 0x03-0x77.
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX XX XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX UU XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX XX 49 XX XX XX XX XX XX
50: UU UU XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX

#i2cdump 0 0x2e
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x2e, mode byte
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
20: 00 54 c4 7e 00 30 30 2f 14 0b ff ff ff ff ff ff    .T?~.00/??......
30: 4d ff ff 64 64 64 00 00 00 00 00 00 00 27 41 6a    M..ddd.......'Aj
40: 05 8a 01 00 6d 79 96 a6 b6 ca b6 ca b6 ca 1e 3c    ???.my?????????<
50: 14 32 14 32 30 2a ff ff ff ff ff ff e2 e2 e2 a4    ?2?20*......????
60: c4 c4 00 00 40 40 40 32 5a 5a 64 64 64 44 40 00    ??..@@@2ZZdddD@.
70: 00 00 00 10 ef df b4 68 80 00 40 55 00 01 00 00    ...????h?.@U.?..
80: 00 00 00 00 00 00 00 00 00 00 00 30 00 00 00 00    ...........0....
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 30 00 00 00 00 00 00 00 00 00 00 00    ....0...........
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................

#i2cdump 0 0x49
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x49, mode byte
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
90: XX XX 34 XX XX XX XX XX XX XX XX XX XX XX XX XX    XX4XXXXXXXXXXXXX
a0: XX XX XX XX XX XX XX XX XX XX XX 34 XX XX XX XX    XXXXXXXXXXX4XXXX
b0: XX XX XX XX XX XX XX XX XX XX 35 XX XX XX XX XX    XXXXXXXXXX5XXXXX
c0: XX XX XX XX XX XX XX XX XX XX XX XX 34 XX XX XX    XXXXXXXXXXXX4XXX
d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 35    XXXXXXXXXXXXXXX5
e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX

#i2cdump 0 0x69
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x69, mode byte
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????
10: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????
20: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????
30: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????
40: 07 07 07 35 07 07 07 07 07 07 07 07 07 07 07 07    ???5????????????
50: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????
60: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????
70: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????
80: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????
90: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????
a0: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????
b0: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????
c0: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????
d0: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????
e0: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????
f0: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????

I think the adresses 0x50 and 0x51 are for eeprom.

> > OK i realised that /sys/bus/i2c/devices/0-002e/name contains adm1027
> > instead of adt7463. Actually, i don't know which one is right since i
> > can't read the name of a chip that is "jailed" in a laptop.
> Both chips are mostly compatible. Do you have any reason to believe that
> you really have either one? Sometimes manufacturers just put what they
> have available at any given moment, thanks to that compatibility.

Well speedfan on win$ XP says it's an adt7463. And i can't read anything in 
i2cdump consistent.

> That makes sense, but I'd guess the fan only uses 0.5W of power or so.
> If you set the PWM to a 50% duty cycle you'll save 0.25W. Out of the
> 25W your laptop must be consumming, it's not much, only 1%. Still I
> agree that whatever you can save, should be. But actually I think it's
> more interesting for the noise reduction than for the power consumption
> reduction.

True, noise reduction is an interesting issue.

> > Should i use something like :
> > set pwm1_zone 123
> > in /etc/sensors.conf in the appropriate section (lm85 and co...), as
> > explained at the end of your linked document ?
> You may need to. Zones define which temperature sensors determine the
> speed of a given fan. I'd hope that your BIOS already configured the
> zones properly, but maybe not. At any rate, be very careful when chaning
> this. If you configure the zones improperly, the fans may stop speeding
> up properly on temperature increase (obviously), possibly causing
> permanent damage to your hardware!

Ok i've put these lines in /etc/sensors.conf in the lm85 and co section :

set pwm1_zone 123
set pwm1_min_ctl 0
set pwm1_min 0

set temp1_min 20
set temp1_max 60       # dothan's max temp is actually around 100?C
set temp2_min 10
set temp2_max 45
set temp3_min 10
set temp3_max 45

It doesn't seem to set fan speed at a low rpm (not less than 3000 rpm, that's 
too fast) as i expected, but it might be due to my inappropriate settings...
Actuall i read this document :
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/chips/lm85
but did not understand a lot of it...
In spite of my settings the fan1_pwm is always at a minimum of 127, which 
means a little more than 3000 rpm. Quite noisy and "energy-consuming". I can 
only set fan to a lower velocity with this command :
echo 77 > fan1_pwm (for example)
Actually when cpu is very busy, cpu temperature increases and fan speed also. 
When cpu is less busy,  cpu temperature decreases and fan speed also, but 
never below 3000 rpm which corresponds to fan1_pwm7. Never less than 127, 
except if i set it by myself.
In spite of my "set pwm1_zone 123" setting, fan speed does not increase when 
zone 3 has an increase in temperature :zone 3 seems to be the gpu, because it 
gets very hot when i use opengl with a game or a screensaver.

Another problem :
The "sensors" command gives all the informations needed about temperatures, 
fan speed and so on. Running the script "sh /etc/init.d/lm_sensors start" 
shows no errors. No errors too if i run "sensord -i 1m -l 30m". After that, 
what is weird is that i get no line about sensord in a "top" and no line 
about sensord when i run "ps -waux | grep sensord".
This is something i can't explain. It seems that sensord cannot be launched...


Thanks again.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFCF3DvoBxdxgioZBIRAseSAKDXbZKiy0pdZBEv5fAROJSBTGF3xgCgi6fF
syE4DbgdWSEpUYI6Ut1yP0U=L5Be
-----END PGP SIGNATURE-----
