From: info@webrider.ru (WebRider.ru)
Date: Thu, 19 May 2005 06:23:43 +0000
Subject: sensors-detect hangs up
Message-Id: <8922218103.20021209155248@webrider.ru>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I've got a problem running lm_sensors. sensors-detect hangs up:

 BIOS vendor (ACPI): AMI
 System vendor (DMI): Gigabyte Technology
 BIOS version (DMI): 0700xx
 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no): yes
Probing for PCI bus adapters...
Use driver `i2c-piix4' for device 00:0f.0: ServerWorks OSB4 South Bridge
Probe succesfully concluded.

 We will now try to load each adapter module in turn.
Load `i2c-piix4' (say NO if built into your kernel)? (YES/no):yes
Module loaded succesfully.
 Do you now want to be prompted for non-detectable adapters? (yes/NO): no
 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no): yes
Next adapter: SMBus PIIX4 adapter at 0580 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively):yes

And at this point the system hangs up.

Logs contain the following information regarding lm_sensors:

kernel: i2c-core.o: i2c core module version 2.7.0 (20021208)
kernel: i2c-piix4.o version 2.7.0 (20021208)
kernel: i2c-piix4.o: Found OSB4 device
kernel: dmi_scan.o version 2.7.0 (20021208)
kernel: dmi_scan.o: SM BIOS found
kernel: i2c-piix4.o: SMBus detected and initialized
kernel: i2c-dev.o: i2c /dev entries driver module version 2 (20021208)

lsmod:
Module                  Size  Used by    Not tainted
i2c-dev                 4864   0  (unused)
i2c-piix4               5060   0  (unused)
dmi_scan                2212   0  [i2c-piix4]
i2c-core               21480   0  [i2c-dev i2c-piix4]
eepro100               19824   1

Motherboard is Gigabyte 6etxdr. Hardware monitor is Winbond w83782d
I've tryed skipping SMBus scan, but ISA bus scan found no sensors.
I've tryed inserting w83781d manualy with
modprobe w83781d
or
modprobe w83781d init=0
System hangs up at once.

isadetect returns all ff
i2cdetect - hangs.
i2cdump 0 0x00 - hangs.

Kernel version is 2.4.18
i2c version 2.7.0
lm_sensors 2.7.0

cat /proc/pci returns the following:

PCI devices found:
  Bus  0, device   0, function  1:
    Host bridge: ServerWorks CNB20LE Host Bridge (#2) (rev 6).
      Master Capable.  Latency.
  Bus  0, device   0, function  0:
    Host bridge: ServerWorks CNB20LE Host Bridge (rev 6).
      Master Capable.  Latencyd.
  Bus  0, device   8, function  0:
    Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 8).
      IRQ 30.
      Master Capable.  Latencyd.  Min Gnt=8.Max LatV.
      Non-prefetchable 32 bit memory at 0xfeafd000 [0xfeafdfff].
      I/O at 0xb800 [0xb83f].
      Non-prefetchable 32 bit memory at 0xfe900000 [0xfe9fffff].
  Bus  0, device   9, function  0:
    VGA compatible controller: ATI Technologies Inc Rage XL (rev 39).
      IRQ 31.
      Master Capable.  Latencyd.  Min Gnt=8.
      Non-prefetchable 32 bit memory at 0xfd000000 [0xfdffffff].
      I/O at 0xb000 [0xb0ff].
      Non-prefetchable 32 bit memory at 0xfeaff000 [0xfeafffff].
  Bus  0, device  15, function  0:
    ISA bridge: ServerWorks OSB4 South Bridge (rev 80).
  Bus  0, device  15, function  1:
    IDE interface: ServerWorks OSB4 IDE Controller (rev 0).
      Master Capable.  Latencyd.
      I/O at 0xffa0 [0xffaf].
  Bus  1, device   4, function  1:
    SCSI storage controller: LSI Logic / Symbios Logic (formerly NCR) 53c1010 66
MHz  Ultra3 SCSI Adapter (#2) (rev 1).
      IRQ 27.
      Master Capable.  Latencyr.  Min Gnt.Max Lat.
      I/O at 0xd000 [0xd0ff].
      Non-prefetchable 64 bit memory at 0xfebff800 [0xfebffbff].
      Non-prefetchable 64 bit memory at 0xfebfa000 [0xfebfbfff].
  Bus  1, device   4, function  0:
    SCSI storage controller: LSI Logic / Symbios Logic (formerly NCR) 53c1010 66
MHz  Ultra3 SCSI Adapter (rev 1).
      IRQ 26.
      Master Capable.  Latencyr.  Min Gnt.Max Lat.
      I/O at 0xc000 [0xc0ff].
      Non-prefetchable 64 bit memory at 0xfebff400 [0xfebff7ff].
      Non-prefetchable 64 bit memory at 0xfebf8000 [0xfebf9fff].


===========Uljashin Sergey
mailto:info@webrider.ru

