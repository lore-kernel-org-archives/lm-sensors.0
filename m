From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:34 +0000
Subject: [PATCH 2.6] I2C: New chip driver: sis5595
Message-Id: <20050131182148.GA21438@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050125220945.GA23560@bode.aurel32.net>
In-Reply-To: <20050125220945.GA23560@bode.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Aur?lien Jarno <aurelien@aurel32.net>, sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 11:09:45PM +0100, Aur?lien Jarno wrote:
> +/* Locate SiS bridge and correct base address for SIS5595 */
> +static int sis5595_find_sis(int *address)
> +{
> +	u16 val;
> +	int *i;
> +
> +	if (!(s_bridge > +	    pci_find_device(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_503, NULL)))

Please use pci_get_device().  It's safer, and not a depreciated
function.

> +	/* Look for imposters */
> +	for(i = blacklist; *i != 0; i++) {
> +		if (pci_find_device(PCI_VENDOR_ID_SI, *i, NULL)) {

Same here.

> +			printk("sis5595.ko: Error: Looked for SIS5595 but found unsupported device %.4X\n", *i);

<snip>

> +		printk("sis5595.ko: base address not set - upgrade BIOS or use force_addr=0xaddr\n");

These printk() calls need a KERN_ level.  Why not use the dev_* calls
instead?  You have a pci_dev to use here, right?

thanks,

greg k-h
