From: frodol@dds.nl (Frodo Looijaard)
Date: Thu, 19 May 2005 06:23:49 +0000
Subject: Fw: [PATCH] i2c-ali15x3.c changes for 2.5 kernel (fwd)
Message-Id: <200303061326.h26DQse01574@morannon.frodo.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Forwarded message:
> From greg@kroah.com Thu Mar  6 00:40:03 2003
> Date: Wed, 5 Mar 2003 15:17:18 -0800
> From: Greg KH <greg@kroah.com>
> To: simon@tk.uni-linz.ac.at, frodol@dds.nl
> Subject: Fw: [PATCH] i2c-ali15x3.c changes for 2.5 kernel
> Message-ID: <20030305231718.GH30933@kroah.com>
> Mime-Version: 1.0
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> User-Agent: Mutt/1.4i
> X-Loop-Procmail: PreventLoop
> 
> Hi,
> 
> I tried to send the message below to the sensors@stimpy.netroedge.com
> address, but it never showed up on the mailing list archive.  Is there a
> different email address to use for i2c kernel stuff?
> 
> Also, you all might want to update your MAINTAINER entry, as it has the
> web page pointing to an invalid site :)
> 
> thanks,
> 
> greg k-h
> 
> 
> ----- Forwarded message from Greg KH <greg@kroah.com> -----
> 
> Date: Mon, 3 Mar 2003 16:21:19 -0800
> From: Greg KH <greg@kroah.com>
> To: sensors@stimpy.netroedge.com
> Subject: [PATCH] i2c-ali15x3.c changes for 2.5 kernel
> 
> Hi,
> 
> Below is a small patch that is necessary to get the i2c-ali15x3.c driver
> to build and load properly in the 2.5 kernel tree.  It is against the
> latest cvs version.
> 
> Well, it loads for me, but on my machine it can't discover the proper
> address to use, I get the following error:
> i2c-ali15x3.o: ALI15X3_smb region uninitialized - upgrade BIOS or use force_addr=0xaddr
> i2c-ali15x3.o: ALI15X3 not detected, module not inserted.
> 
> Any hints on what to use as force_addr (I poked around with different
> values, but couldn't find anything obvious), or any pointers at spec
> sheets that might help me out in modifying this driver for my box?
> 
> Oh, this is the device:
> 00:06.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
> 00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV]
> and it's on a Fujitsu P2120 laptop.
> 
> Any help would be appreciated.
> 
> Also, any reason why this driver isn't in the main kernel tree yet?
> Need some help pushing some of these files to certain people?
> 
> Oh, and I'm starting to look at adding driver core support to the i2c
> core, anyone already start this work yet?  Or better yet, anyone mind if
> I do it?
> 
> thanks,
> 
> greg k-h
> 
> 
> --- kernel/busses/i2c-ali15x3.c	Tue Jan 21 12:01:27 2003
> +++ /home/greg/linux/linux-2.5/drivers/i2c/busses/i2c-ali15x3.c	Mon Mar  3 16:15:59 2003
> @@ -60,6 +60,7 @@
>  
>  /* Note: we assume there can only be one ALI15X3, with one SMBus interface */
>  
> +#include <linux/version.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/kernel.h>
> @@ -69,7 +70,6 @@
>  #include <linux/i2c.h>
>  #include <linux/init.h>
>  #include <asm/io.h>
> -#include "version.h"
>  
>  /* ALI15X3 SMBus address offsets */
>  #define SMBHSTSTS (0 + ali15x3_smba)
> @@ -135,29 +135,16 @@ static void ali15x3_do_pause(unsigned in
>  static int ali15x3_transaction(void);
>  
>  static unsigned short ali15x3_smba = 0;
> -static int locked=0;
>  
>  /* Detect whether a ALI15X3 can be found, and initialize it, where necessary.
>     Note the differences between kernels with the old PCI BIOS interface and
>     newer kernels with the real PCI interface. In compat.h some things are
>     defined to make the transition easier. */
> -int ali15x3_setup(void)
> +int ali15x3_setup(struct pci_dev *ALI15X3_dev)
>  {
>  	u16 a;
>  	unsigned char temp;
>  
> -	struct pci_dev *ALI15X3_dev;
> -
> -	/* First check whether we can access PCI at all */
> -	if (pci_present() = 0) {
> -		printk("i2c-ali15x3.o: Error: No PCI-bus found!\n");
> -		return -ENODEV;
> -	}
> -
> -	/* Look for the ALI15X3, M7101 device */
> -	ALI15X3_dev = NULL;
> -	ALI15X3_dev = pci_find_device(PCI_VENDOR_ID_AL,
> -				      PCI_DEVICE_ID_AL_M7101, ALI15X3_dev);
>  	if (ALI15X3_dev = NULL) {
>  		printk("i2c-ali15x3.o: Error: Can't detect ali15x3!\n");
>  		return -ENODEV;
> @@ -536,12 +523,18 @@ static struct i2c_adapter ali15x3_adapte
>  
>  
>  static struct pci_device_id ali15x3_ids[] __devinitdata = {
> +	{
> +	.vendor =	PCI_VENDOR_ID_AL,
> +	.device =	PCI_DEVICE_ID_AL_M7101,
> +	.subvendor =	PCI_ANY_ID,
> +	.subdevice =	PCI_ANY_ID,
> +	},
>  	{ 0, }
>  };
>  
>  static int __devinit ali15x3_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  {
> -	if (ali15x3_setup()) {
> +	if (ali15x3_setup(dev)) {
>  		printk
>  		    ("i2c-ali15x3.o: ALI15X3 not detected, module not inserted.\n");
>  
> @@ -551,6 +544,7 @@ static int __devinit ali15x3_probe(struc
>  	sprintf(ali15x3_adapter.name, "SMBus ALI15X3 adapter at %04x",
>  		ali15x3_smba);
>  	i2c_add_adapter(&ali15x3_adapter);
> +	return 0;
>  }
>  
>  static void __devexit ali15x3_remove(struct pci_dev *dev)
> @@ -567,7 +561,7 @@ static struct pci_driver ali15x3_driver 
>  
>  static int __init i2c_ali15x3_init(void)
>  {
> -	printk("i2c-ali15x3.o version %s (%s)\n", LM_VERSION, LM_DATE);
> +	printk("i2c-ali15x3\n");
>  	return pci_module_init(&ali15x3_driver);
>  }
>  
> 
> ----- End forwarded message -----
> 


-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.
