From: =?UTF-8?B?dHVyZ3V0IGthbGZhb8SfbHU=?= <turgut@kalfaoglu.com>
Date: Thu, 20 May 2010 09:53:30 +0000
Subject: [lm-sensors] trouble configuring an ASUS M51VA laptop
Message-Id: <4BF5069A.7030602@kalfaoglu.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi there. Under Fedora 11, I am unable to get sensors-detect to detect=20
my laptop's ACPI details.
It only finds coretemp, hence /proc/acpi/fans/ folder is empty, and the=20
fan speed cannot be set or read.
I was also unable to find any /etc/sensors3.conf example that had this=20
laptop's hardware.

I was wondering if anyone can assist.
Here is the hardware:


LSPCI:
00:00.0 Host bridge: Intel Corporation Mobile 4 Series Chipset Memory=20
Controller Hub (rev 07)
00:01.0 PCI bridge: Intel Corporation Mobile 4 Series Chipset PCI=20
Express Graphics Port (rev 07)
00:1a.0 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI=20
Controller #4 (rev 03)
00:1a.1 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI=20
Controller #5 (rev 03)
00:1a.2 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI=20
Controller #6 (rev 03)
00:1a.7 USB Controller: Intel Corporation 82801I (ICH9 Family) USB2 EHCI=20
Controller #2 (rev 03)
00:1b.0 Audio device: Intel Corporation 82801I (ICH9 Family) HD Audio=20
Controller (rev 03)
00:1c.0 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express=20
Port 1 (rev 03)
00:1c.2 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express=20
Port 3 (rev 03)
00:1c.3 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express=20
Port 4 (rev 03)
00:1c.4 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express=20
Port 5 (rev 03)
00:1c.5 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express=20
Port 6 (rev 03)
00:1d.0 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI=20
Controller #1 (rev 03)
00:1d.1 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI=20
Controller #2 (rev 03)
00:1d.2 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI=20
Controller #3 (rev 03)
00:1d.7 USB Controller: Intel Corporation 82801I (ICH9 Family) USB2 EHCI=20
Controller #1 (rev 03)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 93)
00:1f.0 ISA bridge: Intel Corporation ICH9M LPC Interface Controller=20
(rev 03)
00:1f.2 IDE interface: Intel Corporation ICH9M/M-E 2 port SATA IDE=20
Controller (rev 03)
00:1f.5 IDE interface: Intel Corporation ICH9M/M-E 2 port SATA IDE=20
Controller (rev 03)
01:00.0 VGA compatible controller: ATI Technologies Inc Mobility Radeon=20
HD 3650
01:00.1 Audio device: ATI Technologies Inc RV635 Audio device [Radeon HD=20
3600 Series]
06:00.0 Network controller: Intel Corporation Wireless WiFi Link 5100
07:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.=20
RTL8111/8168B PCI Express Gigabit Ethernet controller (rev 02)
08:01.0 FireWire (IEEE 1394): Ricoh Co Ltd R5C832 IEEE 1394 Controller=20
(rev 05)
08:01.1 SD Host controller: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro=20
Host Adapter (rev 22)
08:01.2 System peripheral: Ricoh Co Ltd R5C843 MMC Host Controller (rev 12)
08:01.3 System peripheral: Ricoh Co Ltd R5C592 Memory Stick Bus Host=20
Adapter (rev 12)
08:01.4 System peripheral: Ricoh Co Ltd xD-Picture Card Controller (rev ff)


LSHW:
tklaptop.kalfaoglu.com
     description: Notebook
     product: M51Va
     vendor: ASUSTeK Computer Inc.
     version: 1.0
     serial: NF1S8823370099
     width: 64 bits
     capabilities: smbios-2.5 dmi-2.5 vsyscall64 vsyscall32
     configuration: chassis=3Dnotebook=20
uuid=B13181DD-4EDC-DE47-C500-00221527E0F2
   *-core
        description: Motherboard
        product: M51Va
        vendor: ASUSTeK Computer Inc.
        physical id: 0
        version: 1.0
        serial: BSN12345678901234567
        slot: MIDDLE
      *-firmware
           description: BIOS
           vendor: American Megatrends Inc.
           physical id: 0
           version: 211 (11/17/2008)
           size: 64KiB
           capacity: 960KiB
           capabilities: isa pci pnp upgrade shadowing escd cdboot=20
bootselect edd int13floppy1200 int13floppy720 int13floppy2880=20
int5printscreen int9keyboard int17printer int10video acpi usb=20
smartbattery biosbootspecification netboot
      *-cpu
           description: CPU
           product: Intel(R) Core(TM)2 Duo CPU     T9400  @ 2.53GHz
           vendor: Intel Corp.
           physical id: 4
           bus info: cpu@0
           version: Intel(R) Core(TM)2 Duo CPU T9400 @ 2.53GHz
           serial: PSN12345678901234567
           slot: Socket 478
           size: 800MHz
           capacity: 800MHz
           width: 64 bits
           clock: 267MHz
           capabilities: fpu fpu_exception wp vme de pse tsc msr pae mce=20
cx8 apic mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2=20
ss ht tm pbe syscall nx x86-64 constant_tsc arch_perfmon pebs bts=20
rep_good pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm=20
sse4_1 lahf_lm tpr_shadow vnmi flexpriority cpufreq
         *-cache:0
              description: L1 cache
              physical id: 5
              slot: L1-Cache
              size: 64KiB
              capacity: 64KiB
              capabilities: internal write-back data
         *-cache:1
              description: L2 cache
              physical id: 7
              slot: L2-Cache
              size: 6MiB
              capacity: 6MiB
              capabilities: internal write-back unified
      *-cache
           description: L1 cache
           physical id: 6
           slot: L1-Cache
           size: 64KiB
           capacity: 64KiB
           capabilities: internal write-back instruction
      *-memory
           description: System Memory
           physical id: 1a
           slot: System board or motherboard
           size: 4GiB
         *-bank:0
              description: SODIMM DDR2 Synchronous 800 MHz (1.2 ns)
              product: N/A
              vendor: N/A
              physical id: 0
              serial: N/A
              slot: SODIMM0
              size: 2GiB
              width: 64 bits
              clock: 800MHz (1.2ns)
         *-bank:1
              description: SODIMM DDR2 Synchronous 800 MHz (1.2 ns)
              product: N/A
              vendor: N/A
              physical id: 1
              serial: N/A
              slot: SODIMM1
              size: 2GiB
              width: 64 bits
              clock: 800MHz (1.2ns)
      *-pci
           description: Host bridge
           product: Mobile 4 Series Chipset Memory Controller Hub
           vendor: Intel Corporation
           physical id: 100
           bus info: pci@0000:00:00.0
           version: 07
           width: 32 bits
           clock: 33MHz
         *-pci:0
              description: PCI bridge
              product: Mobile 4 Series Chipset PCI Express Graphics Port
              vendor: Intel Corporation
              physical id: 1
              bus info: pci@0000:00:01.0
              version: 07
              width: 32 bits
              clock: 33MHz
              capabilities: pci pm msi pciexpress normal_decode=20
bus_master cap_list
              configuration: driver=3Dpcieport-driver
              resources: irq:24 ioport:c000(size@96)=20
memory:fdf00000-fdffffff ioport:d0000000(size&8435456)
            *-display
                 description: VGA compatible controller
                 product: Mobility Radeon HD 3650
                 vendor: ATI Technologies Inc
                 physical id: 0
                 bus info: pci@0000:01:00.0
                 version: 00
                 width: 32 bits
                 clock: 33MHz
                 capabilities: pm pciexpress msi vga_controller=20
bus_master cap_list rom
                 configuration: driver=3Dfglrx_pci latency=3D0
                 resources: irq:32=20
memory:d0000000-dfffffff(prefetchable) ioport:c000(size%6)=20
memory:fdff0000-fdffffff memory:fdf00000-fdf1ffff(prefetchable)
            *-multimedia
                 description: Audio device
                 product: RV635 Audio device [Radeon HD 3600 Series]
                 vendor: ATI Technologies Inc
                 physical id: 0.1
                 bus info: pci@0000:01:00.1
                 version: 00
                 width: 32 bits
                 clock: 33MHz
                 capabilities: pm pciexpress msi bus_master cap_list
                 configuration: driver=3DHDA Intel latency=3D0
                 resources: irq:17 memory:fdfec000-fdfeffff
         *-usb:0
              description: USB Controller
              product: 82801I (ICH9 Family) USB UHCI Controller #4
              vendor: Intel Corporation
              physical id: 1a
              bus info: pci@0000:00:1a.0
              version: 03
              width: 32 bits
              clock: 33MHz
              capabilities: uhci bus_master cap_list
              configuration: driver=3Duhci_hcd latency=3D0
              resources: irq:16 ioport:bc00(size2)
            *-usbhost
                 product: UHCI Host Controller
                 vendor: Linux 2.6.30.10-105.2.23.fc11.x86_64 uhci_hcd
                 physical id: 1
                 bus info: usb@3
                 logical name: /dev/usb3
                 version: 2.06
                 capabilities: usb-1.10
                 configuration: driver=3Dhub slots=3D2 speed=12.0MB/s
         *-usb:1
              description: USB Controller
              product: 82801I (ICH9 Family) USB UHCI Controller #5
              vendor: Intel Corporation
              physical id: 1a.1
              bus info: pci@0000:00:1a.1
              version: 03
              width: 32 bits
              clock: 33MHz
              capabilities: uhci bus_master cap_list
              configuration: driver=3Duhci_hcd latency=3D0
              resources: irq:21 ioport:b880(size2)
            *-usbhost
                 product: UHCI Host Controller
                 vendor: Linux 2.6.30.10-105.2.23.fc11.x86_64 uhci_hcd
                 physical id: 1
                 bus info: usb@4
                 logical name: /dev/usb4
                 version: 2.06
                 capabilities: usb-1.10
                 configuration: driver=3Dhub slots=3D2 speed=12.0MB/s
         *-usb:2
              description: USB Controller
              product: 82801I (ICH9 Family) USB UHCI Controller #6
              vendor: Intel Corporation
              physical id: 1a.2
              bus info: pci@0000:00:1a.2
              version: 03
              width: 32 bits
              clock: 33MHz
              capabilities: uhci bus_master cap_list
              configuration: driver=3Duhci_hcd latency=3D0
              resources: irq:19 ioport:b800(size2)
            *-usbhost
                 product: UHCI Host Controller
                 vendor: Linux 2.6.30.10-105.2.23.fc11.x86_64 uhci_hcd
                 physical id: 1
                 bus info: usb@5
                 logical name: /dev/usb5
                 version: 2.06
                 capabilities: usb-1.10
                 configuration: driver=3Dhub slots=3D2 speed=12.0MB/s
               *-usb:0
                    description: Bluetooth wireless interface
                    product: BT-253
                    vendor: Broadcom Corp
                    physical id: 1
                    bus info: usb@5:1
                    version: 2.35
                    serial: 0015AFFDF2F2
                    capabilities: bluetooth usb-2.00
                    configuration: driver=3Dbtusb speed=12.0MB/s
               *-usb:1 UNCLAIMED
                    description: Generic USB device
                    product: Fingerprint Sensor
                    vendor: AuthenTec, Inc.
                    physical id: 2
                    bus info: usb@5:2
                    version: c.10
                    capabilities: usb-1.10
                    configuration: maxpower=100mA speed=12.0MB/s
         *-usb:3
              description: USB Controller
              product: 82801I (ICH9 Family) USB2 EHCI Controller #2
              vendor: Intel Corporation
              physical id: 1a.7
              bus info: pci@0000:00:1a.7
              version: 03
              width: 32 bits
              clock: 33MHz
              capabilities: pm debug ehci bus_master cap_list
              configuration: driver=3Dehci_hcd latency=3D0
              resources: irq:18 memory:fdeffc00-fdefffff
            *-usbhost
                 product: EHCI Host Controller
                 vendor: Linux 2.6.30.10-105.2.23.fc11.x86_64 ehci_hcd
                 physical id: 1
                 bus info: usb@1
                 logical name: /dev/usb1
                 version: 2.06
                 capabilities: usb-2.00
                 configuration: driver=3Dhub slots=3D6 speedH0.0MB/s
         *-multimedia
              description: Audio device
              product: 82801I (ICH9 Family) HD Audio Controller
              vendor: Intel Corporation
              physical id: 1b
              bus info: pci@0000:00:1b.0
              version: 03
              width: 64 bits
              clock: 33MHz
              capabilities: pm msi pciexpress bus_master cap_list
              configuration: driver=3DHDA Intel latency=3D0
              resources: irq:22 memory:fdef8000-fdefbfff
         *-pci:1
              description: PCI bridge
              product: 82801I (ICH9 Family) PCI Express Port 1
              vendor: Intel Corporation
              physical id: 1c
              bus info: pci@0000:00:1c.0
              version: 03
              width: 32 bits
              clock: 33MHz
              capabilities: pci pciexpress msi pm normal_decode=20
bus_master cap_list
              configuration: driver=3Dpcieport-driver
              resources: irq:25
         *-pci:2
              description: PCI bridge
              product: 82801I (ICH9 Family) PCI Express Port 3
              vendor: Intel Corporation
              physical id: 1c.2
              bus info: pci@0000:00:1c.2
              version: 03
              width: 32 bits
              clock: 33MHz
              capabilities: pci pciexpress msi pm normal_decode=20
bus_master cap_list
              configuration: driver=3Dpcieport-driver
              resources: irq:26 ioport:d000(size@96)=20
memory:fe000000-fe8fffff ioport:fa000000(sizeI283072)
         *-pci:3
              description: PCI bridge
              product: 82801I (ICH9 Family) PCI Express Port 4
              vendor: Intel Corporation
              physical id: 1c.3
              bus info: pci@0000:00:1c.3
              version: 03
              width: 32 bits
              clock: 33MHz
              capabilities: pci pciexpress msi pm normal_decode=20
bus_master cap_list
              configuration: driver=3Dpcieport-driver
              resources: irq:27
         *-pci:4
              description: PCI bridge
              product: 82801I (ICH9 Family) PCI Express Port 5
              vendor: Intel Corporation
              physical id: 1c.4
              bus info: pci@0000:00:1c.4
              version: 03
              width: 32 bits
              clock: 33MHz
              capabilities: pci pciexpress msi pm normal_decode=20
bus_master cap_list
              configuration: driver=3Dpcieport-driver
              resources: irq:28 memory:fe900000-fe9fffff
            *-network
                 description: Wireless interface
                 product: Wireless WiFi Link 5100
                 vendor: Intel Corporation
                 physical id: 0
                 bus info: pci@0000:06:00.0
                 logical name: wmaster0
                 version: 00
                 serial: 00:16:ea:8a:66:de
                 width: 64 bits
                 clock: 33MHz
                 capabilities: pm msi pciexpress bus_master cap_list=20
logical ethernet physical wireless
                 configuration: broadcast=3Dyes driver=3Diwlagn=20
ip=10.1.116.35 latency=3D0 multicast=3Dyes wireless=3DIEEE 802.11abgn
                 resources: irq:31 memory:fe9fe000-fe9fffff
         *-pci:5
              description: PCI bridge
              product: 82801I (ICH9 Family) PCI Express Port 6
              vendor: Intel Corporation
              physical id: 1c.5
              bus info: pci@0000:00:1c.5
              version: 03
              width: 32 bits
              clock: 33MHz
              capabilities: pci pciexpress msi pm normal_decode=20
bus_master cap_list
              configuration: driver=3Dpcieport-driver
              resources: irq:29 ioport:e000(size@96)=20
memory:fea00000-feafffff ioport:fcf00000(size=1048576)
            *-network
                 description: Ethernet interface
                 product: RTL8111/8168B PCI Express Gigabit Ethernet=20
controller
                 vendor: Realtek Semiconductor Co., Ltd.
                 physical id: 0
                 bus info: pci@0000:07:00.0
                 logical name: eth0
                 version: 02
                 serial: 00:22:15:27:e0:f2
                 size: 10MB/s
                 capacity: 1GB/s
                 width: 64 bits
                 clock: 33MHz
                 capabilities: pm msi pciexpress msix vpd bus_master=20
cap_list rom ethernet physical tp mii 10bt 10bt-fd 100bt 100bt-fd 1000bt=20
1000bt-fd autonegotiation
                 configuration: autonegotiation=3Don broadcast=3Dyes=20
driver=3Dr8169 driverversion=3D2.3LK-NAPI duplex=3Dhalf latency=3D0 link=3D=
no=20
multicast=3Dyes port=3DMII speed=10MB/s
                 resources: irq:30 ioport:e800(size%6)=20
memory:fcfff000-fcffffff(prefetchable)=20
memory:fcfe0000-fcfeffff(prefetchable)=20
memory:feaf0000-feafffff(prefetchable)
         *-usb:4
              description: USB Controller
              product: 82801I (ICH9 Family) USB UHCI Controller #1
              vendor: Intel Corporation
              physical id: 1d
              bus info: pci@0000:00:1d.0
              version: 03
              width: 32 bits
              clock: 33MHz
              capabilities: uhci bus_master cap_list
              configuration: driver=3Duhci_hcd latency=3D0
              resources: irq:23 ioport:b480(size2)
            *-usbhost
                 product: UHCI Host Controller
                 vendor: Linux 2.6.30.10-105.2.23.fc11.x86_64 uhci_hcd
                 physical id: 1
                 bus info: usb@6
                 logical name: /dev/usb6
                 version: 2.06
                 capabilities: usb-1.10
                 configuration: driver=3Dhub slots=3D2 speed=12.0MB/s
               *-usb
                    description: Mouse
                    product: USB Optical Mouse
                    vendor: Logitech
                    physical id: 1
                    bus info: usb@6:1
                    version: 43.01
                    capabilities: usb-2.00
                    configuration: driver=3Dusbhid maxpower=100mA=20
speed=3D1.5MB/s
         *-usb:5
              description: USB Controller
              product: 82801I (ICH9 Family) USB UHCI Controller #2
              vendor: Intel Corporation
              physical id: 1d.1
              bus info: pci@0000:00:1d.1
              version: 03
              width: 32 bits
              clock: 33MHz
              capabilities: uhci bus_master cap_list
              configuration: driver=3Duhci_hcd latency=3D0
              resources: irq:19 ioport:b400(size2)
            *-usbhost
                 product: UHCI Host Controller
                 vendor: Linux 2.6.30.10-105.2.23.fc11.x86_64 uhci_hcd
                 physical id: 1
                 bus info: usb@7
                 logical name: /dev/usb7
                 version: 2.06
                 capabilities: usb-1.10
                 configuration: driver=3Dhub slots=3D2 speed=12.0MB/s
         *-usb:6
              description: USB Controller
              product: 82801I (ICH9 Family) USB UHCI Controller #3
              vendor: Intel Corporation
              physical id: 1d.2
              bus info: pci@0000:00:1d.2
              version: 03
              width: 32 bits
              clock: 33MHz
              capabilities: uhci bus_master cap_list
              configuration: driver=3Duhci_hcd latency=3D0
              resources: irq:18 ioport:b080(size2)
            *-usbhost
                 product: UHCI Host Controller
                 vendor: Linux 2.6.30.10-105.2.23.fc11.x86_64 uhci_hcd
                 physical id: 1
                 bus info: usb@8
                 logical name: /dev/usb8
                 version: 2.06
                 capabilities: usb-1.10
                 configuration: driver=3Dhub slots=3D2 speed=12.0MB/s
         *-usb:7
              description: USB Controller
              product: 82801I (ICH9 Family) USB2 EHCI Controller #1
              vendor: Intel Corporation
              physical id: 1d.7
              bus info: pci@0000:00:1d.7
              version: 03
              width: 32 bits
              clock: 33MHz
              capabilities: pm debug ehci bus_master cap_list
              configuration: driver=3Dehci_hcd latency=3D0
              resources: irq:23 memory:fdeff800-fdeffbff
            *-usbhost
                 product: EHCI Host Controller
                 vendor: Linux 2.6.30.10-105.2.23.fc11.x86_64 ehci_hcd
                 physical id: 1
                 bus info: usb@2
                 logical name: /dev/usb2
                 version: 2.06
                 capabilities: usb-2.00
                 configuration: driver=3Dhub slots=3D6 speedH0.0MB/s
               *-usb
                    description: Video
                    product: USB2.0 1.3M UVC WebCam
                    vendor: Chicony Electronics Co., Ltd
                    physical id: 5
                    bus info: usb@2:5
                    version: 60.12
                    capabilities: usb-2.00
                    configuration: driver=3Duvcvideo maxpowerP0mA=20
speedH0.0MB/s
         *-pci:6
              description: PCI bridge
              product: 82801 Mobile PCI Bridge
              vendor: Intel Corporation
              physical id: 1e
              bus info: pci@0000:00:1e.0
              version: 93
              width: 32 bits
              clock: 33MHz
              capabilities: pci subtractive_decode bus_master cap_list
              resources: memory:feb00000-febfffff
            *-firewire
                 description: FireWire (IEEE 1394)
                 product: R5C832 IEEE 1394 Controller
                 vendor: Ricoh Co Ltd
                 physical id: 1
                 bus info: pci@0000:08:01.0
                 version: 05
                 width: 32 bits
                 clock: 33MHz
                 capabilities: pm ohci bus_master cap_list
                 configuration: driver=3Dfirewire_ohci latency2=20
maxlatency=3D4 mingnt=3D2
                 resources: irq:16 memory:febff800-febfffff
            *-generic:0
                 description: SD Host controller
                 product: R5C822 SD/SDIO/MMC/MS/MSPro Host Adapter
                 vendor: Ricoh Co Ltd
                 physical id: 1.1
                 bus info: pci@0000:08:01.1
                 version: 22
                 width: 32 bits
                 clock: 33MHz
                 capabilities: pm bus_master cap_list
                 configuration: driver=3Dsdhci-pci latencyd
                 resources: irq:17 memory:febff400-febff4ff
            *-generic:1
                 description: System peripheral
                 product: R5C592 Memory Stick Bus Host Adapter
                 vendor: Ricoh Co Ltd
                 physical id: 1.2
                 bus info: pci@0000:08:01.2
                 version: 12
                 width: 32 bits
                 clock: 33MHz
                 capabilities: pm bus_master cap_list
                 configuration: driver=3Dricoh-mmc latencyd
                 resources: irq:3 memory:febff000-febff0ff
            *-generic:2 UNCLAIMED
                 description: System peripheral
                 product: xD-Picture Card Controller
                 vendor: Ricoh Co Ltd
                 physical id: 1.3
                 bus info: pci@0000:08:01.3
                 version: 12
                 width: 32 bits
                 clock: 33MHz
                 capabilities: pm bus_master cap_list
                 configuration: latencyd
                 resources: memory:febfec00-febfecff
            *-generic:3 UNCLAIMED
                 product: Illegal Vendor ID
                 vendor: Illegal Vendor ID
                 physical id: 1.4
                 bus info: pci@0000:08:01.4
                 version: ff
                 width: 32 bits
                 clock: 66MHz
                 capabilities: bus_master vga_palette cap_list
                 configuration: latency%5 maxlatency%5 mingnt%5
                 resources: memory:febfe800-febfe8ff
         *-isa
              description: ISA bridge
              product: ICH9M LPC Interface Controller
              vendor: Intel Corporation
              physical id: 1f
              bus info: pci@0000:00:1f.0
              version: 03
              width: 32 bits
              clock: 33MHz
              capabilities: isa bus_master cap_list
              configuration: latency=3D0
         *-ide:0
              description: IDE interface
              product: ICH9M/M-E 2 port SATA IDE Controller
              vendor: Intel Corporation
              physical id: 1f.2
              bus info: pci@0000:00:1f.2
              logical name: scsi0
              logical name: scsi1
              version: 03
              width: 32 bits
              clock: 66MHz
              capabilities: ide pm bus_master cap_list emulated
              configuration: driver=3Data_piix latency=3D0
              resources: irq:19 ioport:b000(size=3D8) ioport:ac00(size=3D4)=
=20
ioport:a880(size=3D8) ioport:a800(size=3D4) ioport:a480(size=16)=20
ioport:a400(size=16)
            *-disk
                 description: ATA Disk
                 product: ST9320320AS
                 vendor: Seagate
                 physical id: 0
                 bus info: scsi@0:0.0.0
                 logical name: /dev/sda
                 version: 0303
                 serial: 5SX0Q5H0
                 size: 298GiB (320GB)
                 capabilities: partitioned partitioned:dos
                 configuration: ansiversion=3D5 signature=C2f97762
               *-volume:0
                    description: EXT3 volume
                    vendor: Linux
                    physical id: 1
                    bus info: scsi@0:0.0.0,1
                    logical name: /dev/sda1
                    logical name: /yeni
                    version: 1.0
                    serial: b1752c5a-d66c-4e16-a8ec-0486309c6103
                    size: 94GiB
                    capacity: 94GiB
                    capabilities: primary journaled extended_attributes=20
large_files recover ext3 ext2 initialized
                    configuration: created 09-08-05 00:29:28=20
filesystem=3Dext3 label=3Dyeni modified 10-05-20 10:59:24=20
mount.fstype=3Dext3 mount.options=3Drw,noatime,errors=3Dcontinue,data=3Dord=
ered=20
mounted 10-05-20 10:59:24 state=3Dmounted
               *-volume:1
                    description: Windows NTFS volume
                    physical id: 2
                    bus info: scsi@0:0.0.0,2
                    logical name: /dev/sda2
                    logical name: /win
                    version: 3.1
                    serial: 8e241a81-77f0-ee4b-87b7-c901b2563938
                    size: 64GiB
                    capacity: 64GiB
                    capabilities: primary bootable ntfs initialized
                    configuration: clustersize@96 created 08-08-19=20
03:16:37 filesystem=3Dntfs label=3DVistaOS modified_by_chkdsk=3Dtrue=20
mount.fstype=3Dfuseblk=20
mount.options=3Drw,nosuid,nodev,relatime,user_id=3D0,group_id=3D0,default_p=
ermissions,allow_other,blksize@96=20
mounted_on_nt4=3Dtrue resize_log_file=3Dtrue state=3Dmounted upgrade_on_mou=
nt=3Dtrue
               *-volume:2
                    description: Extended partition
                    physical id: 3
                    bus info: scsi@0:0.0.0,3
                    logical name: /dev/sda3
                    size: 139GiB
                    capacity: 139GiB
                    capabilities: primary extended partitioned=20
partitioned:extended
                  *-logicalvolume:0
                       description: Linux filesystem partition
                       physical id: 5
                       logical name: /dev/sda5
                       logical name: /
                       capacity: 135GiB
                       configuration: mount.fstype=3Dext3=20
mount.options=3Drw,noatime,errors=3Dcontinue,user_xattr,acl,data=3Dordered =

state=3Dmounted
                  *-logicalvolume:1
                       description: Linux swap / Solaris partition
                       physical id: 6
                       logical name: /dev/sda6
                       capacity: 3999MiB
                       capabilities: nofs
            *-cdrom
                 description: DVD-RAM writer
                 product: DVDRAM GSA-T50N
                 vendor: HL-DT-ST
                 physical id: 1
                 bus info: scsi@1:0.0.0
                 logical name: /dev/cdrom
                 logical name: /dev/cdrw
                 logical name: /dev/dvd
                 logical name: /dev/dvdrw
                 logical name: /dev/scd0
                 logical name: /dev/sr0
                 version: RR04
                 capabilities: removable audio cd-r cd-rw dvd dvd-r dvd-ram
                 configuration: ansiversion=3D5 status=3Dnodisc
         *-ide:1
              description: IDE interface
              product: ICH9M/M-E 2 port SATA IDE Controller
              vendor: Intel Corporation
              physical id: 1f.5
              bus info: pci@0000:00:1f.5
              version: 03
              width: 32 bits
              clock: 66MHz
              capabilities: ide pm bus_master cap_list
              configuration: driver=3Data_piix latency=3D0
              resources: irq:19 ioport:a000(size=3D8) ioport:9c00(size=3D4)=
=20
ioport:9880(size=3D8) ioport:9800(size=3D4) ioport:9480(size=16)=20
ioport:9400(size=16)
   *-battery
        description: Other Battery
        product: F3---24-Ion
        vendor: AS0126K33E.08/11/97
        physical id: 1
        version: 08 08 15
        serial: 4890T Ver 0123
        slot: In the back
        capacity: 4800mWh
        configuration: voltage=11.1V
   *-network DISABLED
        description: Ethernet interface
        physical id: 2
        logical name: vboxnet0
        serial: 0a:00:27:00:00:00
        capabilities: ethernet physical
        configuration: broadcast=3Dyes multicast=3Dyes


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
