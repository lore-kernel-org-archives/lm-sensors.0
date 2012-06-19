From: Michael Markusch <markuschmichael@gmx.de>
Date: Tue, 19 Jun 2012 21:26:31 +0000
Subject: [lm-sensors] Lifebook E8020, no sensors
Message-Id: <4FE0EE87.8080806@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi all,

I have an old Fujitsu Siemens Lifebook E8020 notebook. Since Ubuntu 9.??
update I can not read CPU temperature by lm-sensors. Before that it was
possible to display the temperature, but I can not say how I did it. I
guess, I used coretemp... Now, the notebook runs with
Ubuntu 12.04 and the problem is the same, see the log-files.

What could be the problem?

Thanks,
Michael


Output sensors.pl:

# sensors-detect revision 6040 (2012-04-09 21:33:35 +0200)
# System: FUJITSU SIEMENS LIFEBOOK E8020 (laptop)
# Board: FUJITSU FJNB199

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no): Module
cpuid loaded successfully.
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD Family 10h thermal sensors...                           No
AMD Family 11h thermal sensors...                           No
AMD Family 12h and 14h thermal sensors...                   No
AMD Family 15h thermal sensors...                           No
AMD Family 15h power sensors...                             No
Intel digital thermal sensor...                             No
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal sensor...                                    No
VIA Nano thermal sensor...                                  No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no): Probing for
Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor/ITE'...               No
Trying family `SMSC'...                                     Yes
Found `SMSC LPC47N227 Super IO'
    (no hardware monitoring capabilities)
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor/ITE'...               No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      No

Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually
safe though. Yes, you do have ISA I/O ports even if you do not have any
ISA slots! Do you want to scan the ISA I/O ports? (YES/no): Probing for
`National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no): Using driver
`i2c-i801' for device 0000:00:1f.3: Intel 82801FB ICH6
Module i2c-i801 loaded successfully.
Module i2c-dev loaded successfully.

Next adapter: i915 gmbus disabled (i2c-0)
Do you want to scan it? (YES/no/selectively):
Next adapter: i915 gmbus ssc (i2c-1)
Do you want to scan it? (YES/no/selectively):
Next adapter: i915 GPIOB (i2c-2)
Do you want to scan it? (YES/no/selectively):
Next adapter: i915 gmbus vga (i2c-3)
Do you want to scan it? (YES/no/selectively): Client found at address 0x4a
Probing for `National Semiconductor LM75'...                No
Probing for `National Semiconductor LM75A'...               No
Probing for `Dallas Semiconductor DS75'...                  No
Probing for `National Semiconductor LM77'...                No
Probing for `Analog Devices ADT7410'...                     No
Probing for `Analog Devices ADT7411'...                     No
Probing for `Dallas Semiconductor DS1621/DS1631'...         No
Probing for `Maxim MAX6642'...                              No
Probing for `National Semiconductor LM73'...                No
Probing for `National Semiconductor LM92'...                No
Probing for `National Semiconductor LM76'...                No
Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
Probing for `NXP/Philips SA56004'...                        No
Client found at address 0x4b
Probing for `National Semiconductor LM75'...                No
Probing for `National Semiconductor LM75A'...               No
Probing for `Dallas Semiconductor DS75'...                  No
Probing for `National Semiconductor LM77'...                No
Probing for `Analog Devices ADT7410'...                     No
Probing for `Analog Devices ADT7411'...                     No
Probing for `Dallas Semiconductor DS1621/DS1631'...         No
Probing for `Maxim MAX6642'...                              No
Probing for `National Semiconductor LM92'...                No
Probing for `National Semiconductor LM76'...                No
Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
Probing for `NXP/Philips SA56004'...                        No
Probing for `Analog Devices ADT7481'...                     No

Next adapter: i915 GPIOA (i2c-4)
Do you want to scan it? (YES/no/selectively): Client found at address 0x4a
Probing for `National Semiconductor LM75'...                No
Probing for `National Semiconductor LM75A'...               No
Probing for `Dallas Semiconductor DS75'...                  No
Probing for `National Semiconductor LM77'...                No
Probing for `Analog Devices ADT7410'...                     No
Probing for `Analog Devices ADT7411'...                     No
Probing for `Dallas Semiconductor DS1621/DS1631'...         No
Probing for `Maxim MAX6642'...                              No
Probing for `National Semiconductor LM73'...                No
Probing for `National Semiconductor LM92'...                No
Probing for `National Semiconductor LM76'...                No
Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
Probing for `NXP/Philips SA56004'...                        No
Client found at address 0x4b
Probing for `National Semiconductor LM75'...                No
Probing for `National Semiconductor LM75A'...               No
Probing for `Dallas Semiconductor DS75'...                  No
Probing for `National Semiconductor LM77'...                No
Probing for `Analog Devices ADT7410'...                     No
Probing for `Analog Devices ADT7411'...                     No
Probing for `Dallas Semiconductor DS1621/DS1631'...         No
Probing for `Maxim MAX6642'...                              No
Probing for `National Semiconductor LM92'...                No
Probing for `National Semiconductor LM76'...                No
Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
Probing for `NXP/Philips SA56004'...                        No
Probing for `Analog Devices ADT7481'...                     No

Next adapter: i915 gmbus panel (i2c-5)
Do you want to scan it? (YES/no/selectively):
Next adapter: i915 GPIOC (i2c-6)
Do you want to scan it? (YES/no/selectively):
Next adapter: i915 gmbus dpc (i2c-7)
Do you want to scan it? (YES/no/selectively):
Next adapter: i915 GPIOD (i2c-8)
Do you want to scan it? (YES/no/selectively):
Next adapter: i915 gmbus dpb (i2c-9)
Do you want to scan it? (YES/no/selectively):
Next adapter: i915 GPIOE (i2c-10)
Do you want to scan it? (YES/no/selectively):
Next adapter: i915 gmbus reserved (i2c-11)
Do you want to scan it? (YES/no/selectively):
Next adapter: i915 gmbus dpd (i2c-12)
Do you want to scan it? (YES/no/selectively):
Next adapter: i915 GPIOF (i2c-13)
Do you want to scan it? (YES/no/selectively):
Next adapter: SDVO DDC proxy (i2c-14)
Do you want to scan it? (YES/no/selectively):
Next adapter: SMBus I801 adapter at 14c0 (i2c-15)
Do you want to scan it? (YES/no/selectively): Client found at address 0x19
Handled by driver `apanel' (already loaded), chip type `fujitsu_apanel'
    (note: this is probably NOT a sensor chip!)

Sorry, no sensors were detected.
This is relatively common on laptops, where thermal management is
handled by ACPI rather than the OS.






Output lshw:

    Beschreibung: Notebook
    Produkt: LIFEBOOK E8020
    Hersteller: FUJITSU SIEMENS
    Version: E8020
    Seriennummer: YBDV097988
    Breite: 32 bits
    F=E4higkeiten: smbios-2.3 dmi-2.3
    Konfiguration: administrator_password=3Ddisabled boot=3Dnormal
chassis=3Dnotebook keyboard_password=3Ddisabled power-on_password=3Ddisabled
uuid=3D141666E6-A20E-11DA-8ED8-000B5DC7C44C
  *-core
       Beschreibung: Hauptplatine
       Produkt: FJNB199
       Hersteller: FUJITSU
       Physische ID: 0
       Version: CP242600-02
       Seriennummer: R5Z00935
     *-firmware
          Beschreibung: BIOS
          Hersteller: FUJITSU // Phoenix Technologies Ltd.
          Physische ID: 0
          Version: Version 1.13
          date: 12/19/2005
          Gr=F6=DFe: 128KiB
          Kapazit=E4t: 960KiB
          F=E4higkeiten: pci pcmcia pnp upgrade shadowing cdboot
bootselect edd int13floppy720 int5printscreen int9keyboard int14serial
int17printer int10video acpi usb biosbootspecification netboot
     *-cpu:0 DEAKTIVIERT
          Beschreibung: CPU [leer]
          Hersteller: Intel Corporation
          Physische ID: 4
          Version: Intel(R) Pentium(R) M processor 760
          Steckplatz: Onboard
        *-cache:0
             Beschreibung: L1 Cache
             Physische ID: 8
             Steckplatz: L1 Cache
             Gr=F6=DFe: 64KiB
             Kapazit=E4t: 64KiB
             F=E4higkeiten: internal write-back
        *-cache:1
             Beschreibung: L2 Cache
             Physische ID: 9
             Steckplatz: L2 Cache
             Gr=F6=DFe: 2MiB
             Kapazit=E4t: 2MiB
             F=E4higkeiten: pipeline-burst synchronous internal write-back
unified
     *-memory
          Beschreibung: Systemspeicher
          Physische ID: 26
          Steckplatz: Systemplatine oder Hauptplatine
          Gr=F6=DFe: 2GiB
          Kapazit=E4t: 2GiB
        *-bank:0
             Beschreibung: SODIMM DDR Synchron 266 MHz (3,8 ns)
             Physische ID: 0
             Steckplatz: DDRII 1
             Gr=F6=DFe: 1GiB
             Breite: 64 bits
             Uhr: 266MHz (3.8ns)
        *-bank:1
             Beschreibung: SODIMM DDR Synchron 266 MHz (3,8 ns)
             Physische ID: 1
             Steckplatz: DDRII 2
             Gr=F6=DFe: 1GiB
             Breite: 64 bits
             Uhr: 266MHz (3.8ns)
     *-cpu:1
          Produkt: Intel(R) Pentium(R) M processor 2.00GHz
          Hersteller: Intel Corp.
          Physische ID: 1
          Bus-Informationen: cpu@0
          Version: 6.13.8
          Gr=F6=DFe: 2GHz
          Kapazit=E4t: 2GHz
          Breite: 32 bits
          F=E4higkeiten: fpu fpu_exception wp vme de pse tsc msr pae mce
cx8 apic sep mtrr pge mca cmov clflush dts acpi mmx fxsr sse sse2 ss tm
pbe nx up bts est tm2 cpufreq
     *-pci
          Beschreibung: Host bridge
          Produkt: Mobile 915GM/PM/GMS/910GML Express Processor to DRAM
Controller
          Hersteller: Intel Corporation
          Physische ID: 100
          Bus-Informationen: pci@0000:00:00.0
          Version: 03
          Breite: 32 bits
          Uhr: 33MHz
          Konfiguration: driver=3Dagpgart-intel
          Ressourcen: irq:0
        *-display:0
             Beschreibung: VGA compatible controller
             Produkt: Mobile 915GM/GMS/910GML Express Graphics Controller
             Hersteller: Intel Corporation
             Physische ID: 2
             Bus-Informationen: pci@0000:00:02.0
             Version: 03
             Breite: 32 bits
             Uhr: 33MHz
             F=E4higkeiten: pm vga_controller bus_master cap_list rom
             Konfiguration: driver=3Di915 latency=3D0
             Ressourcen: irq:16 memory:b0080000-b00fffff
ioport:1400(Gr=F6=DFe=3D8) memory:c0000000-cfffffff memory:b0040000-b007ffff
        *-display:1 UNCLAIMED
             Beschreibung: Display controller
             Produkt: Mobile 915GM/GMS/910GML Express Graphics Controller
             Hersteller: Intel Corporation
             Physische ID: 2.1
             Bus-Informationen: pci@0000:00:02.1
             Version: 03
             Breite: 32 bits
             Uhr: 33MHz
             F=E4higkeiten: pm cap_list
             Konfiguration: latency=3D0
             Ressourcen: memory:80000000-8007ffff
        *-multimedia
             Beschreibung: Audio device
             Produkt: 82801FB/FBM/FR/FW/FRW (ICH6 Family) High
Definition Audio Controller
             Hersteller: Intel Corporation
             Physische ID: 1b
             Bus-Informationen: pci@0000:00:1b.0
             Version: 04
             Breite: 64 bits
             Uhr: 33MHz
             F=E4higkeiten: pm msi pciexpress bus_master cap_list
             Konfiguration: driver=3Dsnd_hda_intel latency=3D0
             Ressourcen: irq:42 memory:b0000000-b0003fff
        *-pci:0
             Beschreibung: PCI bridge
             Produkt: 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 1
             Hersteller: Intel Corporation
             Physische ID: 1c
             Bus-Informationen: pci@0000:00:1c.0
             Version: 04
             Breite: 32 bits
             Uhr: 33MHz
             F=E4higkeiten: pci pciexpress msi pm normal_decode bus_master
cap_list
             Konfiguration: driver=3Dpcieport
             Ressourcen: irq:40 ioport:4000(Gr=F6=DFe=3D4096)
memory:b0100000-b01fffff ioport:80500000(Gr=F6=DFe=3D2097152)
           *-network
                Beschreibung: Ethernet interface
                Produkt: NetXtreme BCM5751M Gigabit Ethernet PCI Express
                Hersteller: Broadcom Corporation
                Physische ID: 0
                Bus-Informationen: pci@0000:02:00.0
                Logischer Name: eth0
                Version: 11
                Seriennummer: 00:0b:5d:c7:c4:4c
                Gr=F6=DFe: 1Gbit/s
                Kapazit=E4t: 1Gbit/s
                Breite: 64 bits
                Uhr: 33MHz
                F=E4higkeiten: pm vpd msi pciexpress bus_master cap_list
ethernet physical tp 10bt 10bt-fd 100bt 100bt-fd 1000bt 1000bt-fd
autonegotiation
                Konfiguration: autonegotiation=3Don broadcast=3Dyes
driver=3Dtg3 driverversion=3D3.121 duplex=3Dfull firmware=3D5751m-v3.40a
ip=3D192.168.2.126 latency=3D0 link=3Dyes multicast=3Dyes port=3Dtwisted pa=
ir
speed=3D1Gbit/s
                Ressourcen: irq:16 memory:b0100000-b010ffff
        *-pci:1
             Beschreibung: PCI bridge
             Produkt: 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 2
             Hersteller: Intel Corporation
             Physische ID: 1c.1
             Bus-Informationen: pci@0000:00:1c.1
             Version: 04
             Breite: 32 bits
             Uhr: 33MHz
             F=E4higkeiten: pci pciexpress msi pm normal_decode bus_master
cap_list
             Konfiguration: driver=3Dpcieport
             Ressourcen: irq:41 ioport:3000(Gr=F6=DFe=3D4096)
memory:80100000-802fffff ioport:80300000(Gr=F6=DFe=3D2097152)
        *-usb:0
             Beschreibung: USB controller
             Produkt: 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1
             Hersteller: Intel Corporation
             Physische ID: 1d
             Bus-Informationen: pci@0000:00:1d.0
             Version: 04
             Breite: 32 bits
             Uhr: 33MHz
             F=E4higkeiten: uhci bus_master
             Konfiguration: driver=3Duhci_hcd latency=3D0
             Ressourcen: irq:23 ioport:1420(Gr=F6=DFe=3D32)
        *-usb:1
             Beschreibung: USB controller
             Produkt: 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2
             Hersteller: Intel Corporation
             Physische ID: 1d.1
             Bus-Informationen: pci@0000:00:1d.1
             Version: 04
             Breite: 32 bits
             Uhr: 33MHz
             F=E4higkeiten: uhci bus_master
             Konfiguration: driver=3Duhci_hcd latency=3D0
             Ressourcen: irq:19 ioport:1440(Gr=F6=DFe=3D32)
        *-usb:2
             Beschreibung: USB controller
             Produkt: 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3
             Hersteller: Intel Corporation
             Physische ID: 1d.2
             Bus-Informationen: pci@0000:00:1d.2
             Version: 04
             Breite: 32 bits
             Uhr: 33MHz
             F=E4higkeiten: uhci bus_master
             Konfiguration: driver=3Duhci_hcd latency=3D0
             Ressourcen: irq:18 ioport:1460(Gr=F6=DFe=3D32)
        *-usb:3
             Beschreibung: USB controller
             Produkt: 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #4
             Hersteller: Intel Corporation
             Physische ID: 1d.3
             Bus-Informationen: pci@0000:00:1d.3
             Version: 04
             Breite: 32 bits
             Uhr: 33MHz
             F=E4higkeiten: uhci bus_master
             Konfiguration: driver=3Duhci_hcd latency=3D0
             Ressourcen: irq:16 ioport:1480(Gr=F6=DFe=3D32)
        *-usb:4
             Beschreibung: USB controller
             Produkt: 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI
Controller
             Hersteller: Intel Corporation
             Physische ID: 1d.7
             Bus-Informationen: pci@0000:00:1d.7
             Version: 04
             Breite: 32 bits
             Uhr: 33MHz
             F=E4higkeiten: pm debug ehci bus_master cap_list
             Konfiguration: driver=3Dehci_hcd latency=3D0
             Ressourcen: irq:23 memory:b0004000-b00043ff
        *-pci:2
             Beschreibung: PCI bridge
             Produkt: 82801 Mobile PCI Bridge
             Hersteller: Intel Corporation
             Physische ID: 1e
             Bus-Informationen: pci@0000:00:1e.0
             Version: d4
             Breite: 32 bits
             Uhr: 33MHz
             F=E4higkeiten: pci subtractive_decode bus_master cap_list
             Ressourcen: ioport:2000(Gr=F6=DFe=3D4096)
memory:b0200000-b02fffff ioport:84000000(Gr=F6=DFe=3D67108864)
           *-pcmcia
                Beschreibung: CardBus bridge
                Produkt: OZ711MP1/MS1 MemoryCardBus Controller
                Hersteller: O2 Micro, Inc.
                Physische ID: 3
                Bus-Informationen: pci@0000:06:03.0
                Version: 20
                Breite: 32 bits
                Uhr: 33MHz
                F=E4higkeiten: pcmcia bus_master cap_list
                Konfiguration: driver=3Dyenta_cardbus latency=3D176
maxlatency=3D5 mingnt=3D192
                Ressourcen: irq:16 memory:88000000-88000fff
ioport:2400(Gr=F6=DFe=3D256) ioport:2000(Gr=F6=DFe=3D256) memory:84000000-8=
7ffffff
memory:8c000000-8fffffff
           *-generic
                Beschreibung: SD Host controller
                Produkt: Integrated MMC/SD Controller
                Hersteller: O2 Micro, Inc.
                Physische ID: 3.2
                Bus-Informationen: pci@0000:06:03.2
                Version: 00
                Breite: 32 bits
                Uhr: 33MHz
                F=E4higkeiten: pm cap_list
                Konfiguration: driver=3Dsdhci-pci latency=3D32
                Ressourcen: irq:16 memory:b0204000-b02040ff
           *-network
                Beschreibung: Kabellose Verbindung
                Produkt: PRO/Wireless 2200BG [Calexico2] Network Connection
                Hersteller: Intel Corporation
                Physische ID: 5
                Bus-Informationen: pci@0000:06:05.0
                Logischer Name: eth1
                Version: 05
                Seriennummer: 00:13:ce:f2:de:29
                Breite: 32 bits
                Uhr: 33MHz
                F=E4higkeiten: pm bus_master cap_list ethernet physical
wireless
                Konfiguration: broadcast=3Dyes driver=3Dipw2200
driverversion=3D1.2.2kmprq firmware=3DABG:9.0.5.27 (Dec 12 2007)
ip=3D192.168.2.141 latency=3D32 link=3Dyes maxlatency=3D24 mingnt=3D3
multicast=3Dyes wireless=3DIEEE 802.11bg
                Ressourcen: irq:18 memory:b0205000-b0205fff
           *-firewire
                Beschreibung: FireWire (IEEE 1394)
                Produkt: TSB43AB21 IEEE-1394a-2000 Controller (PHY/Link)
                Hersteller: Texas Instruments
                Physische ID: 6
                Bus-Informationen: pci@0000:06:06.0
                Version: 00
                Breite: 32 bits
                Uhr: 33MHz
                F=E4higkeiten: pm ohci bus_master cap_list
                Konfiguration: driver=3Dfirewire_ohci latency=3D32
maxlatency=3D4 mingnt=3D2
                Ressourcen: irq:21 memory:b0204800-b0204fff
memory:b0200000-b0203fff
        *-isa
             Beschreibung: ISA bridge
             Produkt: 82801FBM (ICH6M) LPC Interface Bridge
             Hersteller: Intel Corporation
             Physische ID: 1f
             Bus-Informationen: pci@0000:00:1f.0
             Version: 04
             Breite: 32 bits
             Uhr: 33MHz
             F=E4higkeiten: isa bus_master
             Konfiguration: latency=3D0
        *-ide
             Beschreibung: IDE interface
             Produkt: 82801FB/FBM/FR/FW/FRW (ICH6 Family) IDE Controller
             Hersteller: Intel Corporation
             Physische ID: 1f.1
             Bus-Informationen: pci@0000:00:1f.1
             Logischer Name: scsi4
             Version: 04
             Breite: 32 bits
             Uhr: 33MHz
             F=E4higkeiten: ide bus_master emulated
             Konfiguration: driver=3Data_piix latency=3D0
             Ressourcen: irq:18 ioport:1f0(Gr=F6=DFe=3D8) ioport:3f6
ioport:170(Gr=F6=DFe=3D8) ioport:376 ioport:1410(Gr=F6=DFe=3D16)
           *-cdrom
                Beschreibung: DVD-RAM writer
                Produkt: DVDRAM_GSA-T20N
                Hersteller: HL-DT-ST
                Physische ID: 0.0.0
                Bus-Informationen: scsi@4:0.0.0
                Logischer Name: /dev/cdrom
                Logischer Name: /dev/cdrw
                Logischer Name: /dev/dvd
                Logischer Name: /dev/dvdrw
                Logischer Name: /dev/sr0
                Version: WF08
                F=E4higkeiten: removable audio cd-r cd-rw dvd dvd-r dvd-ram
                Konfiguration: ansiversion=3D5 status=3Dnodisc
        *-storage
             Beschreibung: SATA controller
             Produkt: 82801FBM (ICH6M) SATA Controller
             Hersteller: Intel Corporation
             Physische ID: 1f.2
             Bus-Informationen: pci@0000:00:1f.2
             Logischer Name: scsi0
             Version: 04
             Breite: 32 bits
             Uhr: 66MHz
             F=E4higkeiten: storage pm ahci_1.0 bus_master cap_list emulated
             Konfiguration: driver=3Dahci latency=3D0
             Ressourcen: irq:19 ioport:14b8(Gr=F6=DFe=3D8)
ioport:140c(Gr=F6=DFe=3D4) ioport:14b0(Gr=F6=DFe=3D8) ioport:1408(Gr=F6=DFe=
=3D4)
ioport:14a0(Gr=F6=DFe=3D16) memory:b0004400-b00047ff
           *-disk
                Beschreibung: ATA Disk
                Produkt: INTEL SSDSA2CW08
                Physische ID: 0.0.0
                Bus-Informationen: scsi@0:0.0.0
                Logischer Name: /dev/sda
                Version: 4PC1
                Seriennummer: CVPR117004VD080BGN
                Gr=F6=DFe: 74GiB (80GB)
                F=E4higkeiten: partitioned partitioned:dos
                Konfiguration: ansiversion=3D5 signature=3D000a8da7
              *-volume:0
                   Beschreibung: EXT4-Laufwerk
                   Hersteller: Linux
                   Physische ID: 1
                   Bus-Informationen: scsi@0:0.0.0,1
                   Logischer Name: /dev/sda1
                   Logischer Name: /
                   Version: 1.0
                   Seriennummer: 4ed190ba-dbc2-4085-a6aa-2da28363e783
                   Gr=F6=DFe: 18GiB
                   Kapazit=E4t: 18GiB
                   F=E4higkeiten: primary bootable journaled
extended_attributes large_files huge_files dir_nlink recover extents
ext4 ext2 initialized
                   Konfiguration: created=3D2012-05-05 20:47:38
filesystem=3Dext4 lastmountpoint=3D/ modified=3D2012-05-17 12:10:25
mount.fstype=3Dext4
mount.options=3Drw,relatime,errors=3Dremount-ro,user_xattr,barrier=3D1,data=
=3Dordered
mounted=3D2012-06-16 20:36:49 state=3Dmounted
              *-volume:1
                   Beschreibung: Extended partition
                   Physische ID: 2
                   Bus-Informationen: scsi@0:0.0.0,2
                   Logischer Name: /dev/sda2
                   Gr=F6=DFe: 55GiB
                   Kapazit=E4t: 55GiB
                   F=E4higkeiten: primary extended partitioned
partitioned:extended
                 *-logicalvolume:0
                      Beschreibung: Linux filesystem partition
                      Physische ID: 5
                      Logischer Name: /dev/sda5
                      Logischer Name: /home
                      Kapazit=E4t: 53GiB
                      Konfiguration: mount.fstype=3Dext4
mount.options=3Drw,relatime,user_xattr,barrier=3D1,data=3Dordered state=3Dm=
ounted
                 *-logicalvolume:1
                      Beschreibung: Linux swap / Solaris partition
                      Physische ID: 6
                      Logischer Name: /dev/sda6
                      Kapazit=E4t: 2885MiB
                      F=E4higkeiten: nofs
        *-serial
             Beschreibung: SMBus
             Produkt: 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus Controller
             Hersteller: Intel Corporation
             Physische ID: 1f.3
             Bus-Informationen: pci@0000:00:1f.3
             Version: 04
             Breite: 32 bits
             Uhr: 33MHz
             Konfiguration: driver=3Di801_smbus latency=3D0
             Ressourcen: irq:19 ioport:14c0(Gr=F6=DFe=3D32)
  *-battery
       Beschreibung: Lithium-Ionen Battery
       Produkt: CP197241 / CP197243
       Hersteller: FUJITSU
       Physische ID: 1
       Seriennummer: 01
       Steckplatz: Internal Battery
       Kapazit=E4t: 74880mWh
       Konfiguration: voltage=3D14,4V




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
