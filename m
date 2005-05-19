From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:47 +0000
Subject: [PATCH] p4b_smbus quirk update
Message-Id: <3E502338.50206@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030202110314.GA1759@brodo.de>
In-Reply-To: <20030202110314.GA1759@brodo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

That's a good idea.
Did you submit it to the kernel?
If it gets in let us know.
thanks

Dominik Brodowski wrote:
> Hi,
> 
> The p4b_smbus.c module located in lm_sensors-2.7.0/prog/hotplug does not
> work for 2.5. kernels. Also, the code can be simplified much if enabling the
> SMBus device is done as a "pci quirk" in drivers/pci/quirks.c in the linux
> kernel sources. A patch for linux-kernel 2.5.59 is attached below. However, 
> it _might_ be wise to add a check so that only Asus mainboards are affected.
> 
> 	Dominik
> 
> diff -ruN linux-original/drivers/pci/quirks.c linux/drivers/pci/quirks.c
> --- linux-original/drivers/pci/quirks.c	2003-02-01 17:33:43.000000000 +0100
> +++ linux/drivers/pci/quirks.c	2003-02-02 11:50:12.000000000 +0100
> @@ -535,6 +535,21 @@
>  	}
>  }
>  
> +static void __devinit quirk_p4b_smbus(struct pci_dev *dev)
> +{
> +	u16 val;
> +	pci_read_config_word(dev, 0xF2, &val);
> +	if (val & 0x8) {
> +		pci_write_config_word(dev, 0xF2, val & (~0x8));
> +		pci_read_config_word(dev, 0xF2, &val);
> +		if(val & 0x8) 
> +			printk(KERN_INFO "PCI: Fixup to enable i801 SMBus device failed - 0x%x", val);
> +		else
> +			printk(KERN_INFO "PCI: Fixup to enable i801 SMBus successful! - 0x%x\n", val);
> +	}
> +	return;
> +}
> +
>  /*
>   *  The main table of quirks.
>   */
> @@ -604,6 +619,12 @@
>  
>  	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_CYRIX,	PCI_DEVICE_ID_CYRIX_PCI_MASTER, quirk_mediagx_master },
>  	
> +	/*
> +	 * on Asus P4B boards, the i801SMBus device is disabled.
> +	 */
> +	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801BA_0,	quirk_p4b_smbus },
> +	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_0,	quirk_p4b_smbus },
> +
>  
>  	{ 0 }
>  };
> 
