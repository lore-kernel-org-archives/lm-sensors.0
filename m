From: timm@fnal.gov (Steven Timm)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: ticket 1833
Message-Id: <Pine.LNX.4.58.0412020915370.25485@boxer.fnal.gov>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

[root@fnpt126 superodoctor]# i2cdump 0 0x2f
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x2f, mode byte
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
10: 00 00 64 64 93 00 00 53 00 ff 00 00 05 00 00 b3    ..dd?..S....?..?
20: aa aa 53 4d 4a 9e d2 2e ff 1f 21 c6 94 c6 94 ff    ??SMJ??..?!????.
30: 00 ff 00 52 43 b7 87 ff 00 7f 00 ed ed ed e1 b3    ...RC??..?.?????
40: 03 00 00 e7 7f ff ff bb 2f 13 73 c4 4d ff 80 5c    ?..??..?/?s?M.?\
50: ff ff ff ff ff ff ff ff 7a 60 ff bb bb 00 05 7f    ........z`.??.??
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: 22 8f 22 8f 00 00 00 00 11 11 ff ff 3c 3c 0a 0a    "?"?....??..<<??
90: 00 00 00 01 8f ff 00 00 11 ff 3c 00 ff 01 2b ff    ...??...?.<..?+.
a0: 01 01 01 8f 8f 8f 8f ff 48 20 00 e0 ff ff 00 00    ???????.H .?....
b0: d2 20 ff ff ff 00 ff 00 ff ff ff ed ed ed ff ff    ? .........???..
c0: 1b 80 00 44 00 4e 00 ff 1f 00 00 44 00 4e 00 ff    ??.D.N..?..D.N..
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: 8b 8b 8b 28 3c 50 28 3c 50 28 3c 50 ff ff ff ff    ???(<P(<P(<P....
f0: ff ff 80 ff 00 01 00 a0 ff 02 ff 00 00 00 00 ff    ..?..?.?.?......


From AllSuperD.ini we know the following
So if we can figure out what kind of chip it is, we know=20
which signal is where.

There is a 6300ESB "Hance Rapids" controller on this board, it may=20
be that this may have something to do with it.

00:1f.3 SMBus: Intel Corp. 6300ESB SMBus Controller (rev 02)

I will look at the board.  Documentation is silent on what kind of=20
sensor chip it may be.  I have a query into Supermicro.

Steve

[_X6DVL_]
[_X6DAL_]
[_X6DVA_]
[System]
I2CConnector=3DTRUE
BusType=3D1
System=D484
MachinenamePolling=3D5
Pageralert=FALSE
PagerIDOutlinePhonenumberMailalert=FALSE
FreshRun=3DTRUE
TopMost=3DTRUE
Log=3D0
AutoRunSDII=FALSE
Mailserver=3Dmail.yourcompany.com
Serverport%
Mailbox=3Dto@yourcompany.com
SenderMailBox=3Dfrom@yourcompany.com
MailAuthen=FALSE
SenderAccountSenderPasswordEnterprise=3D1.3.6.1.4.1.10876
H_Name=3D2.1.1.1.1.2
H_Type=3D2.1.1.1.1.3
H_Reading=3D2.1.1.1.1.4
H_High=3D2.1.1.1.1.5
H_Low=3D2.1.1.1.1.6
H_Max=3D2.1.1.1.1.7
H_Min=3D2.1.1.1.1.8
H_Divisor=3D2.1.1.1.1.9
H_Monitor=3D2.1.1.1.1.10

[Item]
BusType=3D1
Item_Name=FAn1 Fan Speed
Comp_Name=FAn1
Item_ID=3DItem_FAN1
Item_Cat=FAN
ChipCode=3D7
Slave/
Offset(
ParaIndex1=3DDivisor1
ParaIndex2=FAN1H
Monitor=3DTRUE
Source=3D0

[Item]
BusType=3D1
Item_Name=FAn2 Fan Speed
Comp_Name=FAn2
Item_ID=3DItem_FAN2
Item_Cat=FAN
ChipCode=3D7
Slave/
Offset)
ParaIndex1=3DDivisor2
ParaIndex2=FAN2H
Monitor=3DTRUE
Source=3D0

[Item]
BusType=3D1
Item_Name=FAn3 Fan Speed
Comp_Name=FAn3
Item_ID=3DItem_FAN3
Item_Cat=FAN
ChipCode=3D7
Slave/
Offset*
ParaIndex1=3DDivisor3
ParaIndex2=FAN3H
Monitor=3DTRUE
Source=3D0

[Item]
BusType=3D1
Item_Name=FAn4 Fan Speed
Comp_Name=FAn4
Item_ID=3DItem_FAN4
Item_Cat=FAN
ChipCode=3D7
Slave/
Offset=B8
ParaIndex1=3DDivisor4
ParaIndex2=FAN4H
Monitor=3DTRUE
Source=3D0

[Item]
BusType=3D1
Item_Name=FAn5 Fan Speed
Comp_Name=FAn5
Item_ID=3DItem_FAN5
Item_Cat=FAN
ChipCode=3D7
Slave/
Offset=B9
ParaIndex1=3DDivisor5
ParaIndex2=FAN5H
Monitor=3DTRUE
Source=3D0

[Item]
BusType=3D1
Item_Name=FAn6 Fan Speed
Comp_Name=FAn6
Item_ID=3DItem_FAN6
Item_Cat=FAN
ChipCode=3D7
Slave/
Offset=BA
ParaIndex1=3DDivisor6
ParaIndex2=FAN6H
Monitor=3DTRUE
Source=3D0

[Item]
BusType=3D1
Item_Name=3D+1.5V Voltage
Comp_Name=3D+1.5V
Item_ID=3DItem_VOL1
Item_Cat=3DVOLTAGE
VOL_FUNC=3DVCCP
ChipCode=3D1
Slave,
Offset=20
ParaIndex1=3DVOL1H
ParaIndex2=3DVOL1L
Monitor=3DTRUE
Source=3D0

[Item]
BusType=3D1
Item_Name=3D3.3Vsb Voltage
Comp_Name=3D3.3Vsb
Item_ID=3DItem_VOL2
Item_Cat=3DVOLTAGE
VOL_FUNC=3DVCCP
ChipCode=3D1
Slave,
Offset!
ParaIndex1=3DVOL2H
ParaIndex2=3DVOL2L
Monitor=3DTRUE
Source=3D0

[Item]
BusType=3D1
Item_Name=3D+5V Voltage
Comp_Name=3D+5V
Item_ID=3DItem_VOL3
Item_Cat=3DVOLTAGE
VOL_FUNC=3DP5V
ChipCode=3D1
Slave,
Offset#
ParaIndex1=3DVOL3H
ParaIndex2=3DVOL3L
Monitor=3DTRUE
Source=3D0

[Item]
BusType=3D1
Item_Name=3D-12V Voltage
Comp_Name=3D-12V
Item_ID=3DItem_VOL4
Item_Cat=3DVOLTAGE
VOL_FUNC=3DN12V
ChipCode=3D1
Slave,
Offset%
ParaIndex1=3DVOL4H
ParaIndex2=3DVOL4L
Monitor=3DTRUE
Source=3D0

[Item]
BusType=3D1
Item_Name=3D+12V Voltage
Comp_Name=3D+12V
Item_ID=3DItem_VOL5
Item_Cat=3DVOLTAGE
VOL_FUNC=3DP12V
ChipCode=3D1
Slave,
Offset$
ParaIndex1=3DVOL5H
ParaIndex2=3DVOL5L
Monitor=3DTRUE
Source=3D0

[Item]
BusType=3D1
Item_Name=3D+3.3V Voltage
Comp_Name=3D+3.3V
Item_ID=3DItem_VOL6
Item_Cat=3DVOLTAGE
VOL_FUNC=3DP33V
ChipCode=3D1
Slave,
Offset"
ParaIndex1=3DVOL6H
ParaIndex2=3DVOL6L
Monitor=3DTRUE
Source=3D0

[Item]
BusType=3D1
Item_Name=3DCPU1 Core Voltage
Comp_Name=3DCPU1 Core
Item_ID=3DItem_VOL7
Item_Cat=3DVOLTAGE
VOL_FUNC=3DVCCP
ChipCode=3D7
Slave/
Offset=20
ParaIndex1=3DVOL7H
ParaIndex2=3DVOL7L
Monitor=3DTRUE
Source=3D0

[Item]
BusType=3D1
Item_Name=3DCPU2 Core Voltage
Comp_Name=3DCPU2 Core
Item_ID=3DItem_VOL8
Item_Cat=3DVOLTAGE
VOL_FUNC=3DVCCP
ChipCode=3D7
Slave/
Offset!
ParaIndex1=3DVOL8H
ParaIndex2=3DVOL8L
Monitor=3DTRUE
Source=3D0

[Item]
BusType=3D1
Item_Name=3D+1.2V Voltage
Comp_Name=3D+1.2V
Item_ID=3DItem_VOL9
Item_Cat=3DVOLTAGE
VOL_FUNC=3DP33V
ChipCode=3D7
Slave/
Offset$
ParaIndex1=3DVOL9H
ParaIndex2=3DVOL9L
Monitor=3DTRUE
Source=3D0

[Item]
BusType=3D1
Item_Name=3DDIMM Voltage
Comp_Name=3DDIMM
Item_ID=3DItem_VOL10
Item_Cat=3DVOLTAGE
VOL_FUNC=3DP33V
ChipCode=3D7
Slave/
Offset%
ParaIndex1=3DVOL10H
ParaIndex2=3DVOL10L
Monitor=3DTRUE
Source=3D0

[Item]
BusType=3D1
Item_Name=3DCPU1 Temperature
Comp_Name=3DCPU1
Item_ID=3DItem_TEMP1
Item_Cat=3DTEMP
Slave/
Offset=C0
ParaIndex1=3DTEMP1H
ParaIndex2=3DTEMP1L
Monitor=3DTRUE
Source=3D0

[Item]
BusType=3D1
Item_Name=3DCPU2 Temperature
Comp_Name=3DCPU2
Item_ID=3DItem_TEMP2
Item_Cat=3DTEMP
Slave/
Offset=C8
ParaIndex1=3DTEMP2H
ParaIndex2=3DTEMP2L
Monitor=3DTRUE
Source=3D0

[Item]
BusType=3D1
Item_Name=3DSystem Temperature
Comp_Name=3DSystem
Item_ID=3DItem_TEMP3
Item_Cat=3DTEMP
Slave,
Offset'
ParaIndex1=3DTEMP3H
ParaIndex2=3DTEMP3L
Monitor=3DTRUE
Source=3D0

[Item]
BusType=3D1
Item_Name=3DChassis Intrusion
Comp_Name=3DIntrusion
Item_ID=3DItem_SWITCH1
Item_Cat=3DSWITCH
ChipCode=3D7
Slave/
Offset=AA
Activate=10
ResetD
ParaIndex1=3DSWITCH1A
ParaIndex2=3DSWITCH1C
Monitor=3DTRUE
Source=3D0

[Item]
Item_Name=3DPower Supply Failure
Comp_Name=3DPower
Item_ID=3DItem_SWITCH2
Item_Cat=3DSWITCH
ChipCode=3D4
Slave=07
Offset=F1
Activate=00
Reset=00
ParaIndex1=3DSWITCH2A
ParaIndex2=3DSWITCH2C
Monitor=3DTRUE
Source=3D0

[Parameter]
ChipCode=3D7
Slave/
OffsetG
BitMask=03
Parameter=3DDivisor1

hipCode=3D7
Slave/
OffsetG
BitMask0
Parameter=3DDivisor2

[Parameter]
ChipCode=3D7
Slave/
Offset[
BitMask=03
Parameter=3DDivisor3

[Parameter]
ChipCode=3D7
Slave/
Offset[
BitMask0
Parameter=3DDivisor4

[Parameter]
ChipCode=3D7
Slave/
ffset\
BitMask=03
Parameter=3DDivisor5

[Parameter]
ChipCode=3D7
Slave/
Offset\
BitMask0
Parameter=3DDivisor6

[Parameter]
Slave,
Offset+
Parameter=3DVOL1H

[Parameter]
Slave,
Offset,
Parameter=3DVOL1L

[Parameter]
Slave,
Offset-
Parameter=3DVOL2H

[Parameter]
Slave,
Offset.
Parameter=3DVOL2L

[Parameter]
Slave,
Offset1
Parameter=3DVOL3H

[Parameter]
Slave,
Offset2
Parameter=3DVOL3L

[Parameter]
Slave,
Offset5
Parameter=3DVOL4H

[Parameter]
Slave,
Offset6
Parameter=3DVOL4L

[Parameter]
Slave,
Offset3
Parameter=3DVOL5H

[Parameter]
Slave,
Offset4
Parameter=3DVOL5L

[Parameter]
Slave,
Offset/
Parameter=3DVOL6H

[Parameter]
Slave,
Offset0
Parameter=3DVOL6L

[Parameter]
Slave/
Offset+
Parameter=3DVOL7H

[Parameter]
Slave/
Offset,
Parameter=3DVOL7L

[Parameter]
Slave/
Offset-
Parameter=3DVOL8H

[Parameter]
Slave/
Offset.
Parameter=3DVOL8L

[Parameter]
Slave/
Offset3
Parameter=3DVOL9H

[Parameter]
Slave/
Offset4
Parameter=3DVOL9L

[Parameter]
Slave/
Offset5
Parameter=3DVOL10H

[Parameter]
Slave/
Offset6
Parameter=3DVOL10L

[Parameter]
Slave/
Offset=C5
Parameter=3DTEMP1H

[Parameter]
Slave/
Offset=C3
Parameter=3DTEMP1L

[Parameter]
Slave/
Offset=CD
Parameter=3DTEMP2H

[Parameter]
Slave/
Offset=CB
Parameter=3DTEMP2L

[Parameter]


------------------------------------------------------------------
Steven C. Timm, Ph.D  (630) 840-8525  timm@fnal.gov  http://home.fnal.gov/~=
timm/
Fermilab Computing Div/Core Support Services Dept./Scientific Computing Sec=
tion
Assistant Group Leader, Farms and Clustered Systems Group
Lead of Computing Farms Team
