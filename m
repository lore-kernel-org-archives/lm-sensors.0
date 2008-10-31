From: Michelasso <qzerty@gmail.com>
Date: Fri, 31 Oct 2008 10:08:44 +0000
Subject: [lm-sensors] sensors detect correct temperatures,
Message-Id: <4c9b1dcc0810310308g6feee291xb7b9f1b0caae8bc4@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello everybody,
I have installed lm-sensors 3.0.2, latest version available on Ubuntu
Intrepid, and linux kernel is 2.6.27 . My notebook is an Acer Aspire
5024, and it has an AMD Turion ML-34 cpu; here's the output of lspci:

00:00.0 Host bridge: ATI Technologies Inc RS480 Host Bridge (rev 01)
00:02.0 PCI bridge: ATI Technologies Inc RS480 PCI-X Root Port
00:06.0 PCI bridge: ATI Technologies Inc RS480 PCI Bridge
00:07.0 PCI bridge: ATI Technologies Inc RS480 PCI Bridge
00:13.0 USB Controller: ATI Technologies Inc IXP SB400 USB Host Controller
00:13.1 USB Controller: ATI Technologies Inc IXP SB400 USB Host Controller
00:13.2 USB Controller: ATI Technologies Inc IXP SB400 USB2 Host Controller
00:14.0 SMBus: ATI Technologies Inc IXP SB400 SMBus Controller (rev 11)
00:14.1 IDE interface: ATI Technologies Inc IXP SB400 IDE Controller
00:14.3 ISA bridge: ATI Technologies Inc IXP SB400 PCI-ISA Bridge
00:14.4 PCI bridge: ATI Technologies Inc IXP SB400 PCI-PCI Bridge
00:14.5 Multimedia audio controller: ATI Technologies Inc IXP SB400
AC'97 AudioController (rev 02)
00:14.6 Modem: ATI Technologies Inc SB400 AC'97 Modem Controller (rev 02)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] AddressMap
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Miscellaneous Control
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon
Mobility X700 (PCIE)
06:05.0 Network controller: Broadcom Corporation BCM4318 [AirForce One
54g] 802.11g Wireless LAN Controller (rev 02)
06:06.0 CardBus bridge: Texas Instruments PCIxx21/x515 Cardbus Controller
06:06.2 FireWire (IEEE 1394): Texas Instruments OHCI Compliant IEEE
1394 Host Controller
06:06.3 Mass storage controller: Texas Instruments PCIxx21 Integrated
FlashMedia Controller
06:06.4 SD Host controller: Texas Instruments
PCI6411/6421/6611/6621/7411/7421/7611/7621 Secure Digital Controller
06:07.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169
Gigabit Ethernet (rev 10)

After configuring lm-sensors with sensors-detect, the k8temp module
has been set to load at boot; the temperatures detected seems to be
correct, but I am not quite sure that the way they are reported is
correct. To be clear, here's what "acpi -t" says:

Thermal 0: ok, 54.0 degrees C
Thermal 1: ok, 50.0 degrees C
Thermal 2: ok, 56.0 degrees

while sensors show this:

acpitz-virtual-0
Adapter: Virtual device
temp1:       +56.0=B0C  (crit =3D +102.0=B0C)
temp2:       +50.0=B0C  (crit =3D +83.0=B0C)
temp3:       +54.0=B0C  (crit =3D +115.0=B0C)

k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:  +39.0=B0C

So I am guessing that the correct value ofr my cpu temperature should
be the one of  the tempx one, while sensors seems to say that it is
that 39=B0C value that I don't know what it is. Can anybody give me some
suggestion on how to fix this issue?

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
