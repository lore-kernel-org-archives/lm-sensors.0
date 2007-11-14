From: "Juerg Haefliger" <juergh@gmail.com>
Date: Wed, 14 Nov 2007 17:45:19 +0000
Subject: Re: [lm-sensors] no sensors were detected with Intel Corporation
Message-Id: <191fb4ca0711140945k146c73bbk9c1bf6411577969@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <c8faca170711081606t6acc5928hfdcd9200ba1d421f@mail.gmail.com>
In-Reply-To: <c8faca170711081606t6acc5928hfdcd9200ba1d421f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Kessia,


> Hi folks,
>
> I'm using ubuntu gutsy in dell vostro 1400 laptop. I try run sensors-dete=
ct,
> but this dont recognize my sensors. Below is my configs. thanks:
>
> -------------------------------------------------------------------------=
-------------------------------------
> lspci output:
>
> 00:00.0 Host bridge: Intel Corporation Mobile PM965/GM965/GL960 Memory
> Controller Hub (rev 0c)
> 00:01.0 PCI bridge: Intel Corporation Mobile PM965/GM965/GL960 PCI Express
> Root Port (rev 0c)
> 00: 1a.0 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI
> Contoller #4 (rev 02)
> 00:1a.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI
> Controller #5 (rev 02)
> 00:1a.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI
> Controller #2 (rev 02)
> 00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio
> Controller (rev 02)
> 00:1c.0 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Po=
rt
> 1 (rev 02)
> 00:1c.1 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Po=
rt
> 2 (rev 02)
> 00:1c.3 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Po=
rt
> 4 (rev 02)
> 00:1c.5 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Po=
rt
> 6 (rev 02)
> 00:1d.0 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI
> Controller #1 (rev 02)
> 00:1d.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI
> Controller #2 (rev 02)
> 00:1d.2 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI
> Controller #3 (rev 02)
> 00:1d.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI
> Controller #1 (rev 02)
> 00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev f2)
> 00:1f.0 ISA bridge: Intel Corporation 82801HEM (ICH8M) LPC Interface
> Controller (rev 02)
> 00:1f.1 IDE interface: Intel Corporation 82801HBM/HEM (ICH8M/ICH8M-E) IDE
> Controller (rev 02)
> 00:1f.2 SATA controller: Intel Corporation 82801HBM/HEM (ICH8M/ICH8M-E) S=
ATA
> AHCI Controller (rev 02)
> 00:1f.3 SMBus: Intel Corporation 82801H (ICH8 Family) SMBus Controller (r=
ev
> 02)
> 01:00.0 VGA compatible controller: nVidia Corporation GeForce 8400M GS (r=
ev
> a1)
> 03:01.0 FireWire (IEEE 1394): Ricoh Co Ltd R5C832 IEEE 1394 Controller (r=
ev
> 05)
> 03:01.1 SD Host controller: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro Host
> Adapter (rev 22)
> 03:01.2 System peripheral: Ricoh Co Ltd R5C843 MMC Host Controller (rev 1=
2)
> 03:01.3 System peripheral: Ricoh Co Ltd R5C592 Memory Stick Bus Host Adap=
ter
> (rev 12)
> 03:01.4 System peripheral: Ricoh Co Ltd xD-Picture Card Controller (rev 1=
2)
> 09:00.0 Ethernet controller: Broadcom Corporation NetLink BCM5906M Fast
> Ethernet PCI Express (rev 02)
> 0c:00.0 Network controller: Broadcom Corporation BCM4328 802.11a/b/g/n (r=
ev
> 03)
>
>
> -------------------------------------------------------------------------=
-------------------------------------
> uname -a:
>  Linux rainbows 2.6.22-14-generic #1 SMP Sun Oct 14 23:05:12 GMT 2007 i686
> GNU/Linux
>
>
> -------------------------------------------------------------------------=
-------------------------------------
> lm-sensors version:
> Version: 1:2.10.4-1ubuntu1 (oficial package)
>
> -------------------------------------------------------------------------=
-------------------------------------
> sensors-detect output:
> # sensors-detect revision 4609 (2007-07-14 09:28:39 -0700)
>
> This program will help you determine which kernel modules you need
> to load to use lm_sensors most effectively. It is generally safe
> and recommended to accept the default answers to all questions,
> unless you know what you're doing.
>
> We can start with probing for (PCI) I2C or SMBus adapters.
> Do you want to probe now? (YES/no):
> Probing for PCI bus adapters...
> Use driver `i2c-i801' for device 0000:00:1f.3: Intel 82801H ICH8
>
>  We will now try to load each adapter module in turn.
> Load `i2c-i801' (say NO if built into your kernel)? (YES/no):
> Module loaded successfully.
> If you have undetectable or unsupported adapters, you can have them
> scanned by manually loading the modules before running this script.
>
> We are now going to do the I2C/SMBus adapter probings. Some chips may
> be double detected; we choose the one with the highest confidence
>  value in that case.
> If you found that the adapter hung after probing a certain address,
> you can specify that address to remain unprobed.
>
> Next adapter: NVIDIA i2c adapter  (i2c-0)
> Do you want to scan it? (YES/no/selectively):
> Can't open /dev/i2c-0
>
> Next adapter: NVIDIA i2c adapter  (i2c-1)
> Do you want to scan it? (YES/no/selectively):
> Can't open /dev/i2c-1
>
> Next adapter: NVIDIA i2c adapter  (i2c-2)
> Do you want to scan it? (YES/no/selectively):
> Can't open /dev/i2c-2
>
> Next adapter: SMBus I801 adapter at 10c0 (i2c-3)
> Do you want to scan it? (YES/no/selectively):
> Client found at address 0x44
> Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
> Client found at address 0x50
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 Yes
>     (confidence 8, not a hardware monitoring chip)
> Probing for `EDID EEPROM'...                                No
> Client found at address 0x52
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 Yes
>     (confidence 8, not a hardware monitoring chip)
> Probing for `EDID EEPROM'...                                No
>
> Some chips are also accessible through the ISA I/O ports. We have to
> write to arbitrary I/O ports to probe them. This is usually safe though.
> Yes, you do have ISA I/O ports even if you do not have any ISA slots!
> Do you want to scan the ISA I/O ports? (YES/no):
> Probing for `National Semiconductor LM78' at 0x290...       No
> Probing for `National Semiconductor LM78-J' at 0x290...     No
> Probing for `National Semiconductor LM79' at 0x290...       No
> Probing for `Winbond W83781D' at 0x290...                   No
> Probing for `Winbond W83782D' at 0x290...                   No
> Probing for `Silicon Integrated Systems SIS5595'...         No
> Probing for `VIA VT82C686 Integrated Sensors'...            No
> Probing for `VIA VT8231 Integrated Sensors'...              No
> Probing for `IPMI BMC KCS' at 0xca0...                      No
> Probing for `IPMI BMC SMIC' at 0xca8...                     No
>
> Some Super I/O chips may also contain sensors. We have to write to
> standard I/O ports to probe them. This is usually safe.
> Do you want to scan for Super I/O sensors? (YES/no):
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     Yes
> Found unknown chip with ID 0x3201
> Probing for Super-I/O at 0x4e/0x4f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Fintek'...                       No
> Trying family `ITE'...                                      No

As sensor-detect says, this chip is unknown. Can you run Speedfan
under windows on this machine? Speedfan might tell us what chip it is
and from that we can try to figure out if it's compatible with
anything that's currently supported.

...juerg



> Some CPUs or memory controllers may also contain embedded sensors.
> Do you want to scan for them? (YES/no):
> AMD K8 thermal sensors...                                   No
> Intel Core family thermal sensor...                         No
> Intel AMB FB-DIMM thermal sensor...                         No
>
> Sorry, no sensors were detected.
> Either your sensors are not supported, or they are connected to an
> I2C or SMBus adapter that is not supported. See doc/FAQ,
> doc/lm_sensors-FAQ.html or http://www.lm-sensors.org/wiki/FAQ
> (FAQ #4.24.3) for further information.
> If you find out what chips are on your board, check
> http://www.lm-sensors.org/wiki/Devices for driver status.
>
>
>
> -------------------------------------------------------------------------=
-------------------------------------
>
>
> --
> Kessia Pinheiro
> Bacharelanda em Ci=EAncia da Computa=E7=E3o
> Universidade Federal da Bahia
> Linux Counter User #389695 [http://counter.li.org]
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
