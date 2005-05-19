From: janl@langfeldt.net (Nicolai Langfeldt)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: lmsensors on Abit IC7-G
Message-Id: <3FBB0C89.7080502@langfeldt.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FB92482.2070306@langfeldt.net>
In-Reply-To: <3FB92482.2070306@langfeldt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
>>MODULE_0=3Di2c-i801
>>MODULE_1=3Dlm80
>>MODULE_2=EEprom
>># sensors
>>lm80-i2c-0-2e
>>Adapter: SMBus I801 adapter at 0500
>>Algorithm: Non-I2C SMBus adapter
>>+5V:       +6.71 V  (min =3D  +6.71 V, max =3D  +6.71 V)
>>VTT:       +2.55 V  (min =3D  +2.55 V, max =3D  +2.55 V)
>>+3.3V:     +4.43 V  (min =3D  +4.43 V, max =3D  +4.43 V)
>>+Vcore:    +3.76 V  (min =3D  +3.76 V, max =3D  +3.76 V)   ALARM
>>+12V:     +16.10 V  (min =3D +16.10 V, max =3D +16.10 V)
>>-12V:     -16.11 V  (min =3D -16.11 V, max =3D -16.11 V)
>>-5V:       -6.70 V  (min =3D  -6.70 V, max =3D  -6.70 V)
>>fan1:        0 RPM  (min =3D    0 RPM, div =3D 1)
>>fan2:        0 RPM  (min =3D    0 RPM, div =3D 1)
>>temp:     -1.00 ?C (hot:limit =3D  -1?C,  hysteresis =3D  -1?C)
>>          (os: limit =3D  -1?C,  hysteresis =3D  -1?C)
>>alarms:   Board temperature input (LM75)               ALARM
>=20
>=20
> Wild guess: this isn't a LM80. No value here make sense. What you have
> here is obviously another model of sensoring chipset.
>=20
> Which version of lm_sensors are you using? Please try a recent version
> of sensors-detect (preferably from CVS), it should be able to identify
> the chip correctly.

It is 2.8.1 and the corresponding patch to 2.4.22.

> If not, please send the output of "i2cdump 0 0x2e", we'll take a look
> and try to identify the chip.

# i2cdump 0 0x2e
No size specified (using byte-data access)
   WARNING! This program can confuse your I2C bus, cause data loss and=20
worse!
   I will probe file /dev/i2c-0, address 0x2e, mode byte
   You have five seconds to reconsider and press CTRL-C!

      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 11 08 02 00 00 03 08 ff ff ff ff ff ff ff ff ff    ???..??.........
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................

That's very negative isn't it :-)

Nicolai

