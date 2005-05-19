From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:28 +0000
Subject: lm-sensors bug report filed??
Message-Id: <3C41B2A1.65631ECA@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <15420.60548.41937.165100@khufu.rjmx.net>
In-Reply-To: <15420.60548.41937.165100@khufu.rjmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The key is the SMBus controller is not enabled.
To fix that use 'force=1'.
Unfortunately the driver has no check for an uninitialized
base address so using this alone could hang your computer.
I'll put in a fix for that.

The safest is to use 'modprobe i2c-viapro force_address=0xaddr force=1'.
To pick an address, cat /proc/ioports and select
an address that doesn't conflict with anything else.
Something big like 0xc000 is generally safe.
mds



Ron Murray wrote:
> 
> Hi. Thanks for the reply.
> 
>    Below is as much information as I can find from the system whenever
> I try to run sensors-detect. Although it seems to find the VT82C686,
> it apparently can't enable it. I haven't tried any of the forcexxx
> options to modprobe, mostly because I don't have a clue what addresses
> I should feed it with.
> 
>    Of course, for all I know, Compaq in their infinite wisdom didn't
> feel inclined to put any sensors on the motherboard at all, and I
> might be wasting your time (I couldn't identify any other motherboard
> chips as sensors from your list, but that might be just my poor
> eyesight). But if it doesn't, you might record that in your FAQ and
> save wasting anyone else's time.
> 
> Thanks,
> 
>  .....Ron
> 
> (output from assorted programs and logs follows)
> 
> Output of sensors-detect :
> =============
> 
>  This program will help you to determine which I2C/SMBus modules you need to
>  load to use lm_sensors most effectively.
>  You need to have installed lm-sensors modules before you can use
>  some functions of this utility.
>  Also, you need to be `root', or at least have access to
>  the /dev/i2c[-/]* files for some things.
>  If you have patched your kernel and have some drivers built-in you can
>  safely answer NO if asked to load some modules. In this case, things may
>  seem a bit confusing, but they will still work.
> 
>  IF THIS IS AN IBM THINKPAD, PRESS CTRL-C NOW!
>  IBM Thinkpads have a severely broken i2c/SMBus implementation,  just scanning
>  the bus will break your thinkpad forever!
> 
>  We can start with probing for (PCI) I2C or SMBus adapters.
>  You do not need any special privileges for this.
>  Do you want to probe now? (YES/no): YES
> Probing for PCI bus adapters...
> Use driver `i2c-viapro' for device 00:14.4: VIA Technologies VT82C686 Apollo ACPI
> Use driver `i2c-riva' for device 01:00.0: RIVA UVTNT2
> Probe succesfully concluded.
> 
>  We will now try to load each adapter module in turn.
> Load `i2c-viapro' (say NO if built into your kernel)? (YES/no): YES
> /lib/modules/2.4.17-khufu-freeswan-2/misc/i2c-viapro.o: init_module: No such device
> Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters
> /lib/modules/2.4.17-khufu-freeswan-2/misc/i2c-viapro.o: insmod /lib/modules/2.4.17-khufu-freeswan-2/misc/i2c-viapro.o failed
> /lib/modules/2.4.17-khufu-freeswan-2/misc/i2c-viapro.o: insmod i2c-viapro failedLoading failed ()... skipping.
> Load `i2c-riva' (say NO if built into your kernel)? (YES/no): YES
> modprobe: Can't locate module i2c-riva
> Loading failed ()... skipping.
> ** Note: i2c-riva module is available at
> ** http://drama.obuda.kando.hu/~fero/cgi-bin/rivatv.shtml
>  Do you now want to be prompted for non-detectable adapters? (yes/NO): NO
>  To continue, we need module `i2c-dev' to be loaded.
>  If it is built-in into your kernel, you can safely skip this.
> i2c-dev is already loaded.
> 
>  We are now going to do the adapter probings. Some adapters may hang halfway
>  through; we can't really help that. Also, some chips will be double detected;
>  we choose the one with the highest confidence value in that case.
>  If you found that the adapter hung after probing a certain address, you can
>  specify that address to remain unprobed. That often
>  includes address 0x69 (clock chip).
> 
>  Some chips are also accessible through the ISA bus. ISA probes are
>  typically a bit more dangerous, as we have to write to I/O ports to do
>  this.  Do you want to scan the ISA bus? (YES/no): YES
> Probing for `National Semiconductor LM78'
>   Trying address 0x0290... Failed!
> Probing for `National Semiconductor LM78-J'
>   Trying address 0x0290... Failed!
> Probing for `National Semiconductor LM79'
>   Trying address 0x0290... Failed!
> Probing for `Winbond W83781D'
>   Trying address 0x0290... Failed!
> Probing for `Winbond W83782D'
>   Trying address 0x0290... Failed!
> Probing for `Winbond W83627HF'
>   Trying address 0x0290... Failed!
> Probing for `Winbond W83697HF'
>   Trying address 0x0290... Failed!
> Probing for `Silicon Integrated Systems SIS5595'
>   Trying general detect... Failed!
> Probing for `VIA Technologies VT 82C686 Integrated Sensors'
>   Trying general detect... Failed!
> Probing for `ITE IT8705F / IT8712F / SiS 950'
>   Trying address 0x0290... Failed!
> 
>  Now follows a summary of the probes I have just done.
>  Just press ENTER to continue:
> 
>  I will now generate the commands needed to load the I2C modules.
>  Sometimes, a chip is available both through the ISA bus and an I2C bus.
>  ISA bus access is faster, but you need to load an additional driver module
>  for it. If you have the choice, do you want to use the ISA bus or the
>  I2C/SMBus (ISA/smbus)?
> 
> WARNING! If you have some things built into your kernel, the
> below list will contain too many modules. Skip the appropriate ones!
> To load everything that is needed, edit /etc/modules and add the modules
>  listed here to it:
> 
> #----cut here----
> # I2C adapter drivers
> # I2C chip drivers
> #----cut here----
> 
> Then, run /etc/init.d/modutils
> 
> To make the sensors modules behave correctly, add these lines to
> /etc/modutils/local and run update-modules:
> 
> #----cut here----
> # I2C module options
> alias char-major-89 i2c-dev
> #----cut here----
> 
> dmesg results:
> =======
> 
> i2c-viapro.o version 2.6.2 (20011118)
> i2c-viapro.o: Found Via VT82C686A/B device
> SMBUS: Error: Host SMBus controller not enabled!
> i2c-viapro.o: Can't detect vt82c596 or compatible device, module not inserted.
> i2c-dev.o: i2c /dev entries driver module
> i2c-core.o: driver i2c-dev dummy driver registered.
> 
> lsmod
> ==> 
> Module                  Size  Used by    Not tainted
> i2c-dev                 3776   0  (unused)
> serial                 44064   1  (autoclean)
> ncr53c8xx              51744   1  (autoclean)
> sr_mod                 12280   2  (autoclean)
> scsi_mod               86328   2  (autoclean) [ncr53c8xx sr_mod]
> pktcdvd                16584   1  (autoclean)
> cdrom                  28736   0  (autoclean) [sr_mod pktcdvd]
> nfsd                   66592   8  (autoclean)
> snd-seq-midi            3232   0  (autoclean) (unused)
> snd-seq-oss            23296   0  (unused)
> snd-seq-midi-event      2744   0  [snd-seq-midi snd-seq-oss]
> snd-seq                36908   2  [snd-seq-midi snd-seq-oss snd-seq-midi-event]
> snd-pcm-oss            35776   0
> snd-mixer-oss           9120   1  [snd-pcm-oss]
> snd-card-cs46xx         1440   1
> snd-cs46xx             67840   0  [snd-card-cs46xx]
> snd-pcm                45664   0  [snd-pcm-oss snd-cs46xx]
> snd-timer              10208   0  [snd-seq snd-pcm]
> snd-rawmidi            11936   0  [snd-seq-midi snd-cs46xx]
> snd-seq-device          3920   0  [snd-seq-midi snd-seq-oss snd-seq snd-rawmidi]snd-ac97-codec         22784   0  [snd-cs46xx]
> snd                    23784   0  [snd-seq-midi snd-seq-oss snd-seq-midi-event snd-seq snd-pcm-oss snd-mixer-oss snd-card-cs46xx snd-cs46xx snd-pcm snd-timer snd-rawmidi snd-seq-device snd-ac97-codec]
> soundcore               3396   7  [snd]
> af_packet               8520   1  (autoclean)
> i2c-proc                6176   0
> i2c-core               12448   0  [i2c-dev i2c-proc]
> scanner                 8480   0  (unused)
> usb-uhci               21316   0  (unused)
> usbcore                53344   1  [scanner usb-uhci]
> 3c59x                  24808   1
> nfs                    70940   1
> lockd                  48256   1  [nfsd nfs]
> sunrpc                 58996   1  [nfsd nfs lockd]
> 
> lspci -n
> ====
> 
> 00:00.0 Class 0600: 1106:0691 (rev 03)
> 00:01.0 Class 0604: 1106:8305
> 00:03.0 Class 0c00: 104c:8020
> 00:04.0 Class 0200: 10b7:9001
> 00:05.0 Class 0100: 1000:0004 (rev 04)
> 00:06.0 Class 0400: 109e:036e (rev 11)
> 00:06.1 Class 0480: 109e:0878 (rev 11)
> 00:07.0 Class 0401: 1013:6003 (rev 01)
> 00:14.0 Class 0601: 1106:0686 (rev 22)
> 00:14.1 Class 0101: 1106:0571 (rev 10)
> 00:14.2 Class 0c03: 1106:3038 (rev 10)
> 00:14.3 Class 0c03: 1106:3038 (rev 10)
> 00:14.4 Class 0680: 1106:3057 (rev 30)
> 01:00.0 Class 0300: 10de:002d (rev 15)
> 
> lspci -v
> ====
> 
> 00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev 03)
>         Flags: bus master, medium devsel, latency 0
>         Memory at 50000000 (32-bit, prefetchable) [sizedM]
>         Capabilities: [a0] AGP version 2.0
>         Capabilities: [c0] Power Management version 2
> 
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
>         Flags: bus master, 66Mhz, medium devsel, latency 0
>         Bus: primary , secondary, subordinate, sec-latency=0
>         Memory behind bridge: 40000000-40ffffff
>         Prefetchable memory behind bridge: 42000000-43ffffff
>         Capabilities: [80] Power Management version 2
> 
> 00:03.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8020 (prog-if 10 [OHCI])
>         Subsystem: Texas Instruments: Unknown device 8010
>         Flags: bus master, medium devsel, latency 66, IRQ 3
>         Memory at 41300000 (32-bit, non-prefetchable) [size=2K]
>         Memory at 41100000 (32-bit, non-prefetchable) [sizeK]
>         Capabilities: [44] Power Management version 1
> 
> 00:04.0 Ethernet controller: 3Com Corporation 3c900 Combo [Boomerang]
>         Flags: bus master, medium devsel, latency 64, IRQ 10
>         I/O ports at 1400 [sized]
>         Expansion ROM at <unassigned> [disabled] [sizedK]
> 
> 00:05.0 SCSI storage controller: LSI Logic / Symbios Logic (formerly NCR) 53c815 (rev 04)
>         Flags: bus master, medium devsel, latency 66, IRQ 5
>         I/O ports at 1000 [size%6]
>         Memory at 41400000 (32-bit, non-prefetchable) [size%6]
>         Expansion ROM at <unassigned> [disabled] [size2K]
> 
> 00:06.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 11)
>         Subsystem: Unknown device bd11:1200
>         Flags: bus master, medium devsel, latency 66, IRQ 11
>         Memory at 41500000 (32-bit, prefetchable) [size=4K]
>         Capabilities: [44] Vital Product Data
>         Capabilities: [4c] Power Management version 2
> 
> 00:06.1 Multimedia controller: Brooktree Corporation Bt878 (rev 11)
>         Subsystem: Unknown device bd11:1200
>         Flags: bus master, medium devsel, latency 66, IRQ 11
>         Memory at 41600000 (32-bit, prefetchable) [size=4K]
>         Capabilities: [44] Vital Product Data
>         Capabilities: [4c] Power Management version 2
> 
> 00:07.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24 [CrystalClear SoundFusion Audio Accelerator] (rev 01)
>         Subsystem: Voyetra Technologies: Unknown device 3357
>         Flags: bus master, slow devsel, latency 64, IRQ 3
>         Memory at 41200000 (32-bit, non-prefetchable) [size=4K]
>         Memory at 41000000 (32-bit, non-prefetchable) [size=1M]
>         Capabilities: [40] Power Management version 2
> 
> 00:14.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
>         Flags: bus master, stepping, medium devsel, latency 0
> 
> 00:14.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10) (prog-if 8a [Master SecP PriP])
>         Flags: bus master, medium devsel, latency 64
>         I/O ports at 1480 [size]
>         Capabilities: [c0] Power Management version 2
> 
> 00:14.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10) (prog-if 00 [UHCI])
>         Subsystem: Unknown device 0925:1234
>         Flags: bus master, medium devsel, latency 66, IRQ 11
>         I/O ports at 1440 [size2]
>         Capabilities: [80] Power Management version 2
> 
> 00:14.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10) (prog-if 00 [UHCI])
>         Subsystem: Unknown device 0925:1234
>         Flags: bus master, medium devsel, latency 66, IRQ 11
>         I/O ports at 1460 [size2]
>         Capabilities: [80] Power Management version 2
> 
> 00:14.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
>         Flags: medium devsel
>         Capabilities: [68] Power Management version 2
> 
> 01:00.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 15) (prog-if 00 [VGA])
>         Subsystem: nVidia Corporation: Unknown device 0022
>         Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 3
>         Memory at 40000000 (32-bit, non-prefetchable) [sizeM]
>         Memory at 42000000 (32-bit, prefetchable) [size2M]
>         Expansion ROM at <unassigned> [disabled] [sizedK]
>         Capabilities: [60] Power Management version 1
>         Capabilities: [44] AGP version 2.0
> 
> System details
> =======
> 
> - Compaq 7000US
> - Processor is 1.2G AMD Athlon
> - 512M memory
> - VIA VT82C686A chip on motherboard
> - Kernel version 2.4.17, with freeswan and packet writing patches
>   added
> - lm_sensors version 2.6.2, i2c version 2.6.2
> 
> --
> Ron Murray   (rjmx@rjmx.net)
> https://www.rjmx.net/~ron
> GPG Public Key Fingerprint: F2C1 FC47 5EF7 0317 133C  D66B 8ADA A3C4 D86C 74DE
