From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 17 Feb 2009 16:49:29 +0000
Subject: Re: [lm-sensors] [PATCH] Add support to SB800 SMBus changes
Message-Id: <20090217174929.3c775cc4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1234430547.5588.8.camel@chunhao-desktop>
In-Reply-To: <1234430547.5588.8.camel@chunhao-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, shane.huang-5C7GfCeVMHo@public.gmane.org

Hi Shane,

On Thu, 12 Feb 2009 17:22:27 +0800, Shane Huang wrote:
> This version of driver adds support for the AMD SB800 Family series of products.
> Major changes include the changes to addressing the SMBUS registers at different
> location from the locations in the previous compatible parts from AMD such as
> SB400/SB600/SB700. For SB800, the main features and register definitions of
> SMBUS and other interfaces are still compatible with the previous products with
> the only change being in how to access the internal registers for these blocks
> may differ.
> 
> Signed-off-by: Shane Huang <shane.huang@amd.com>
> 
> diff -ruN a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
> --- a/drivers/i2c/busses/i2c-piix4.c	2009-02-07 00:58:32.000000000 +0800
> +++ b/drivers/i2c/busses/i2c-piix4.c	2009-02-11 14:28:37.000000000 +0800
> @@ -130,11 +130,20 @@
>  				const struct pci_device_id *id)
>  {
>  	unsigned char temp;
> +	int sbx00_quirk = 0;
> +	u8 sbx00_a = 0, sbx00_b = 0, sbx00_i2ccfg = 0;

As only the SB800 is affected, and the SB600 and SB700 are not, I would
suggest renaming these variables to sb800_quirk, sb800_i2ccfg, etc. And
please come up with better names for sbx00_a and sbx00_b, it's not clear
what they are supposed to be.

>  
>  	if ((PIIX4_dev->vendor = PCI_VENDOR_ID_SERVERWORKS) &&
>  	    (PIIX4_dev->device = PCI_DEVICE_ID_SERVERWORKS_CSB5))
>  		srvrworks_csb5_delay = 1;
>  
> +	if ((PIIX4_dev->vendor = PCI_VENDOR_ID_ATI) &&
> +	    (PIIX4_dev->device = PCI_DEVICE_ID_ATI_SBX00_SMBUS) &&
> +	    (PIIX4_dev->revision >= 0x40)) {
> +		dev_info(&PIIX4_dev->dev, "Apply SBX00 SMBus quirk.\n");
> +		sbx00_quirk = 1;
> +	}
> +
>  	/* On some motherboards, it was reported that accessing the SMBus
>  	   caused severe hardware problems */
>  	if (dmi_check_system(piix4_dmi_blacklist)) {
> @@ -157,13 +166,24 @@
>  		piix4_smba = force_addr & 0xfff0;
>  		force = 0;
>  	} else {
> -		pci_read_config_word(PIIX4_dev, SMBBA, &piix4_smba);
> -		piix4_smba &= 0xfff0;
> -		if(piix4_smba = 0) {
> -			dev_err(&PIIX4_dev->dev, "SMBus base address "
> -				"uninitialized - upgrade BIOS or use "
> -				"force_addr=0xaddr\n");
> -			return -ENODEV;
> +		if (sbx00_quirk) {
> +			/* SBX00 base address location changed in some revs */
> +			dev_dbg(&PIIX4_dev->dev, "SBX00 SMBus base address "
> +				"location changed in some revisions!\n");
> +			outb_p(0x2c, 0xcd6);
> +			sbx00_a = inb_p(0xcd7);
> +			outb_p(0x2d, 0xcd6);
> +			sbx00_b = inb_p(0xcd7);
> +			piix4_smba = ((sbx00_b << 8) | sbx00_a) & 0xffe0;

What device is at 0xcd6/0xcd7, and how can you be sure it is there? You
can't access arbitrary I/O ports like that. This needs to be done
properly. Especially as it appears to be an index/data register pair,
this needs proper locking.

> +		} else {
> +			pci_read_config_word(PIIX4_dev, SMBBA, &piix4_smba);
> +			piix4_smba &= 0xfff0;
> +			if (piix4_smba = 0) {
> +				dev_err(&PIIX4_dev->dev, "SMBus base address "
> +					"uninitialized - upgrade BIOS or use "
> +					"force_addr=0xaddr\n");
> +				return -ENODEV;
> +			}
>  		}
>  	}
>  
> @@ -176,7 +196,13 @@
>  		return -EBUSY;
>  	}
>  
> -	pci_read_config_byte(PIIX4_dev, SMBHSTCFG, &temp);
> +	if (sbx00_quirk) {
> +		/* Assemble the compatible value for some SBX00 revisions */
> +		sbx00_i2ccfg = inb_p(piix4_smba + 0x10);
> +		temp = ((sbx00_i2ccfg << 1) & 0x2) | (sbx00_a & 0x1);
> +	} else {
> +		pci_read_config_byte(PIIX4_dev, SMBHSTCFG, &temp);
> +	}
>  
>  	/* If force_addr is set, we program the new address here. Just to make
>  	   sure, we disable the PIIX4 first. */
> @@ -218,7 +244,12 @@
>  		dev_err(&PIIX4_dev->dev, "Illegal Interrupt configuration "
>  			"(or code out of date)!\n");
>  
> -	pci_read_config_byte(PIIX4_dev, SMBREV, &temp);
> +	if (sbx00_quirk)
> +		/* Assemble the compatible value for some SBX00 revisions */
> +		temp = (sbx00_i2ccfg >> 4) & 0x0f;

Mask is not needed, u8 >> 4 can't be more than 4 bits by definition.

> +	else
> +		pci_read_config_byte(PIIX4_dev, SMBREV, &temp);
> +
>  	dev_info(&PIIX4_dev->dev,
>  		 "SMBus Host Controller at 0x%x, revision %d\n",
>  		 piix4_smba, temp);
> 

Your patch breaks module parameters force and force_addr. You probably
don't need them (I would in fact be happy to get rid of them altogether)
but as long as they are there you must "handle" them properly. The
easiest way do handle them is to cleanly ignore them for ATI SB800
devices.

I suspect the code would gain in clarity, if you would move the
SB800-specific code to a separate function. After all there's almost
nothing in common between the setup of the original device and the
setup of the SB800. So instead of several conditionals, a plain
separate function would probably be more readable.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
