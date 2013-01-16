From: Yiuri Garino <yiuri.garino@gmail.com>
Date: Wed, 16 Jan 2013 11:09:51 +0000
Subject: [lm-sensors] System 76 Pangolin Fan not detected
Message-Id: <CACAsE1C4FcGZ6Eb7hyOWWYqFdTqb_5dDqgdo7e19rm+a0EdJ2A@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6718522677314451293=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============6718522677314451293==
Content-Type: multipart/alternative; boundary=bcaec51b1a73d5bf3304d365ea3d

--bcaec51b1a73d5bf3304d365ea3d
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi All.

I have a small problem with my new pc: sensor-detect is unable to detect
the fan speed.

The pc is a System 76 Pangolin panp9 ( =3D Clevo W24AEU =3D Sager NP2240 I
think).

CPU Intel(R) Core(TM) i7-3630QM CPU @ 2.40GHz

sensors output:

acpitz-virtual-0
Adapter: Virtual device
temp1: +74.0=B0C (crit =3D +120.0=B0C)

coretemp-isa-0000
Adapter: ISA adapter
Physical id 0: +75.0=B0C (high =3D +87.0=B0C, crit =3D +105.0=B0C)
Core 0: +73.0=B0C (high =3D +87.0=B0C, crit =3D +105.0=B0C)
Core 1: +74.0=B0C (high =3D +87.0=B0C, crit =3D +105.0=B0C)
Core 2: +71.0=B0C (high =3D +87.0=B0C, crit =3D +105.0=B0C)
Core 3: +71.0=B0C (high =3D +87.0=B0C, crit =3D +105.0=B0C)

lspci output:

00:00.0 Host bridge: Intel Corporation 3rd Gen Core processor DRAM
Controller (rev 09)
00:02.0 VGA compatible controller: Intel Corporation 3rd Gen Core processor
Graphics Controller (rev 09)
00:14.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset
Family USB xHCI Host Controller (rev 04)
00:16.0 Communication controller: Intel Corporation 7 Series/C210 Series
Chipset Family MEI Controller #1 (rev 04)
00:1a.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset
Family USB Enhanced Host Controller #2 (rev 04)
00:1b.0 Audio device: Intel Corporation 7 Series/C210 Series Chipset Family
High Definition Audio Controller (rev 04)
00:1c.0 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset Family
PCI Express Root Port 1 (rev c4)
00:1c.2 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset Family
PCI Express Root Port 3 (rev c4)
00:1c.3 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset Family
PCI Express Root Port 4 (rev c4)
00:1d.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset
Family USB Enhanced Host Controller #1 (rev 04)
00:1f.0 ISA bridge: Intel Corporation HM76 Express Chipset LPC Controller
(rev 04)
00:1f.2 SATA controller: Intel Corporation 7 Series Chipset Family 6-port
SATA Controller [AHCI mode] (rev 04)
00:1f.3 SMBus: Intel Corporation 7 Series/C210 Series Chipset Family SMBus
Controller (rev 04)
02:00.0 Network controller: Intel Corporation Centrino Wireless-N 1030 (rev
34)
03:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. Device
5289 (rev 01)
03:00.2 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168B
PCI Express Gigabit Ethernet controller (rev 0a)

dmidecode partial output

Base Board Information
    Manufacturer: System76, Inc.
    Product Name: Pangolin Performance
    Version: panp9
    Serial Number: Not Applicable
    Asset Tag: Tag 12345
    Features:
        Board is a hosting board
        Board is replaceable
    Location In Chassis: Not Applicable
    Chassis Handle: 0x0003
    Type: Motherboard
    Contained Object Handles: 0

BIOS Information
    Vendor: American Megatrends Inc.
    Version: 4.6.5
    Release Date: 06/25/2012
    Address: 0xF0000
    Runtime Size: 64 kB
    ROM Size: 4096 kB
    Characteristics:
        PCI is supported
        BIOS is upgradeable
        BIOS shadowing is allowed
        Boot from CD is supported
        Selectable boot is supported
        EDD is supported
        Print screen service is supported (int 5h)
        8042 keyboard services are supported (int 9h)
        Printer services are supported (int 17h)
        ACPI is supported
        USB legacy is supported
        BIOS boot specification is supported
        Targeted content distribution is supported
        UEFI is supported
    BIOS Revision: 4.6

I already posted the problem on Ubuntu Forum but no answer:

http://ubuntuforums.org/showthread.php?t=3D2089824

All suggestions are welcomed.
I am sorry but I am not an expert.

Thanks,
Yiuri

--bcaec51b1a73d5bf3304d365ea3d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hi All.<br><br></div><div>I have a small problem=
 with my new pc: sensor-detect is unable to detect the fan speed.<br></div>=
<br></div><div>The pc is a System 76 Pangolin panp9 ( =3D Clevo W24AEU =3D =
Sager NP2240 I think).<br>
</div><div><br></div>CPU Intel(R) Core(TM) i7-3630QM CPU @ 2.40GHz<br><div>=
<br>sensors output:<br>
<br>
acpitz-virtual-0<br>
Adapter: Virtual device<br>
temp1:        +74.0=B0C  (crit =3D +120.0=B0C)<br>
<br>
coretemp-isa-0000<br>
Adapter: ISA adapter<br>
Physical id 0:  +75.0=B0C  (high =3D +87.0=B0C, crit =3D +105.0=B0C)<br>
Core 0:         +73.0=B0C  (high =3D +87.0=B0C, crit =3D +105.0=B0C)<br>
Core 1:         +74.0=B0C  (high =3D +87.0=B0C, crit =3D +105.0=B0C)<br>
Core 2:         +71.0=B0C  (high =3D +87.0=B0C, crit =3D +105.0=B0C)<br>
Core 3:         +71.0=B0C  (high =3D +87.0=B0C, crit =3D +105.0=B0C)<br>
<br>lspci output:<br><div><div><div><div><br>00:00.0 Host bridge: Intel Cor=
poration 3rd Gen Core processor DRAM Controller (rev 09)<br>00:02.0 VGA com=
patible controller: Intel Corporation 3rd Gen Core processor Graphics Contr=
oller (rev 09)<br>
00:14.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset Fami=
ly USB xHCI Host Controller (rev 04)<br>00:16.0 Communication controller: I=
ntel Corporation 7 Series/C210 Series Chipset Family MEI Controller #1 (rev=
 04)<br>
00:1a.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset Fami=
ly USB Enhanced Host Controller #2 (rev 04)<br>00:1b.0 Audio device: Intel =
Corporation 7 Series/C210 Series Chipset Family High Definition Audio Contr=
oller (rev 04)<br>
00:1c.0 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset Family P=
CI Express Root Port 1 (rev c4)<br>00:1c.2 PCI bridge: Intel Corporation 7 =
Series/C210 Series Chipset Family PCI Express Root Port 3 (rev c4)<br>00:1c=
.3 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset Family PCI Ex=
press Root Port 4 (rev c4)<br>
00:1d.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset Fami=
ly USB Enhanced Host Controller #1 (rev 04)<br>00:1f.0 ISA bridge: Intel Co=
rporation HM76 Express Chipset LPC Controller (rev 04)<br>00:1f.2 SATA cont=
roller: Intel Corporation 7 Series Chipset Family 6-port SATA Controller [A=
HCI mode] (rev 04)<br>
00:1f.3 SMBus: Intel Corporation 7 Series/C210 Series Chipset Family SMBus =
Controller (rev 04)<br>02:00.0 Network controller: Intel Corporation Centri=
no Wireless-N 1030 (rev 34)<br>03:00.0 Unassigned class [ff00]: Realtek Sem=
iconductor Co., Ltd. Device 5289 (rev 01)<br>
03:00.2 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168B =
PCI Express Gigabit Ethernet controller (rev 0a)<br><br>dmidecode partial o=
utput<br><br>Base Board Information<br>=A0=A0=A0 Manufacturer: System76, In=
c.=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>
=A0=A0=A0 Product Name: Pangolin Performance=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 <br>=A0=A0=A0 Version: panp9=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>=A0=A0=A0 Serial Number: Not Appli=
cable=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>=A0=A0=A0 Asse=
t Tag: Tag 12345<br>=A0=A0=A0 Features:<br>=A0=A0=A0 =A0=A0=A0 Board is a h=
osting board<br>
=A0=A0=A0 =A0=A0=A0 Board is replaceable<br>=A0=A0=A0 Location In Chassis: =
Not Applicable<br>=A0=A0=A0 Chassis Handle: 0x0003<br>=A0=A0=A0 Type: Mothe=
rboard<br>=A0=A0=A0 Contained Object Handles: 0<br><br>BIOS Information<br>=
=A0=A0=A0 Vendor: American Megatrends Inc.<br>
=A0=A0=A0 Version: 4.6.5<br>=A0=A0=A0 Release Date: 06/25/2012<br>=A0=A0=A0=
 Address: 0xF0000<br>=A0=A0=A0 Runtime Size: 64 kB<br>=A0=A0=A0 ROM Size: 4=
096 kB<br>=A0=A0=A0 Characteristics:<br>=A0=A0=A0 =A0=A0=A0 PCI is supporte=
d<br>=A0=A0=A0 =A0=A0=A0 BIOS is upgradeable<br>=A0=A0=A0 =A0=A0=A0 BIOS sh=
adowing is allowed<br>
=A0=A0=A0 =A0=A0=A0 Boot from CD is supported<br>=A0=A0=A0 =A0=A0=A0 Select=
able boot is supported<br>=A0=A0=A0 =A0=A0=A0 EDD is supported<br>=A0=A0=A0=
 =A0=A0=A0 Print screen service is supported (int 5h)<br>=A0=A0=A0 =A0=A0=
=A0 8042 keyboard services are supported (int 9h)<br>=A0=A0=A0 =A0=A0=A0 Pr=
inter services are supported (int 17h)<br>
=A0=A0=A0 =A0=A0=A0 ACPI is supported<br>=A0=A0=A0 =A0=A0=A0 USB legacy is =
supported<br>=A0=A0=A0 =A0=A0=A0 BIOS boot specification is supported<br>=
=A0=A0=A0 =A0=A0=A0 Targeted content distribution is supported<br>=A0=A0=A0=
 =A0=A0=A0 UEFI is supported<br>=A0=A0=A0 BIOS Revision: 4.6<br>
<br></div><div>I already posted the problem on Ubuntu Forum but no answer:<=
br><br><a href=3D"http://ubuntuforums.org/showthread.php?t=3D2089824">http:=
//ubuntuforums.org/showthread.php?t=3D2089824</a><br><br>All suggestions ar=
e welcomed.<br>
</div><div>I am sorry but I am not an expert.<br></div><div><br></div><div>=
Thanks,<br></div><div>Yiuri<br>
</div></div></div></div></div></div>

--bcaec51b1a73d5bf3304d365ea3d--


--===============6718522677314451293==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6718522677314451293==--
