From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:39 +0000
Subject: i2c-sis630 bus driver (was Re: last call for 2.6.5)
Message-Id: <20020917150545.S20006@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



BTW- My workstation at work has an integrated sis630.  It comes up 
like this:

[root@drtheopolis lm_sensors2]# lspci -v -d 1039:6300
01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 
SiS630 GUI Accelerator+3D (rev 31) (prog-if 00 [VGA])
	Subsystem: Asustek Computer, Inc.: Unknown device 8032
	Flags: 66Mhz, medium devsel, IRQ 11
	BIST result: 00
	Memory at f0000000 (32-bit, prefetchable) [size8M]
	Memory at ea000000 (32-bit, non-prefetchable) [size8K]
	I/O ports at c800 [size8]
	Capabilities: [40] Power Management version 1
	Capabilities: [50] AGP version 2.0

[root@drtheopolis lm_sensors2]# lspci -vn -d 1039:6300
01:00.0 Class 0300: 1039:6300 (rev 31)
	Subsystem: 1043:8032
	Flags: 66Mhz, medium devsel, IRQ 11
	BIST result: 00
	Memory at f0000000 (32-bit, prefetchable) [size8M]
	Memory at ea000000 (32-bit, non-prefetchable) [size8K]
	I/O ports at c800 [size8]
	Capabilities: [40] Power Management version 1
	Capabilities: [50] AGP version 2.0

As a test, I substituted PCI_DEVICE_ID_SI_630 with 0x6300:

        /* Look for the SIS630 */
        if (!(sis630_dev = pci_find_device(PCI_VENDOR_ID_SI,
                                            PCI_DEVICE_ID_SI_503,
                                            sis630_dev))) {
                printk(KERN_ERR "i2c-sis630.o: Error: Can't detect SIS630!\n");
                return -ENODEV;
        }
        tmp = pci_find_device(PCI_VENDOR_ID_SI,/*PCI_DEVICE_ID_SI_630*/0x6300,NULL);
        if (tmp = NULL && force = 0) {
                printk(KERN_ERR "i2c-sis630.o: Error: Can't detect SIS630!\n");
                return -ENODEV;
        }

And, things seems to be working thus far (but perhaps a bit slow):

eeprom-i2c-1-50
Adapter: SMBus SIS630 adapter at e480
Algorithm: Non-I2C SMBus adapter
Memory type:            SDRAM DIMM SPD
SDRAM Size (MB):        512

eeprom-i2c-1-51
Adapter: SMBus SIS630 adapter at e480
Algorithm: Non-I2C SMBus adapter
Memory type:            SDRAM DIMM SPD
SDRAM Size (MB):        512


Good work!  Perhaps we can add this chip ID to the detection?


Phil


On Sun, Sep 15, 2002 at 09:59:09PM +0200, Alexander Malysh wrote:
> Hi Mark , All:
> 
> First of all: sorry for late response...
> 
> As of today , I'm only user I know , who use i2c-sis630. At the moment I don't 
> have more commits to make.
> Because of adding i2c-sis630.c to mkpatch , I leave gladly the decision to 
> you...
> 
> Regards,
> Alexander Malysh
> 
> Am Samstag, 7. September 2002 17:40 schrieb Mark D. Studebaker:
> > Last minute stuff - any comments on whether to put in for 2.6.5 or wait?
> >
> > - add i2c-630 to mkpatch
> > - add i2c-645 to mkpatch
> > - add nVidia address discovery to i2c-amd756
> > - anything else?
> >
> > "Mark D. Studebaker" wrote:
> > > please check in / finish everything in the next week,
> > > let's say... by Monday Sept. 9th, for a release Friday the 13th!

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
