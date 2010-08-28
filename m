From: support RG <support@fidit.com>
Date: Sat, 28 Aug 2010 16:09:48 +0000
Subject: [lm-sensors] i2c-i801 module conflict with 3400 Series Chipset
Message-Id: <4C7934CC.4020902@fidit.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4110952533582797311=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--===============4110952533582797311==
Content-Type: multipart/alternative;
 boundary="------------030508030800080208050303"

This is a multi-part message in MIME format.
--------------030508030800080208050303
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable

hi

under ubuntu 10.04LTS
on dell vostro 3500

Intel Corporation 5 Series/3400 Series Chipset SMBus Controller=20
[8086:3b30] (rev 06)

By default i2c-i801 is in blacklist.conf
if i remove from blacklist here it is dmesg

i801_smbus 0000:00:1f.3: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[   14.801179] ACPI: resource 0000:00:1f.3 [0xf000-0xf01f] conflicts=20
with ACPI region SMBI [0xf000-0xf00f]
[   14.801182] ACPI: If an ACPI driver is available for this device, you=20
should use it instead of the native driver

where SMBI is in DSDT_DELL_WN09.dsl

                 OperationRegion (SMBI, SystemIO, ShiftLeft (SBAR,=20
0x05), 0x10)
                 Field (SMBI, ByteAcc, NoLock, Preserve)
                 {
                     HSTS,   8,
                             Offset (0x02),
                     HCON,   8,
                     HCOM,   8,
                     TXSA,   8,
                     DAT0,   8,
                     DAT1,   8,
                     HBDR,   8,
                     PECR,   8,
                     RXSA,   8,
                     SDAT,   16
                 }


lspci -vvnnxxxx

00:1f.3 SMBus [0c05]: Intel Corporation 5 Series/3400 Series Chipset=20
SMBus Controller [8086:3b30] (rev 06)
     Subsystem: Dell Device [1028:0441]
     Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-=20
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin C routed to IRQ 18
     Region 0: Memory at fbc05000 (64-bit, non-prefetchable) [size=3D256]
     Region 4: I/O ports at f000 [size=3D32]
     Kernel modules:* i2c-i801*
00: 86 80 30 3b 03 00 80 02 06 00 05 0c 00 00 00 00
10: 04 50 c0 fb 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 f0 00 00 00 00 00 00 00 00 00 00 28 10 41 04
30: 00 00 00 00 00 00 00 00 00 00 00 00 03 03 00 00

finaly, _with or without i2c-i801_ and//or k8temp load at startup
sensors return only

fidit@de100816A:~$ sensors
acpitz-virtual-0
Adapter: Virtual device
temp1:       +39.5=B0C  (crit =3D +100.0=B0C)

under everest on seven, 6 temp are detect.



--------------030508030800080208050303
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html; charset=ISO-8859-1"
 http-equiv="Content-Type">
</head>
<body text="#000000" bgcolor="#ffffff">
hi<br>
<br>
under ubuntu 10.04LTS<br>
on dell vostro 3500<br>
<br>
Intel Corporation 5 Series/3400 Series Chipset SMBus Controller
[8086:3b30] (rev 06)<br>
<br>
By default i2c-i801 is in blacklist.conf<br>
if i remove from blacklist here it is dmesg<br>
<br>
i801_smbus 0000:00:1f.3: PCI INT C -&gt; GSI 18 (level, low) -&gt; IRQ
18<br>
[&nbsp;&nbsp; 14.801179] ACPI: resource 0000:00:1f.3 [0xf000-0xf01f] conflicts
with ACPI region SMBI [0xf000-0xf00f]<br>
[&nbsp;&nbsp; 14.801182] ACPI: If an ACPI driver is available for this device,
you should use it instead of the native driver<br>
<br>
where SMBI is in DSDT_DELL_WN09.dsl<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OperationRegion (SMBI, SystemIO, ShiftLeft (SBAR,
0x05), 0x10)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Field (SMBI, ByteAcc, NoLock, Preserve)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HSTS,&nbsp;&nbsp; 8, <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Offset (0x02), <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCON,&nbsp;&nbsp; 8, <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCOM,&nbsp;&nbsp; 8, <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TXSA,&nbsp;&nbsp; 8, <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DAT0,&nbsp;&nbsp; 8, <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DAT1,&nbsp;&nbsp; 8, <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HBDR,&nbsp;&nbsp; 8, <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PECR,&nbsp;&nbsp; 8, <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RXSA,&nbsp;&nbsp; 8, <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDAT,&nbsp;&nbsp; 16<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
<br>
lspci -vvnnxxxx<br>
<br>
00:1f.3 SMBus [0c05]: Intel Corporation 5 Series/3400 Series Chipset
SMBus Controller [8086:3b30] (rev 06)<br>
&nbsp;&nbsp;&nbsp; Subsystem: Dell Device [1028:0441]<br>
&nbsp;&nbsp;&nbsp; Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-<br>
&nbsp;&nbsp;&nbsp; Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium &gt;TAbort-
&lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
&nbsp;&nbsp;&nbsp; Interrupt: pin C routed to IRQ 18<br>
&nbsp;&nbsp;&nbsp; Region 0: Memory at fbc05000 (64-bit, non-prefetchable) [size=256]<br>
&nbsp;&nbsp;&nbsp; Region 4: I/O ports at f000 [size=32]<br>
&nbsp;&nbsp;&nbsp; Kernel modules:<b> i2c-i801</b><br>
00: 86 80 30 3b 03 00 80 02 06 00 05 0c 00 00 00 00<br>
10: 04 50 c0 fb 00 00 00 00 00 00 00 00 00 00 00 00<br>
20: 01 f0 00 00 00 00 00 00 00 00 00 00 28 10 41 04<br>
30: 00 00 00 00 00 00 00 00 00 00 00 00 03 03 00 00<br>
<br>
finaly, <u>with or without i2c-i801</u> and//or k8temp load at startup<br>
sensors return only<br>
<br>
fidit@de100816A:~$ sensors<br>
acpitz-virtual-0<br>
Adapter: Virtual device<br>
temp1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +39.5&deg;C&nbsp; (crit = +100.0&deg;C)<br>
<br>
under everest on seven, 6 temp are detect. &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
<br>
<br>
</body>
</html>

--------------030508030800080208050303--


--===============4110952533582797311==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4110952533582797311==--
