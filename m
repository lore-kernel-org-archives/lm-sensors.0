From: Robert.Feustle@plg.de (Feustle Robert)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: problems with opening a ticket
Message-Id: <795E03B0F1E26C449762C0EDF5F565917EBC10@exchange.plg.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

i tried to open a ticket so i put the stuff in here. you may put the topic =
in as a ticket if possible.
thanks.
Best Regards,

Robert



Version/Build:

Linux 2.4.14 lm_sensors 2.6.1 i2c_2.6.1


Subject/Problem:
smbus collisions with following hang-up

Detailed description of issue:


Hi,
please refer also to the topic 1587 "smbus collisions and hangup".

Some questions:
1. are the limit values of the conf.-file for the voltages and rpms of the =
fans written to registers of the Winbond Chip W83782d only once at the star=
t of the sensor daemon? or are the values of the chip regs compared with th=
e conf-file later?

2. do you think it makes sense to reset the winbond chip regs time by time =
and to rewrite the conf-limit values again, maybe to avoid wrong feed-back =
of limits or Alert messages?=20
there is a conf register (0x40) where initialization can be performed on bi=
t 7.
3. did you already try?

4. is it possible that the SMBAlert-signal is interrupting transaction from=
 master<->slave and vice versa (PiiX4(82371AB) <-> W83782d) so that transac=
tion collisions occur?

5. why is there no retry of the last command/transaction, if there was a SM=
Bus busy?
6. Could it be that there is a write on the regs, when the SMBus is still b=
usy?
Looks like in that log!


below you find an extraction of a log of the debug version of i2c-piix4.o. =
=20

hope you could help us!

Thanks
Robert


Feb 22 01:30:28 lsr3 syslogd 1.3-3: restart.=20
Feb 22 01:30:36 lsr3 kernel: Starting w83781d update=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMD , =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMD,, =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMD+, =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMD!, =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMD., =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMD-, =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMD", =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMD0, =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMD/, =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMD#, =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMD2, =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMD1, =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMD$, =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMD4, =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMD3, =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMD%, =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMD6, =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMD5, =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMD&, =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMD8, =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMD7, =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMDN, =
ADDZ, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMDP, =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMDN, =
ADDZ, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMDN, =
ADDZ, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMDU, =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMDN, =
ADDZ, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMDN, =
ADDZ, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMDT, =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMDN, =
ADDZ, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMDN, =
ADDZ, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMDQ, =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMDN, =
ADDZ, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMDN, =
ADDZ, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMDW, =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMDN, =
ADDZ, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMDN, =
ADDZ, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMDV, =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMDN, =
ADDZ, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMD(, =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMD;, =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMD), =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMD<, =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMD*, =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMD=3D=
, ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMD[, =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMDZ, =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMD^, =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMD_, =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMD', =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMD9, =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMD:, =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=0C, CMD=00=
, ADD=93, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=0C, CMD=03=
, ADD=93, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=0C, CMD=02=
, ADD=93, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=0C, CMD=00=
, ADD=91, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=0C, CMD=03=
, ADD=91, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=0C, CMD=02=
, ADD=91, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMDG, =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMDI, =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMDK, =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMD], =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMDA, =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMDB, =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMDN, =
ADDZ, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMDP, =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMDN, =
ADDZ, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMDW, =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMDV, =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMDN, =
ADDZ, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMDS, =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMDN, =
ADDZ, DAT0v, DAT1=00=20
Feb 22 01:30:36 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:36 lsr3 kernel: i2c-piix4.o: Failed! (01)=20


Feb 22 01:30:56 lsr3 kernel: Starting w83781d update=20
Feb 22 01:30:56 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMD , =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:56 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:56 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:56 lsr3 kernel: i2c-piix4.o: Failed! (01)=20
Feb 22 01:30:56 lsr3 kernel: i2c-piix4.o: Transaction (pre): CNT=08, CMD,, =
ADD[, DAT0v, DAT1=00=20
Feb 22 01:30:56 lsr3 kernel: PLG-Debug: SMBHSTSTS=01=20
Feb 22 01:30:56 lsr3 kernel: i2c-piix4.o: SMBus busy (01). Resetting... =20
Feb 22 01:30:56 lsr3 kernel: i2c-piix4.o: Failed! (01)


