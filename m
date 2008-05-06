From: Daniel Lucio <lucio@eecs.utk.edu>
Date: Tue, 06 May 2008 19:55:42 +0000
Subject: [lm-sensors] mapping AllSuperD.ini with sensors.conf events.
Message-Id: <FB8FDD92-F925-450B-A8A3-39B4045B9A89@eecs.utk.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

does anybody knows how can I map the following entries in my =20
AllSuperD.ini for SuperDoctorII with entries in sensors.conf?

[Item]
BusType=3D8
Item_Name=3DChassis Intrusion
Comp_Name=3DIntrusion
Item_ID=3DItem_SWITCH1
Item_Cat=3DSWITCH
ChipCode=11
Slave.
OffsetD
Activate=01
ResetI
ParaIndex1=3DSWITCH1A
ParaIndex2=3DSWITCH1C
Monitor=3DTRUE
Source=3D0

[Item]
BusType=3D4
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

I am not sure if lm-sensors is reading these values at all. This  is =20
for a SuperMicro X7DA8 using:
Chip: w83793-i2c-0-2e
Adapter: SMBus I801 adapter at 1100.

Thank you!

Daniel.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
