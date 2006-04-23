From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Sun, 23 Apr 2006 22:16:26 +0000
Subject: [lm-sensors] asb100 not working in kernel 2.6.16
Message-Id: <20060423221626.GA26342@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <44496569.6030100@superig.com.br>
In-Reply-To: <44496569.6030100@superig.com.br>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Paulo:

> * Paulo Roma Cavalcanti <crotalus at superig.com.br> [2006-04-21 20:06:17 -0300]:
> > I have been using lm_sensors for a long time
> > on an Asus P4S333 motherboard.
> > However, they are no longer working with the 2.6.16
> > kernel series. During the boot there is a message
> > saying it cannot find any i2c information.

* Mark M. Hoffman <mhoffman at lightlink.com> [2006-04-22 14:35:15 -0400]:
> This is in fact the same board I used to develop both the sis96x and asb100
> drivers in the first place.
> 
> > Interesting is that the modules are loaded:
> > 
> > eeprom                  7249  0
> > asb100                 20437  0
> > hwmon_vid               2881  1 asb100
> > hwmon                   3269  1 asb100
> > i2c_sis96x              5829  0
> > i2c_core               21697  3 eeprom,asb100,i2c_sis96x
> > rfcomm                 36821  0
> > l2cap                  24641  5 rfcomm
> > 
> > But if I try to read the sensors, I get:
> > 
> > Can't access procfs/sysfs file
> > Unable to find i2c bus information;
> > For 2.6 kernels, make sure you have mounted sysfs and libsensors
> > was compiled with sysfs support!
> > For older kernels, make sure you have done 'modprobe i2c-proc'!
> > 
> > My system is a Fedora 4 with latest lm_sensors from ATrpms.
> > 
> > Linux version 2.6.16-1.2096_FC4 (bhcompile at hs20-bc1-4.build.redhat.com)
> 
> I just booted my P4S333 with this kernel under FC4... same result.  Oddly
> enough, it works just fine with a vanilla 2.6.16.
> 
> Paulo: if you run 'lspci' I think you will find device "00:02.1" to be
> missing.  This is the problem.  Somehow, the vendor kernel does not do
> the PCI quirk properly to "unhide" that device.  I will look into it
> further tomorrow... but at least, the workaround is to use a vanilla
> kernel.

Here's the problem:  two PCI quirks (drivers/pci/quirks.c) are required for
the SMBus device on this board.  The first is quirk_sis_503(), which twiddles
some bits so that the south bridge has the proper name: 

	00:02.0 Class 0601: 1039:0961

The second quirk is quirk_sis_96x_smbus(), which will only run if the above
device is found.

But in the FC4 kernel, the second quirk is processed first... so 1039:0961
is not yet available.  If you look at System.map, for some reason the 
SMBus quirks come first in the link order... even though those are declared
after the 503 quirk in the same file.  

[mark at mars boot]$ cat System.map-2.6.16-1.2096_FC4 | grep __pci_fixup_ | grep PCI_VENDOR_ID_SI | sort
c03589ac r __pci_fixup_PCI_VENDOR_ID_SIPCI_DEVICE_ID_SI_LPCquirk_sis_96x_smbus
c03589b4 r __pci_fixup_PCI_VENDOR_ID_SIPCI_DEVICE_ID_SI_963quirk_sis_96x_smbus
c03589bc r __pci_fixup_PCI_VENDOR_ID_SIPCI_DEVICE_ID_SI_962quirk_sis_96x_smbus
c03589c4 r __pci_fixup_PCI_VENDOR_ID_SIPCI_DEVICE_ID_SI_961quirk_sis_96x_smbus
c03589cc r __pci_fixup_PCI_VENDOR_ID_SIPCI_DEVICE_ID_SI_503quirk_sis_503

So, two possibilities: 

1) We can't depend on the link order, so the quirks need to be fixed.

2) We *can* depend on link order, but FC4 breaks it somehow.

I'm going to file a bug in FC bugzilla, and copy this message into it.
We'll see what they think.

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


