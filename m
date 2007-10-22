From: "Juerg Haefliger" <juergh@gmail.com>
Date: Mon, 22 Oct 2007 15:40:21 +0000
Subject: Re: [lm-sensors] Toshiba Satellite M100-164 no data from sensors
Message-Id: <191fb4ca0710220840u69554fccy9f59241987cbf05b@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071022151206.GA30401@mail.irix-servis.cz>
In-Reply-To: <20071022151206.GA30401@mail.irix-servis.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Petr,


On 10/22/07, Petr Bartel <bartel@irix.cz> wrote:
> Good afternoon,
> I can't get any data from sensors (CPU fan, voltage....).
> Can you advise to me, what will I do ?
>
> lspci -vvv
>
> 00:00.0 Host bridge: Intel Corporation Mobile 945GM/PM/GMS/940GML and 945=
GT Express Memory Controller Hub (rev 03)
>         Subsystem: Toshiba America Info Systems Unknown device ff00
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR+ FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort- <T=
Abort- <MAbort+ >SERR- <PERR-
>         Latency: 0
>         Capabilities: <access denied>
>
> 00:02.0 VGA compatible controller: Intel Corporation Mobile 945GM/GMS/940=
GML Express Integrated Graphics Controller (rev 03) (prog-if 00 [VGA])
>         Subsystem: Toshiba America Info Systems Unknown device ff00
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort- <T=
Abort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 17
>         Region 0: Memory at d0200000 (32-bit, non-prefetchable) [sizeQ2K]
>         Region 1: I/O ports at 1800 [size=3D8]
>         Region 2: Memory at c0000000 (32-bit, prefetchable) [size%6M]
>         Region 3: Memory at d0300000 (32-bit, non-prefetchable) [size%6K]
>         Capabilities: <access denied>
>
> 00:02.1 Display controller: Intel Corporation Mobile 945GM/GMS/940GML Exp=
ress Integrated Graphics Controller (rev 03)
>         Subsystem: Toshiba America Info Systems Unknown device ff00
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort- <T=
Abort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Region 0: Memory at d0280000 (32-bit, non-prefetchable) [sizeQ2K]
>         Capabilities: <access denied>
>
> 00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definit=
ion Audio Controller (rev 02)
>         Subsystem: Toshiba America Info Systems Unknown device ff00
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <T=
Abort- <MAbort- >SERR- <PERR-
>         Latency: 0, Cache Line Size: 64 bytes
>         Interrupt: pin A routed to IRQ 22
>         Region 0: Memory at d0340000 (64-bit, non-prefetchable) [size=16K]
>         Capabilities: <access denied>
>
> 00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Po=
rt 1 (rev 02) (prog-if 00 [Normal decode])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <T=
Abort- <MAbort- >SERR- <PERR-
>         Latency: 0, Cache Line Size: 64 bytes
>         Bus: primary=00, secondary=02, subordinate=02, sec-latency=3D0
>         I/O behind bridge: 0000f000-00000fff
>         Memory behind bridge: fff00000-000fffff
>         Prefetchable memory behind bridge: 00000000fff00000-00000000000ff=
fff
>         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=FAst >TAbort- <T=
Abort- <MAbort+ <SERR- <PERR-
>         BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
>         Capabilities: <access denied>
>
> 00:1c.1 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Po=
rt 2 (rev 02) (prog-if 00 [Normal decode])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <T=
Abort- <MAbort- >SERR- <PERR-
>         Latency: 0, Cache Line Size: 64 bytes
>         Bus: primary=00, secondary=03, subordinate=03, sec-latency=3D0
>         I/O behind bridge: 0000f000-00000fff
>         Memory behind bridge: d0100000-d01fffff
>         Prefetchable memory behind bridge: 00000000fff00000-00000000000ff=
fff
>         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=FAst >TAbort- <T=
Abort- <MAbort+ <SERR- <PERR-
>         BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
>         Capabilities: <access denied>
>
> 00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #=
1 (rev 02) (prog-if 00 [UHCI])
>         Subsystem: Toshiba America Info Systems Unknown device ff00
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 20
>         Region 4: I/O ports at 1820 [size2]
>
> 00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #=
2 (rev 02) (prog-if 00 [UHCI])
>         Subsystem: Toshiba America Info Systems Unknown device ff00
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin B routed to IRQ 18
>         Region 4: I/O ports at 1840 [size2]
>
> 00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #=
3 (rev 02) (prog-if 00 [UHCI])
>         Subsystem: Toshiba America Info Systems Unknown device ff00
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin C routed to IRQ 21
>         Region 4: I/O ports at 1860 [size2]
>
> 00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #=
4 (rev 02) (prog-if 00 [UHCI])
>         Subsystem: Toshiba America Info Systems Unknown device ff00
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin D routed to IRQ 17
>         Region 4: I/O ports at 1880 [size2]
>
> 00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI =
Controller (rev 02) (prog-if 20 [EHCI])
>         Subsystem: Toshiba America Info Systems Unknown device ff00
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 20
>         Region 0: Memory at d0544000 (32-bit, non-prefetchable) [size=3D1=
K]
>         Capabilities: <access denied>
>
> 00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev e2) (p=
rog-if 01 [Subtractive decode])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <T=
Abort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Bus: primary=00, secondary=05, subordinate	, sec-latencyd
>         I/O behind bridge: 00002000-00002fff
>         Memory behind bridge: d0000000-d00fffff
>         Prefetchable memory behind bridge: 0000000050000000-0000000053fff=
fff
>         Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort+ <SERR- <PERR-
>         BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
>         Capabilities: <access denied>
>
> 00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC Interface Bri=
dge (rev 02)
>         Subsystem: Toshiba America Info Systems Unknown device ff00
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Capabilities: <access denied>
>
> 00:1f.2 IDE interface: Intel Corporation 82801GBM/GHM (ICH7 Family) Seria=
l ATA Storage Controller IDE (rev 02) (prog-if 80 [Master])
>         Subsystem: Toshiba America Info Systems Unknown device ff00
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin B routed to IRQ 18
>         Region 0: I/O ports at 01f0 [size=3D8]
>         Region 1: I/O ports at 03f4 [size=3D1]
>         Region 2: I/O ports at 0170 [size=3D8]
>         Region 3: I/O ports at 0374 [size=3D1]
>         Region 4: I/O ports at 18b0 [size=16]
>         Capabilities: <access denied>
>
> 00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (r=
ev 02)
>         Subsystem: Toshiba America Info Systems Unknown device ff00
>         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR- <PERR-
>         Interrupt: pin B routed to IRQ 18
>         Region 4: I/O ports at 18c0 [size2]
>
> 03:00.0 Network controller: Intel Corporation PRO/Wireless 3945ABG Networ=
k Connection (rev 02)
>         Subsystem: Intel Corporation Unknown device 1041
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <T=
Abort- <MAbort- >SERR- <PERR-
>         Latency: 0, Cache Line Size: 64 bytes
>         Interrupt: pin A routed to IRQ 16
>         Region 0: Memory at d0100000 (32-bit, non-prefetchable) [size=3D4=
K]
>         Capabilities: <access denied>
>
> 05:06.0 CardBus bridge: Texas Instruments PCIxx12 Cardbus Controller
>         Subsystem: Toshiba America Info Systems Unknown device ff00
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 168, Cache Line Size: 128 bytes
>         Interrupt: pin A routed to IRQ 17
>         Region 0: Memory at d0004000 (32-bit, non-prefetchable) [size=3D4=
K]
>         Bus: primary=05, secondary=06, subordinate	, sec-latency=176
>         Memory window 0: 50000000-53fff000 (prefetchable)
>         Memory window 1: 54000000-57fff000
>         I/O window 0: 00002400-000024ff
>         I/O window 1: 00002800-000028ff
>         BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWr=
ite+
>         16-bit legacy interface ports at 0001
>
> 05:06.1 FireWire (IEEE 1394): Texas Instruments PCIxx12 OHCI Compliant IE=
EE 1394 Host Controller (prog-if 10 [OHCI])
>         Subsystem: Toshiba America Info Systems Unknown device ff00
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32 (500ns min, 1000ns max), Cache Line Size: 64 bytes
>         Interrupt: pin B routed to IRQ 16
>         Region 0: Memory at d0007000 (32-bit, non-prefetchable) [size=3D2=
K]
>         Region 1: Memory at d0000000 (32-bit, non-prefetchable) [size=16K]
>         Capabilities: <access denied>
>
> 05:06.2 Mass storage controller: Texas Instruments 5-in-1 Multimedia Card=
 Reader (SD/MMC/MS/MS PRO/xD)
>         Subsystem: Toshiba America Info Systems Unknown device ff00
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 57 (1750ns min, 1000ns max), Cache Line Size: 64 bytes
>         Interrupt: pin C routed to IRQ 21
>         Region 0: Memory at d0005000 (32-bit, non-prefetchable) [size=3D4=
K]
>         Capabilities: <access denied>
>
> 05:06.3 Generic system peripheral [0805]: Texas Instruments PCIxx12 SDA S=
tandard Compliant SD Host Controller (prog-if 01)
>         Subsystem: Toshiba America Info Systems Unknown device ff00
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 57 (1750ns min, 1000ns max), Cache Line Size: 64 bytes
>         Interrupt: pin D routed to IRQ 18
>         Region 0: Memory at d0007800 (32-bit, non-prefetchable) [size%6]
>         Capabilities: <access denied>
>
> 05:08.0 Ethernet controller: Intel Corporation PRO/100 VM Network Connect=
ion (rev 02)
>         Subsystem: Toshiba America Info Systems Unknown device ff00
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 66 (2000ns min, 14000ns max), Cache Line Size: 64 bytes
>         Interrupt: pin A routed to IRQ 19
>         Region 0: Memory at d0006000 (32-bit, non-prefetchable) [size=3D4=
K]
>         Region 1: I/O ports at 2000 [sized]
>         Capabilities: <access denied>
>
>
> sensors-detect
>
> # sensors-detect revision 4609 (2007-07-14 09:28:39 -0700)
>
> This program will help you determine which kernel modules you need
> to load to use lm_sensors most effectively. It is generally safe
> and recommended to accept the default answers to all questions,
> unless you know what you're doing.
>
> We can start with probing for (PCI) I2C or SMBus adapters.
> Do you want to probe now? (YES/no): Probing for PCI bus adapters...
> Use driver `i2c-i801' for device 0000:00:1f.3: Intel 82801G ICH7
>
> We will now try to load each adapter module in turn.
> Module `i2c-i801' already loaded.
> If you have undetectable or unsupported adapters, you can have them
> scanned by manually loading the modules before running this script.
>
> We are now going to do the I2C/SMBus adapter probings. Some chips may
> be double detected; we choose the one with the highest confidence
> value in that case.
> If you found that the adapter hung after probing a certain address,
> you can specify that address to remain unprobed.
>
> Next adapter: SMBus I801 adapter at 18c0 (i2c-0)
> Do you want to scan it? (YES/no/selectively): Client found at address 0x44
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
> Do you want to scan the ISA I/O ports? (YES/no): Probing for `National Se=
miconductor LM78' at 0x290...       No
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
> Do you want to scan for Super I/O sensors? (YES/no): Probing for Super-I/=
O at 0x2e/0x2f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Fintek'...                       No
> Trying family `ITE'...                                      No
> Probing for Super-I/O at 0x4e/0x4f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Fintek'...                       No
> Trying family `ITE'...                                      No
>
> Some CPUs or memory controllers may also contain embedded sensors.
> Do you want to scan for them? (YES/no): AMD K8 thermal sensors...        =
                           No
> Intel Core family thermal sensor...                         Success!
>     (driver `coretemp')
> Intel AMB FB-DIMM thermal sensor...                         No
>
> Now follows a summary of the probes I have just done.
> Just press ENTER to continue:
> Driver `coretemp' (should be inserted):
>   Detects correctly:
>   * Chip `Intel Core family thermal sensor' (confidence: 9)
>
> I will now generate the commands needed to load the required modules.
> Just press ENTER to continue:
> To make the sensors modules behave correctly, add these lines to
> /etc/modules:
>
> #----cut here----
> # Chip drivers
> coretemp
> #----cut here----
>
> Do you want to add these lines to /etc/modules automatically? (yes/NO)
>
> lsmod
>
> Module                  Size  Used by
> i2c_dev                 8196  0
> i915                   25216  2
> drm                    83348  3 i915
> tun                    11776  1
> af_packet              23176  2
> parport_pc             36260  0
> ppdev                   9732  0
> parport                37448  2 parport_pc,ppdev
> ipv6                  265188  14
> dm_snapshot            18984  0
> dm_mirror              24832  0
> dm_mod                 59200  2 dm_snapshot,dm_mirror
> coretemp                7808  0
> tifm_sd                12168  0
> ipw3945               198176  0
> ieee80211              35656  1 ipw3945
> ieee80211_crypt         6400  1 ieee80211
> snd_hda_intel         277532  1
> snd_pcm_oss            43680  0
> snd_pcm                80388  2 snd_hda_intel,snd_pcm_oss
> snd_mixer_oss          17280  1 snd_pcm_oss
> snd_seq_dummy           4100  0
> snd_seq_oss            33152  0
> snd_seq_midi            8736  0
> snd_rawmidi            24992  1 snd_seq_midi
> snd_seq_midi_event      7680  2 snd_seq_oss,snd_seq_midi
> joydev                 10688  0
> snd_seq                53072  6 snd_seq_dummy,snd_seq_oss,snd_seq_midi,sn=
d_seq_midi_event
> snd_timer              23940  2 snd_pcm,snd_seq
> snd_seq_device          8588  5 snd_seq_dummy,snd_seq_oss,snd_seq_midi,sn=
d_rawmidi,snd_seq
> sdhci                  18444  0
> shpchp                 33812  0
> rtc                    13592  0
> tifm_7xx1               8192  0
> i2c_i801                9360  0
> ehci_hcd               34700  0
> uhci_hcd               25868  0
> intel_agp              24724  1
> mmc_core               29444  2 tifm_sd,sdhci
> tsdev                   8768  0
> ohci1394               32944  0
> ieee1394               94264  1 ohci1394
> tifm_core              10756  2 tifm_sd,tifm_7xx1
> pci_hotplug            31776  1 shpchp
> e100                   36620  0
> mii                     5760  1 e100
> i2c_core               25600  2 i2c_dev,i2c_i801
> evdev                  10624  0
> psmouse                39568  0
> agpgart                34252  3 drm,intel_agp
> usbcore               142212  3 ehci_hcd,uhci_hcd
> snd                    54628  11 snd_hda_intel,snd_pcm_oss,snd_pcm,snd_mi=
xer_oss,snd_seq_oss,snd_rawmidi,snd_seq,snd_timer,snd_seq_device
> soundcore               8672  1 snd
> snd_page_alloc         10632  2 snd_hda_intel,snd_pcm
> unix                   28976  88
>
> sensors
>
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +16=B0C  (high =3D  +100=B0C)
>
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 1:      +16=B0C  (high =3D  +100=B0C)
>
> No others data :(

What makes you think your machine can provide any other information
than the core temp? Does the BIOS show any temperature/voltage
information? What is the brand and model of your machine and
motherboard?

...juerg


> Thanks a lot for your support
>
> Your sincerely
>      Petr Bartel
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
