From: osterhues@dercomputerdoktor.com (=?ISO-8859-1?Q?Dirk_gro=DFe_Osterhues?=)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: beeping issues
Message-Id: <3F1E5AD1.4040400@dercomputerdoktor.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030721094037.55d98610.khali@linux-fr.org>
In-Reply-To: <20030721094037.55d98610.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare schrieb:
> Hi folks,
> 
> The three of you reported a similar problem when using lm_sensors. You
> complained about your PC beeping as soon as you load the w83781d module.
> All of you have an Asus motherboard (P4B533, P4B266 and P4S8X,
> respectively) with an AS99127F monitoring chipset.
> 
> We lack documentation about the AS99127F, which explains why we are
> having difficulties understanding why what happens happens.
> 
> I would like you do to some tests to help us find out what the problem
> is. Here is a wishlist:
> 
> 1* The output of sensors (while the PC is beeping).


as99127f-i2c-0-2d
Adapter: SMBus I801 adapter at e800
Algorithm: Non-I2C SMBus adapter
VCore 2:   +1.48 V  (min =  +1.21 V, max =  +1.48 V)
+3.3V:     +3.34 V  (min =  +2.97 V, max =  +3.63 V)
+5V:       +5.04 V  (min =  +4.50 V, max =  +5.48 V)
+12V:     +11.55 V  (min = +10.79 V, max = +13.11 V)
-12V:     -12.08 V  (min =  -0.00 V, max =  -0.00 V)
-5V:       -4.58 V  (min =  -0.00 V, max =  -0.00 V)
temp1:       +40?C  (limit =  +60?C)
temp2:     +39.8?C  (limit =  +67?C, hysteresis =  +60?C)
vid:      +1.350 V
alarms:
beep_enable:
           Sound alarm enabled


> 2* The output of "cat /proc/sys/dev/sensors/as99127f-i2c-0-2d/beep" (or
> whatever the file is at for you).

digo-xp:/proc/sys/dev/sensors/as99127f-i2c-0-2d # cat beep
1 32767

> 3* Does the beeping stop if you echo "0" to that file?

No, and the output stays the same:
digo-xp:/proc/sys/dev/sensors/as99127f-i2c-0-2d # echo "0" >beep
digo-xp:/proc/sys/dev/sensors/as99127f-i2c-0-2d # cat beep
0 32767

> 4* Does the beeping stop if you echo "0 32768" to that file?

As you wrote in your second mail the output should be "0 326767", like 
it was previously.

> 5* Does the beeping stop if you echo "0 0" to that file?

No, it doesn't stop. Output:
digo-xp:/proc/sys/dev/sensors/as99127f-i2c-0-2d # echo "0 0">beep
digo-xp:/proc/sys/dev/sensors/as99127f-i2c-0-2d # cat beep
0 1536

> 6* The output of "cat /proc/sys/dev/sensors/as99127f-i2c-0-2d/alarms"
> (or whatever the file is at for you).

digo-xp:/proc/sys/dev/sensors/as99127f-i2c-0-2d # cat alarms
1

> 7* The output of "i2cdump 0 0x2d" (or whatever the values are supposed
> to be on your system). You better unload w83781d before running this
> command.

digo-xp:/proc/sys/dev/sensors/as99127f-i2c-0-2d # i2cdump 0 0x2d
No size specified (using byte-data access)
   WARNING! This program can confuse your I2C bus, cause data loss and 
worse!
   I will probe file /dev/i2c-0, address 0x2d, mode byte
   You have five seconds to reconsider and press CTRL-C!

      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: bc c0 a3 72 c5 ca 00 cd a7 f8 a5 ac 8c 68 54 f8    ???r??.??????hT?
10: a5 f8 a5 ff 00 00 00 d2 50 4b 31 50 4b 00 00 00    ???....?PK1PK...
20: 5e 5e d1 bc be be be 28 ff ff ff 5d 4c 5d 4c e3    ^^?????(...]L]L?
30: ba cc a8 d8 b2 00 00 00 00 3c 7f e1 e1 e1 00 00    ?????....<????..
40: 01 01 00 00 00 08 00 5e 02 22 01 40 41 00 80 06    ??...?.^?"?@A.??
50: ff ff 00 ff ff ff 00 06 31 8f 00 d5 ff 48 e2 5f    .......?1?.?.H?_
60: 5e 5d d0 bc be be be 28 ff ff ff 5d 4c 5d 4c e3    ^]?????(...]L]L?
70: ba cc a8 d8 b2 00 00 00 00 3c 7f e1 e1 e1 00 00    ?????....<????..
80: bc c0 a2 72 c5 ca 00 cd a7 f8 a5 ac 8c 68 54 f8    ???r??.??????hT?
90: a5 f8 a5 ff 00 00 00 d2 50 4b 31 50 4b 00 00 00    ???....?PK1PK...
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................

> 
> Thanks for your help, I hope we'll find some way to solve the problem. 
> 

Thanks for your support and I'm sorry, that you had to wait a few days.

Best regards,
Dirk.

-- 
Dirk grosse Osterhues  <osterhues@dercomputerdoktor.com>
* Karlstr. 20,  D64283 Darmstadt, Fon (06151)408925, Fax (06151)159729
* Mobil (0179)4795334, http://www.dercomputerdoktor.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 2625 bytes
Desc: S/MIME Cryptographic Signature
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030723/b9799437/smime.bin
