From: NSardella@CROSSBEAMSYS.COM (Sardella, Norman)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: reply to ticket 1407 (bmcsensors) for mds
Message-Id: <3F815555.50606@crossbeamsys.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

 >On the scaling, please email us the bmcsensors output in
 >dmesg when the module is inserted.
 >reference your ticket number.
 >thanks
 >mds 10/5/03

Sep 30 12:20:42 heliosc30 kernel: i2c-ipmi.o version 2.8.0 (20030714)
Sep 30 12:20:42 heliosc30 kernel: i2c-ipmi.o: BMC access for i2c modules=20
initialized.
Sep 30 12:20:42 heliosc30 kernel: i2c-dev.o: i2c /dev entries driver=20
module version 2.8.0 (20030714)
Sep 30 12:20:42 heliosc30 kernel: lm75.o version 2.8.0 (20030714)
Sep 30 12:20:42 heliosc30 kernel: ipmi_kcs: Acquiring BMC @ port=3D0xca2
Sep 30 12:20:42 heliosc30 kernel: bmcsensors.o version 2.8.0 (20030714)
Sep 30 12:20:42 heliosc30 kernel: bmcsensors.o: Registered client,=20
scanning for sensors...

Sep 30 12:21:04 heliosc30 kernel: bmcsensors.o: registering sensor 0:=20
(type 0x02) (fmt=3D0; m=98; b=3D0; k1=3D2; k2=12; cap=3D0x69; mask=3D0x1b1b
)
Sep 30 12:21:04 heliosc30 kernel: bmcsensors.o: sensors.conf: label in1=20
"Baseboard 1.25V"
Sep 30 12:21:04 heliosc30 kernel: bmcsensors.o: sensor 0: using upper=20
critical threshold for upper limit
Sep 30 12:21:04 heliosc30 kernel: bmcsensors.o: sensor 0: using=20
positive-going hysteresis for lower limit
Sep 30 12:21:04 heliosc30 kernel: bmcsensors.o: registering sensor 1:=20
(type 0x02) (fmt=3D0; m=196; b=3D0; k1=3D2; k2=12; cap=3D0x69; mask=3D0x1b1
b)
Sep 30 12:21:04 heliosc30 kernel: bmcsensors.o: sensors.conf: label in2=20
"Baseboard 2.5V"
Sep 30 12:21:04 heliosc30 kernel: bmcsensors.o: sensor 1: using upper=20
critical threshold for upper limit
Sep 30 12:21:04 heliosc30 kernel: bmcsensors.o: sensor 1: using=20
positive-going hysteresis for lower limit
Sep 30 12:21:04 heliosc30 kernel: bmcsensors.o: registering sensor 2:=20
(type 0x02) (fmt=3D0; m=172; b=3D0; k1=3D2; k2=12; cap=3D0x69; mask=3D0x1b1
b)
Sep 30 12:21:04 heliosc30 kernel: bmcsensors.o: sensors.conf: label in3=20
"Baseboard 3.3V"
Sep 30 12:21:04 heliosc30 kernel: bmcsensors.o: sensor 2: using upper=20
critical threshold for upper limit
Sep 30 12:21:04 heliosc30 kernel: bmcsensors.o: sensor 2: using=20
positive-going hysteresis for lower limit
Sep 30 12:21:04 heliosc30 kernel: bmcsensors.o: registering sensor 3:=20
(type 0x02) (fmt=3D0; m=151; b=3D0; k1=3D2; k2=12; cap=3D0x69; mask=3D0x1b1
b)
Sep 30 12:21:04 heliosc30 kernel: bmcsensors.o: sensors.conf: label in4=20
"Baseboard 3.3VSB"
Sep 30 12:21:04 heliosc30 kernel: bmcsensors.o: sensor 3: using upper=20
critical threshold for upper limit
Sep 30 12:21:04 heliosc30 kernel: bmcsensors.o: sensor 3: using=20
positive-going hysteresis for lower limit
Sep 30 12:21:04 heliosc30 kernel: bmcsensors.o: registering sensor 4:=20
(type 0x02) (fmt=3D0; m&; b=3D0; k1=3D2; k2=13; cap=3D0x69; mask=3D0x1b1b
)
Sep 30 12:21:04 heliosc30 kernel: bmcsensors.o: sensors.conf: label in5=20
"Baseboard 5.0V"
Sep 30 12:21:04 heliosc30 kernel: bmcsensors.o: sensor 4: using upper=20
critical threshold for upper limit
Sep 30 12:21:04 heliosc30 kernel: bmcsensors.o: sensor 4: using=20
positive-going hysteresis for lower limit
Sep 30 12:21:04 heliosc30 kernel: bmcsensors.o: registering sensor 5:=20
(type 0x02) (fmt=3D0; mb; b=3D0; k1=3D2; k2=13; cap=3D0x69; mask=3D0x1b1b
)
Sep 30 12:21:04 heliosc30 kernel: bmcsensors.o: sensors.conf: label in6=20
"Baseboard 12V"
Sep 30 12:21:04 heliosc30 kernel: bmcsensors.o: sensor 5: using upper=20
critical threshold for upper limit
Sep 30 12:21:04 heliosc30 kernel: bmcsensors.o: sensor 5: using=20
positive-going hysteresis for lower limit
Sep 30 12:21:04 heliosc30 kernel: bmcsensors.o: registering sensor 6:=20
(type 0x02) (fmt=3D0; mr; b=3D-160; k1=3D2; k2=13; cap=3D0x69; mask=3D0x1
b1b)
Sep 30 12:21:04 heliosc30 kernel: bmcsensors.o: sensors.conf: label in7=20
"Baseboard -12V"
Sep 30 12:21:04 heliosc30 kernel: bmcsensors.o: sensor 6: using upper=20
critical threshold for upper limit
Sep 30 12:21:04 heliosc30 kernel: bmcsensors.o: sensor 6: using=20
positive-going hysteresis for lower limit
Sep 30 12:21:04 heliosc30 kernel: bmcsensors.o: registering sensor 7:=20
(type 0x02) (fmt=3D0; m=156; b=3D0; k1=3D2; k2=12; cap=3D0x69; mask=3D0x1b1
b)
Sep 30 12:21:04 heliosc30 kernel: bmcsensors.o: sensors.conf: label in8=20
"Baseboard VBAT"
Sep 30 12:21:04 heliosc30 kernel: bmcsensors.o: sensor 7: using upper=20
critical threshold for upper limit
Sep 30 12:21:04 heliosc30 kernel: bmcsensors.o: sensor 7: using=20
positive-going hysteresis for lower limit
Sep 30 12:21:04 heliosc30 kernel: bmcsensors.o: registering sensor 8:=20
(type 0x02) (fmt=3D0; m=118; b=3D0; k1=3D2; k2=12; cap=3D0x69; mask=3D0x1b1
b)
Sep 30 12:21:04 heliosc30 kernel: bmcsensors.o: sensors.conf: label in9=20
"Processor VRM"
Sep 30 12:21:04 heliosc30 kernel: bmcsensors.o: sensor 8: using upper=20
critical threshold for upper limit
Sep 30 12:21:04 heliosc30 kernel: bmcsensors.o: sensor 8: using=20
positive-going hysteresis for lower limit
Sep 30 12:21:04 heliosc30 kernel: bmcsensors.o: registering sensor 9:=20
(type 0x01) (fmt=3D0; m=3D1; b=3D0; k1=3D0; k2=3D0; cap=3D0x68; mask=3D0x1b=
1b)
Sep 30 12:21:04 heliosc30 kernel: bmcsensors.o: sensors.conf: label=20
temp1 "Baseboard Temp"
Sep 30 12:21:04 heliosc30 kernel: bmcsensors.o: sensor 9: using upper=20
critical threshold for upper limit
Sep 30 12:21:04 heliosc30 kernel: bmcsensors.o: sensor 9: using=20
positive-going hysteresis for lower limit
Sep 30 12:21:04 heliosc30 kernel: bmcsensors.o: 0 reservations cancelled
Sep 30 12:21:04 heliosc30 kernel: bmcsensors.o: registered 1 temp, 9=20
volt, 0 current, 0 fan sensors




-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031006/=
958a18c8/attachment.html
