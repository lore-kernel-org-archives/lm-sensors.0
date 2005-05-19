From: shawn.starr@rogers.com (shawn.starr@rogers.com)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: Linux 2.6.x i2c problems
Message-Id: <20040430023412.TBNM286496.fep04-mail.bloor.is.net.cable.rogers.com@localhost>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

I have been experiencing problems with the PIIX4 i2c driver. I have an IBM =
system that works with lm-sensors fine - Thanks to Jean Delvare!

The machine has an lm80 sensor chip (as shown below)

lm80-i2c-0-28
Adapter: SMBus PIIX4 adapter at fe00
+5V:       +4.90 V  (min =3D  +4.74 V, max =3D  +5.25 V)  =20
VTT:       +1.72 V  (min =3D  +1.70 V, max =3D  +2.10 V)  =20
+3.3V:     +3.35 V  (min =3D  +3.14 V, max =3D  +3.47 V)  =20
+Vcore:    +1.98 V  (min =3D  +1.90 V, max =3D  +2.10 V)  =20
+12V:     +11.24 V  (min =3D +11.18 V, max =3D +12.63 V)  =20
-12V:     -11.88 V  (min =3D -12.60 V, max =3D -11.39 V)  =20
-5V:       -4.92 V  (min =3D  -5.25 V, max =3D  -4.76 V)  =20
fan1:     1804 RPM  (min =3D 1527 RPM, div =3D 4)         =20
temp:     +35.50 C (hot: limit =3D +60 C, hyst =3D +65 C)=20
:                  (os:  limit =3D +54 C, hyst =3D +56 C)=20


The problem is if you query the i2c/SMBus too many times over a period of t=
ime the bus will just fail as below:

I modified the i2c-piix4 driver to attempt to kill transactions on the SMBu=
s if its stuck. It succeeds but the bus fails for some reason, did I forgot=
 to set any other bits?=20

If I adjust the query period ie in the lm80.c driver from 2 seconds to 5 se=
conds, the SMbus wont fail as quickly.

If I run watch -n2 sensors over a few minutes the bus will suddenly fail. A=
lso oddly is when the bus fails and I reboot, the system fails to reset com=
pletely, BIOS doesn't even appear, if the SMBus does not fail I can reboot =
Linux without issue.=20

I'm stuck and there seems to be odd conditions I've experienced including t=
he onboard nic failing with the i2c driver loaded sometimes.

Apr 29 22:22:25 coredump kernel: IBM machine detected. Disabling SMBus acce=
sses.

Why is this disabled? Can someone enlighten me (is this why im getting bus =
failures? is the SMBus on this IBM badly designed?)


Thanks for any help anyone can provide. I'd like to fix the driver for othe=
r IBM people so they can also have sensor support.


i2c_adapter i2c-0: Transaction (pre): CNT=08, CMD/, ADDQ, DAT0=C2, DAT1=00
i2c_adapter i2c-0: Transaction (post): CNT=08, CMD/, ADDQ, DAT0=C2, DAT1=00
i2c_adapter i2c-0: Transaction (pre): CNT=08, CMD., ADDQ, DAT0=C2, DAT1=00
i2c_adapter i2c-0: SMBus busy (01). waiting...
i2c_adapter i2c-0: SMBus Busy: Wait State: HEX: 1, DEC: 1
i2c_adapter i2c-0: Killing SMBus Transactions!
i2c_adapter i2c-0: SMBus KILL STATUS BIT =3D 1
i2c_adapter i2c-0: SMBUS FAILED BIT =3D 0
i2c_adapter i2c-0: Error: Failed bus transaction
i2c_adapter i2c-0: Transaction (post): CNT
, CMD., ADDQ, DAT0=C2, DAT1=00
i2c_adapter i2c-0: Transaction (pre): CNT=08, CMD#, ADDQ, DAT0=C2, DAT1=00
i2c_adapter i2c-0: SMBus busy (10). waiting...
i2c_adapter i2c-0: SMBus KILL STATUS BIT =3D 0
i2c_adapter i2c-0: SMBUS FAILED BIT =3D 0
i2c_adapter i2c-0: SMBus Timeout!
i2c_adapter i2c-0: Failed reset at end of transaction (01)
i2c_adapter i2c-0: Transaction (post): CNT=08, CMD#, ADDQ, DAT0=C2, DAT1=00
i2c_adapter i2c-0: Transaction (pre): CNT=08, CMD1, ADDQ, DAT0=C2, DAT1=00
i2c_adapter i2c-0: SMBus busy (01). waiting...
i2c_adapter i2c-0: SMBus Busy: Wait State: HEX: 1, DEC: 1
i2c_adapter i2c-0: Killing SMBus Transactions!
i2c_adapter i2c-0: SMBus KILL STATUS BIT =3D 1
i2c_adapter i2c-0: SMBUS FAILED BIT =3D 1
i2c_adapter i2c-0: SMBus KILL Successful!!
i2c_adapter i2c-0: RESULT: (10): Successfull!
i2c_adapter i2c-0: SMBHSTCNT Status
i2c_adapter i2c-0: Status Bits: KILLED=3D1
i2c_adapter i2c-0: Status Bits: INTERRUPT=3D0
i2c_adapter i2c-0: Status Bits: BUSY=3D0
i2c_adapter i2c-0: SMBHSTCNT Status - DOUBLE_CHECK
i2c_adapter i2c-0: Status KILLED=3D1
i2c_adapter i2c-0: Status INTERRUPT=3D0
i2c_adapter i2c-0: Status BUSY=3D0
i2c_adapter i2c-0: Error: Failed bus transaction
i2c_adapter i2c-0: Transaction (post): CNT
, CMD1, ADDQ, DAT0=C2, DAT1=00
i2c_adapter i2c-0: Transaction (pre): CNT=08, CMD0, ADDQ, DAT0=C2, DAT1=00


1
