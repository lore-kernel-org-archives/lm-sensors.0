From: Lee Harris <lee.r.harris@googlemail.com>
Date: Tue, 29 Jan 2008 18:49:02 +0000
Subject: [lm-sensors] Help with readings (k8temp - dme1737)
Message-Id: <479F751E.6080707@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi

I have installed lm-sensors on a remote server as it has been crashing=20
every few days and the logs show no obvious OS / software issues.

I have got lm-sensors working I think ( after updating my kernel)

My questions are:
What is RD1 temp ?
Which is the true cpu temp ? Core1 from K8temp or CPU temp from dme1737.=20
I ran a kernel compiling loop to 'burn' the cpu a little and both rose=20
about 8=B0C.
But is either a true figure ? Why the 20=B0 difference ?

Sorry I can't give exact info on motherboard model as I have no physical=20
access to the server. I will include some lspci output below.
(I have set some sensors to Ignore in sensors.conf as they showed 0)

Thanks for the software.
Lee

~# sensors
k8temp-pci-00c3
Adapter: PCI adapter
Core1 Temp:
             +42=B0C

dme1737-i2c-0-2e
Adapter: SMBus nForce2 adapter at 88c0
V3.3:      +3.35 V  (min =3D  +0.00 V, max =3D  +4.38 V)
V3.3stby:  +3.31 V  (min =3D  +0.00 V, max =3D  +4.38 V)
Vbat:      +3.01 V  (min =3D  +0.00 V, max =3D  +4.38 V)
RD1 Temp:    +40=B0C  (low  =3D  -127=B0C, high =3D   +61=B0C)
Int Temp:    +44=B0C  (low  =3D  -127=B0C, high =3D   +91=B0C)
CPU Temp:    +60=B0C  (low  =3D  -127=B0C, high =3D   +86=B0C)
CPU_Fan:  1680 RPM  (min =3D    0 RPM)
Fan3:     8557 RPM  (min =3D    0 RPM)
ERROR: Can't get fan5 data!
ERROR: Can't get fan6 data!
CPU_PWM:    67      (enable =3D 2, freq =3D  25000 Hz)
Fan3_PWM:   67      (enable =3D 2, freq =3D  25000 Hz)
ERROR: Can't get pwm5 data!
ERROR: Can't get pwm6 data!
cpu0_vid: +1.350 V  (VRM Version 2.4)

--------------------------------------------

00:00.0 RAM memory: nVidia Corporation C51 Host Bridge (rev a2)
00:00.1 RAM memory: nVidia Corporation C51 Memory Controller 0 (rev a2)
00:00.2 RAM memory: nVidia Corporation C51 Memory Controller 1 (rev a2)
00:00.3 RAM memory: nVidia Corporation C51 Memory Controller 5 (rev a2)
00:00.4 RAM memory: nVidia Corporation C51 Memory Controller 4 (rev a2)
00:00.5 RAM memory: nVidia Corporation C51 Host Bridge (rev a2)
00:00.6 RAM memory: nVidia Corporation C51 Memory Controller 3 (rev a2)
00:00.7 RAM memory: nVidia Corporation C51 Memory Controller 2 (rev a2)
00:02.0 PCI bridge: nVidia Corporation C51 PCI Express Bridge (rev a1)
00:03.0 PCI bridge: nVidia Corporation C51 PCI Express Bridge (rev a1)
00:05.0 VGA compatible controller: nVidia Corporation C51 [GeForce 6150=20
LE] (rev a2)
00:09.0 RAM memory: nVidia Corporation MCP51 Host Bridge (rev a2)
00:0a.0 ISA bridge: nVidia Corporation MCP51 LPC Bridge (rev a3)
00:0a.1 SMBus: nVidia Corporation MCP51 SMBus (rev a3)
00:0b.0 USB Controller: nVidia Corporation MCP51 USB Controller (rev a3)
00:0b.1 USB Controller: nVidia Corporation MCP51 USB Controller (rev a3)
00:0d.0 IDE interface: nVidia Corporation MCP51 IDE (rev f1)
00:0e.0 IDE interface: nVidia Corporation MCP51 Serial ATA Controller=20
(rev f1)
00:10.0 PCI bridge: nVidia Corporation MCP51 PCI Bridge (rev a2)
00:14.0 Ethernet controller: nVidia Corporation MCP51 Ethernet=20
Controller (rev a3)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]=20
HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]=20
Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]=20
DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]=20
Miscellaneous Control

------------------------------------------------

00:0a.1 SMBus: nVidia Corporation MCP51 SMBus (rev a3)
        Subsystem: Fujitsu Siemens Computer GmbH Unknown device 10c6
        Flags: 66MHz, fast devsel, IRQ 10
        I/O ports at 88c0 [sized]
        I/O ports at 8880 [sized]
        Capabilities: [44] Power Management version 2



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
