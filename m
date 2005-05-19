From: amalysh@web.de (Alexander Malysh)
Date: Thu, 19 May 2005 06:23:39 +0000
Subject: i2c-sis630 bus driver (was Re: last call for 2.6.5)
Message-Id: <200209181239.50422.amalysh@web.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020917150545.S20006@Stimpy.netroedge.com>
In-Reply-To: <20020917150545.S20006@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Phil,All:

Am Mittwoch, 18. September 2002 00:05 schrieb phil@netroedge.com:
> BTW- My workstation at work has an integrated sis630.  It comes up
> like this:
>
> [root@drtheopolis lm_sensors2]# lspci -v -d 1039:6300
> 01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS]
> SiS630 GUI Accelerator+3D (rev 31) (prog-if 00 [VGA])
> 	Subsystem: Asustek Computer, Inc.: Unknown device 8032
> 	Flags: 66Mhz, medium devsel, IRQ 11
> 	BIST result: 00
> 	Memory at f0000000 (32-bit, prefetchable) [size8M]
> 	Memory at ea000000 (32-bit, non-prefetchable) [size8K]
> 	I/O ports at c800 [size8]
> 	Capabilities: [40] Power Management version 1
> 	Capabilities: [50] AGP version 2.0
>
[snip]
I have this one too ... It's only VGA-Card. Can you please provide full 
lspci -vvv from this board ?

>
> As a test, I substituted PCI_DEVICE_ID_SI_630 with 0x6300:

no needed anymore , the driver have force option for this :)

>
>         /* Look for the SIS630 */
>         if (!(sis630_dev = pci_find_device(PCI_VENDOR_ID_SI,
>                                             PCI_DEVICE_ID_SI_503,
>                                             sis630_dev))) {
>                 printk(KERN_ERR "i2c-sis630.o: Error: Can't detect
> SIS630!\n"); return -ENODEV;
>         }
>         tmp > pci_find_device(PCI_VENDOR_ID_SI,/*PCI_DEVICE_ID_SI_630*/0x6300,NULL); if
> (tmp = NULL && force = 0) {
>                 printk(KERN_ERR "i2c-sis630.o: Error: Can't detect
> SIS630!\n"); return -ENODEV;
>         }
>
> And, things seems to be working thus far (but perhaps a bit slow):

yes it's slow, because I have disabled change of the Host Master Clock  (it's 
hang  my Laptop) ... You can try to change i2c-sis630.c at line 194
from: sis630_write(SMB_CNT, 0x00);
to: sis630_write(SMB_CNT, 0x20);

In this case Host Master Clock will be changed to 56KHz and should be a bit 
faster :) Tell me please if it works for you ...

Regards,
Alexander Malysh

P.S. I have sent a patch to you and list for support Onsemi MC1066 sensor. I 
have no answer , whether I may commit the changes  ?

>
> eeprom-i2c-1-50
> Adapter: SMBus SIS630 adapter at e480
> Algorithm: Non-I2C SMBus adapter
> Memory type:            SDRAM DIMM SPD
> SDRAM Size (MB):        512
>
> eeprom-i2c-1-51
> Adapter: SMBus SIS630 adapter at e480
> Algorithm: Non-I2C SMBus adapter
> Memory type:            SDRAM DIMM SPD
> SDRAM Size (MB):        512
>
>
> Good work!  Perhaps we can add this chip ID to the detection?
>
>
> Phil
>
> On Sun, Sep 15, 2002 at 09:59:09PM +0200, Alexander Malysh wrote:
> > Hi Mark , All:
> >
> > First of all: sorry for late response...
> >
> > As of today , I'm only user I know , who use i2c-sis630. At the moment I
> > don't have more commits to make.
> > Because of adding i2c-sis630.c to mkpatch , I leave gladly the decision
> > to you...
> >
> > Regards,
> > Alexander Malysh
> >
