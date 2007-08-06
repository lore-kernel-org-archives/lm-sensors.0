From: Tony Griffiths <tonyg@promptu.com>
Date: Mon, 06 Aug 2007 01:29:30 +0000
Subject: [lm-sensors] Incorrect magnitude (=3,
Message-Id: <46B6797A.1080402@promptu.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------080509010806060002000908"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------080509010806060002000908
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Note that this machine is running a modified version of the FC7 2.6.22=20
kernel.  One of the modifications involved making the ipmisensors module=20
run under Linux 2.6.22 (properly)!

[lm_sensors 2.10.3 before patch]

[root@noakes redhat]# sensors
bmc-isa-0000
Adapter: ISA adapter
CMOS Battery:
           +3.08 V  (min =3D  +2.64 V, max =3D  +0.00 V)
Fan 1:    3525 RPM  (min =3D  675 RPM)
Fan 2A:   7650 RPM  (min =3D  675 RPM)
Fan 2B:   5400 RPM  (min =3D  675 RPM)
Fan 3A:   7650 RPM  (min =3D  675 RPM)
Fan 3B:   5550 RPM  (min =3D  675 RPM)
Fan 4A:   7425 RPM  (min =3D  675 RPM)
Fan 4B:   5400 RPM  (min =3D  675 RPM)
Fan 5A:   7575 RPM  (min =3D  675 RPM)
Fan 5B:   5475 RPM  (min =3D  675 RPM)
Temp:  +3.9=B0C  (high =3D    +9=B0C, hyst =3D   -13=B0C)  *** WRONG ***
Temp: +45.0=B0C  (high =3D    +9=B0C, hyst =3D   -13=B0C)
Planar Temp:
           +33.0=B0C  (high =3D    +8=B0C, hyst =3D   -13=B0C)
VRD 0 Temp:
           +26.0=B0C  (high =3D    +7=B0C, hyst =3D   -13=B0C)
VRD 1 Temp:
           +28.0=B0C  (high =3D    +7=B0C, hyst =3D   -13=B0C)


[After patch applied and RPM rebuilt]

[root@noakes redhat]# sensors
bmc-isa-0000
Adapter: ISA adapter
CMOS Battery:
           +3.08 V  (min =3D  +2.64 V, max =3D  +0.00 V)
Fan 1:    3525 RPM  (min =3D  675 RPM)
Fan 2A:   7650 RPM  (min =3D  675 RPM)
Fan 2B:   5400 RPM  (min =3D  675 RPM)
Fan 3A:   7725 RPM  (min =3D  675 RPM)
Fan 3B:   5550 RPM  (min =3D  675 RPM)
Fan 4A:   7425 RPM  (min =3D  675 RPM)
Fan 4B:   5475 RPM  (min =3D  675 RPM)
Fan 5A:   7575 RPM  (min =3D  675 RPM)
Fan 5B:   5475 RPM  (min =3D  675 RPM)
Temp: +38.0=B0C  (high =3D    +9=B0C, hyst =3D   -13=B0C)
Temp: +43.0=B0C  (high =3D    +9=B0C, hyst =3D   -13=B0C)
Planar Temp:
           +32.0=B0C  (high =3D    +8=B0C, hyst =3D   -13=B0C)
VRD 0 Temp:
           +26.0=B0C  (high =3D    +7=B0C, hyst =3D   -13=B0C)
VRD 1 Temp:
           +28.0=B0C  (high =3D    +7=B0C, hyst =3D   -13=B0C)


and the output from ipmitool confirming that sensors is displaying the=20
correct values-

[root@noakes lm_sensors-2.10.3]# ipmitool -I open sdr elist
Temp             | 01h | ok  |  3.2 | 38 degrees C
Temp             | 02h | ok  |  3.3 | 42 degrees C
Planar Temp      | 04h | ok  |  7.1 | 32 degrees C
VRD 0 Temp       | 05h | ok  |  7.1 | 26 degrees C
VRD 1 Temp       | 06h | ok  |  7.1 | 27 degrees C
CMOS Battery     | 10h | ok  |  7.1 | 3.08 Volts
VCORE            | 11h | ok  |  3.2 | State Deasserted
VCORE            | 12h | ok  |  3.3 | State Deasserted
PROC VTT         | 13h | ok  |  7.1 | State Deasserted
1.5V PG          | 14h | ok  |  7.1 | State Deasserted
1.8V PG          | 15h | ok  |  7.1 | State Deasserted
Presence         | 20h | ok  |  3.2 | Present
Presence         | 21h | ok  |  3.3 | Present
Fan 1            | 30h | ok  |  7.1 | 3525 RPM
Fan 2A           | 31h | ok  |  7.1 | 7650 RPM
Fan 2B           | 32h | ok  |  7.1 | 5400 RPM
Fan 3A           | 33h | ok  |  7.1 | 7725 RPM
Fan 3B           | 34h | ok  |  7.1 | 5550 RPM
Fan 4A           | 35h | ok  |  7.1 | 7425 RPM
Fan 4B           | 36h | ok  |  7.1 | 5475 RPM
Fan 5A           | 37h | ok  |  7.1 | 7500 RPM
Fan 5B           | 38h | ok  |  7.1 | 5475 RPM
Status           | 40h | ok  |  3.2 | Presence detected
Status           | 41h | ok  |  3.3 | Presence detected
VRM              | 44h | ok  |  3.2 | Presence detected
VRM              | 45h | ok  |  3.3 | Presence detected
OS Watchdog      | 50h | ok  |  7.1 |
SEL              | 51h | ns  |  7.1 | Disabled
Intrusion        | 52h | ok  |  7.1 |
Fan Redundancy   | 54h | ok  |  7.1 | Fully Redundant
ECC Corr Err     | 01h | ok  | 34.6 | Presence Detected, Configuration Er=
ror
ECC Uncorr Err   | 02h | ok  | 34.6 | Presence Detected, Configuration Er=
ror
I/O Channel Chk  | 03h | ns  | 34.6 | Disabled
PCI Parity Err   | 04h | ok  | 34.6 | EISA failsafe timeout, Bus=20
Correctable error
PCI System Err   | 05h | ok  | 34.6 | EISA failsafe timeout, Bus=20
Correctable error
SBE Log Disabled | 06h | ok  | 34.6 |
Logging Disabled | 07h | ns  | 34.6 | Disabled
Unknown          | 08h | ns  | 34.6 | Disabled
PROC Protocol    | 0Ah | ns  | 34.6 | Disabled
PROC Bus PERR    | 0Bh | ns  | 34.6 | Disabled
PROC Init Err    | 0Ch | ns  | 34.6 | Disabled
PROC Machine Chk | 0Dh | ns  | 34.6 | Disabled
Memory Spared    | 11h | ok  | 34.6 | Fully Redundant
Memory Mirrored  | 12h | ok  | 34.6 | Fully Redundant
Memory RAID      | 13h | ok  | 34.6 | Fully Redundant
Memory Added     | 14h | ok  | 34.6 | Correctable ECC
Memory Removed   | 15h | ok  | 34.6 | Correctable ECC
PCIE Fatal Err   | 18h | ns  | 34.6 | Disabled
Chipset Err      | 19h | ns  | 34.6 | Disabled
Err Reg Pointer  | 1Ah | ns  | 34.6 | No Reading

The attached patch files fix this problem for the FC7 version of=20
lm_sensors 2.10.3 !


--------------080509010806060002000908
Content-Type: text/plain;
 name="lm_sensors-2.10.3-bmc-temp1-fixup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="lm_sensors-2.10.3-bmc-temp1-fixup.patch"

--- ./lib/chips.c.orig	2007-08-06 10:25:49.000000000 +1000
+++ ./lib/chips.c	2007-08-06 10:25:01.000000000 +1000
@@ -5551,7 +5551,7 @@ static sensors_chip_feature bmc_features
                                 SENSORS_BMC_FAN1+9, RW }, 
                                 BMC_SYSCTL_FAN1+9, VALUE(1), 0 },
     { { SENSORS_BMC_TEMP1, "temp1", NOMAP, NOMAP, R }, 
-                           BMC_SYSCTL_TEMP1, VALUE(3), 2 , "temp1_input", 3 },
+                           BMC_SYSCTL_TEMP1, VALUE(3), 2 , "temp1_input", 2 },
     { { SENSORS_BMC_TEMP1_MIN, "temp1_min", SENSORS_BMC_TEMP1, SENSORS_BMC_TEMP1, 
                                RW }, 
                                BMC_SYSCTL_TEMP1, VALUE(2), 2 },

--------------080509010806060002000908
Content-Type: text/plain;
 name="lm_sensors.spec.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lm_sensors.spec.patch"

--- SPECS/lm_sensors.spec.orig	2007-08-06 10:28:36.000000000 +1000
+++ SPECS/lm_sensors.spec	2007-08-06 10:31:14.000000000 +1000
@@ -12,6 +12,7 @@ Patch4: lm_sensors-2.8.2-expr.patch
 Patch5: lm_sensors-2.10.1-local.patch
 Patch7: lm_sensors-2.8.7-udev.patch
 Patch8: lm_sensors-2.10.0-kernel26.patch
+Patch9: lm_sensors-2.10.3-bmc-temp1-fixup.patch
 Summary: Hardware monitoring tools
 Group: Applications/System
 License: GPL
@@ -69,6 +70,7 @@ what you are doing.
 %patch5 -p1 -b .local
 %patch7 -p1 -b .udev
 %patch8 -p1 -b .kernel26
+%patch9 -p1 -b .bmctemp1
 mv prog/init/README prog/init/README.initscripts
 chmod -x prog/init/fancontrol.init
 

--------------080509010806060002000908
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------080509010806060002000908--
