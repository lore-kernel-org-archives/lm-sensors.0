From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 11 Apr 2006 12:07:32 +0000
Subject: [lm-sensors] [PATCH 2.6] scx200_acb: Use PCI I/O resource when
Message-Id: <20060411140732.70cb0f25.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060331230309.GE17261@cosmic.amd.com>
In-Reply-To: <20060331230309.GE17261@cosmic.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: linux-kernel@vger.kernel.org, info-linux@ldcmail.amd.com, BGardner@Wabtec.com, lm-sensors@lm-sensors.org

Hi Jordan,

Better late than never, I guess...

> The CS5535 and CS5536 both define the I/O base for the SMBUS device in a 
> PCI header.  This patch uses that header for the I/O base rather then 
> using the MSR backdoor.

I'm all for doing things the Right Way (TM) but in this case it seems
to make the code rather longer and slightly more complex. If you go
that way, wouldn't it be easier to have a proper pci driver?

On the code itself:

> -static int  __init scx200_acb_create(const char *text, int base, int index)
> +static int __init scx200_acb_create(char *text, unsigned int base, int index,
> +				    struct pci_dev *pdev, int bar)

Why are you removing that "const"? It looked alright to me.

Also, if you are changing base to be unsigned, you could make it an
unsigned long while you're at it - that's the type resource addresses
are supposed to be.

> +		if (pci_request_region(iface->pdev, iface->bar, description)) {
> +			printk(KERN_ERR NAME ": can't allocate PCI region %d\n",
> +			       iface->bar);
> +			rc = -EBUSY;
> +			goto errout_free;
> +		}

You could pass the error value returned by pci_request_region instead of
redefining your own.

> -static struct pci_device_id divil_pci[] = {
> -	{ PCI_DEVICE(PCI_VENDOR_ID_NS,  PCI_DEVICE_ID_NS_CS5535_ISA) },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_ISA) },
> -	{ } /* NULL entry */
> +/* On the CS5535 and CS5536, the SMBUS I/0 base is a PCI resource, so
> +   we should allocate that resource through the PCI
> +   subsystem. rather then going through the MSR back door.
> +*/
> +
> +static struct {
> +	unsigned int vendor;
> +	unsigned int device;
> +	char *name;
> +	int bar;
> +} divil_pci[] = {
> +	{
> +	PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_CS5535_ISA, "CS5535", 0}, {
> +	PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_ISA, "CS5536", 0}
>  };

It might not be a good idea to move away from pci_device_id. With it,
we could have made that module auto-loaded when the supported hardware
is found.

> +#define DIVIL_LENGTH (sizeof(divil_pci) / sizeof(divil_pci[0]))

Use the ARRAY_SIZE macro instead please.

>  static int __init scx200_acb_init(void)
>  {
>  	int i;
> -	int	rc = -ENODEV;
> +	int rc     = -ENODEV;

Eek. Changing broken coding style for even more broken coding style?
That initialization seems to be no more useful with the changes below,
BTW.

> -	/* Verify that this really is a SCx200 processor */
> -	if (pci_dev_present(scx200)) {
> -		for (i = 0; i < MAX_DEVICES; ++i) {
> -			if (base[i] > 0)
> -				rc = scx200_acb_create("SCx200", base[i], i);
> -		}
> -	} else if (pci_dev_present(divil_pci))
> -		rc = scx200_add_cs553x();
> +	/* If this is a CS5535 or CS5536, then probe the PCI header */
> +
> +	if (!pci_dev_present(scx200))
> +		return scx200_add_cs553x();
> +
> +	for (i = 0; i < MAX_DEVICES; ++i) {
> +		if (base[i] > 0)
> +			rc = scx200_acb_create("SCx200", base[i], i, NULL, 0);
> +	}

You could have made that change much smaller. What's the benefit of
swapping the order?

-- 
Jean Delvare

