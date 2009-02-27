From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 27 Feb 2009 16:50:58 +0000
Subject: Re: [lm-sensors] [PATCH UPDATED] Add support to SB800 SMBus changes
Message-Id: <20090227175058.585d2506@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1235123028.5504.6.camel@chunhao-desktop>
In-Reply-To: <1235123028.5504.6.camel@chunhao-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: shane.huang-5C7GfCeVMHo@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org

Hi Shane,

On Fri, 20 Feb 2009 17:43:47 +0800, Shane Huang wrote:
> The original patch is updated with Jean's nice suggestions,
> please check it.
> 
> Thanks.
> Shane
> 
> == CUT HERE => This version of driver adds support for the AMD SB800 Family series of products.
> Major changes include the changes to addressing the SMBUS registers at different
> location from the locations in the previous compatible parts from AMD such as
> SB400/SB600/SB700. For SB800, the main features and register definitions of
> SMBUS and other interfaces are still compatible with the previous products with
> the only change being in how to access the internal registers for these blocks
> may differ.
> 
> Signed-off-by: Shane Huang <shane.huang@amd.com>

This new version of the patch looks acceptable to me. Even though I
find it unfortunate that ATI/AMD changed the hardware implementation to
something which is more complex to handle with no good reason that I
can see :(

> 
> diff -ruN a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
> --- a/drivers/i2c/busses/i2c-piix4.c	2009-02-20 01:08:40.000000000 +0800
> +++ b/drivers/i2c/busses/i2c-piix4.c	2009-02-20 01:34:45.000000000 +0800
> @@ -226,6 +226,68 @@
>  	return 0;
>  }
>  
> +static int __devinit piix4_setup_sb800(struct pci_dev *PIIX4_dev,
> +				const struct pci_device_id *id)
> +{
> +	unsigned short smba_idx = 0xcd6;
> +	u8 smba_en_lo, smba_en_hi, i2ccfg, i2ccfg_offset = 0x10, smb_en = 0x2c;
> +
> +	/* SB800 SMBus does not support forcing address */
> +	if (force || force_addr)
> +		dev_info(&PIIX4_dev->dev, "SB800 SMBus does not support "
> +			"forcing address!\n");

I would promote this to dev_warn(), or even dev_err() and fail.

> +
> +	/* Determine the address of the SMBus areas */
> +	if (!request_region(smba_idx, 2, "smba_idx")) {
> +		dev_err(&PIIX4_dev->dev, "SMBus base address index region "
> +			"0x%x already in use!\n", smba_idx);
> +		return -EBUSY;
> +	}
> +	outb_p(smb_en, smba_idx);
> +	smba_en_lo = inb_p(smba_idx + 1);
> +	outb_p(smb_en + 1, smba_idx);
> +	smba_en_hi = inb_p(smba_idx + 1);
> +	release_region(smba_idx, 2);
> +
> +	if ((smba_en_lo & 1) = 0) {
> +		dev_err(&PIIX4_dev->dev,
> +			"Host SMBus controller not enabled!\n");
> +		return -ENODEV;
> +	}
> +
> +	piix4_smba = ((smba_en_hi << 8) | smba_en_lo) & 0xffe0;
> +	if (acpi_check_region(piix4_smba, SMBIOSIZE, piix4_driver.name))
> +		return -EBUSY;
> +
> +	if (!request_region(piix4_smba, SMBIOSIZE, piix4_driver.name)) {
> +		dev_err(&PIIX4_dev->dev, "SMBus region 0x%x already in use!\n",
> +			piix4_smba);
> +		return -EBUSY;
> +	}
> +
> +	/* Request the SMBus I2C bus config region */
> +	if (!request_region(piix4_smba + i2ccfg_offset, 1, "i2ccfg")) {
> +		dev_err(&PIIX4_dev->dev, "SMBus I2C bus config region "
> +			"0x%x already in use!\n", piix4_smba + i2ccfg_offset);
> +		release_region(piix4_smba, SMBIOSIZE);
> +		piix4_smba = 0;
> +		return -EBUSY;
> +	}
> +	i2ccfg = inb_p(piix4_smba + i2ccfg_offset);
> +	release_region(piix4_smba + i2ccfg_offset, 1);
> +
> +	if (i2ccfg & 1)
> +		dev_dbg(&PIIX4_dev->dev, "Using IRQ for SMBus.\n");
> +	else
> +		dev_dbg(&PIIX4_dev->dev, "Using SMI# for SMBus.\n");
> +
> +	dev_info(&PIIX4_dev->dev,
> +		 "SMBus Host Controller at 0x%x, revision %d\n",
> +		 piix4_smba, i2ccfg >> 4);
> +
> +	return 0;
> +}
> +
>  static int piix4_transaction(void)
>  {
>  	int temp;
> @@ -434,7 +496,14 @@
>  {
>  	int retval;
>  
> -	retval = piix4_setup(dev, id);
> +	if ((dev->vendor = PCI_VENDOR_ID_ATI) &&
> +	    (dev->device = PCI_DEVICE_ID_ATI_SBX00_SMBUS) &&
> +	    (dev->revision >= 0x40))
> +		/* base address location etc changed in SB800 */
> +		retval = piix4_setup_sb800(dev, id);
> +	else
> +		retval = piix4_setup(dev, id);
> +
>  	if (retval)
>  		return retval;
>  

All the rest looks good, I'll apply your patch now.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
