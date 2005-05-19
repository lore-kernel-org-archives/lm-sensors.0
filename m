From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:35 +0000
Subject: [PATCH 2.6] I2C: New chip driver: sis5595
Message-Id: <20050201165434.GD23118@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502011420.17466.adobriyan@mail.ru> <20050201121414.GA15219@bode.aurel32.net>
In-Reply-To: <20050201121414.GA15219@bode.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Aurelien Jarno <aurelien@aurel32.net>, Alexey Dobriyan <adobriyan@mail.ru>, linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com

On Tue, Feb 01, 2005 at 01:14:14PM +0100, Aurelien Jarno wrote:
> +/* Locate SiS bridge and correct base address for SIS5595 */
> +static int sis5595_find_sis(int *address)
> +{
> +	u16 val;
> +	int *i;
> +
> +	if (!(s_bridge > +	    pci_get_device(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_503, NULL)))
> +		return -ENODEV;

You never free the reference you grabbed on the pci_dev here.  Please
read the docs on how pci_get_device() is to be used, it isn't just a
drop in replacement for pci_find_device(), sorry.

> +	/* Look for imposters */
> +	for(i = blacklist; *i != 0; i++) {
> +		if (pci_get_device(PCI_VENDOR_ID_SI, *i, NULL)) {

Same here, you are leaking a reference count.

Why are you not using the pci driver interface instead?

thanks,

greg k-h
