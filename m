From: pavouk@pavouk.org (Pavel Ruzicka)
Date: Mon, 07 Nov 2005 00:18:17 +0000
Subject: [lm-sensors] ATI SMBus - new information
Message-Id: <200511070016.55492.pavouk@pavouk.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <435A1BA9.9080009@sh.cvut.cz>
In-Reply-To: <435A1BA9.9080009@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

> 10:41 < khali> on SMBus we have temperature and voltage monitoring

On my system from MSI RS480M2-IL with LPC47M997 is supported only
CPU and SYSTEM temperature reading. Voltage reading is not supported in a 
hardware monitoring section of SMSC chip.

> i2cdump 0 0x2d
>
> Should give you a register dump.

Here is my actual dump:
----------------------
[root@home ~]# i2cdump 0 0x2d
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c/0, address 0x2d, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX 50 02    XXXXXXXXXXXXXXP?
20: 00 00 00 00 87 c4 2f 23 XX XX XX ff 00 ff 00 ff    ....??/#XXX.....
30: 00 ff 00 ff 00 ff 00 3a 80 7f 80 XX XX XX 55 20    .......:???XXXU
40: 29 0f 0c XX XX XX XX 00 XX 80 00 02 00 00 XX 04    )??XXXX.X?.?..X?
50: 00 00 74 XX ff 00 ff 00 7f 80 XX XX XX XX XX XX    ..tX....??XXXXXX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
----------------------

> Datasheet is here
> http://www.smsc.com/main/tools/discontinued/47m15x.pdf

Registers are same on my system with LPC47M997.

> Now please read the value on offset 0x31 (5V high limit) and add one to it
> and write it back to chip
>
> i2cset 0 0x2d 0x31 0xyourvall
> Readback should match.

It works for me. But voltage measuring is not available on my system.
I tried other offsets with R/W registers and they worked too.

Here is interesting registers of my chip:
0x26 Remote Diode Temperature Reading 1	(CPU temperature) Value 0x30 48 C
0x27 Ambient Temperature Reading	(System temperature) Value 0x24 36 C
0x37 Remote Temperature High Limit 1 Value 0x3c 60 C
0x38 Remote Temperature Low Limit 1 Value 0x80 128 C
0x39 Remote Temperature High Limit 1 Value 0x7f 127 C
0x3A Remote Temperature Low Limit 1 Value 0x80 128 C

These temperatures are probably in a Celsius. They are changing when I load
processor. They look good and identical to BIOS and Winblows measuring tool.

Register 0x37 is possible to change in a BIOS.

I don't understand how limits works on a 0x37 to 0x3A offsets.
Can you point me to a documentation or a little explain, how they works? ;-)

Thanks.

Best regards,

Pavel Ruzicka
