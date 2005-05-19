From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:27 +0000
Subject: [PATCH 2.6] I2C: i2c-nforce2 supports the nForce3 250Gb
Message-Id: <20041217213057.GA22479@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041217200217.3ed4e7cb.khali@linux-fr.org>
In-Reply-To: <20041217200217.3ed4e7cb.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Dec 17, 2004 at 08:02:17PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> One more PCI ID for the i2c-nforce2 driver, this time for the nForce3
> 250Gb variant. Tested, works.
> 
> (Also cleans up a duplicate define in pci_ids.h.)
> 
> Please apply,

Applied, thanks.

> @@ -296,6 +297,8 @@
>  	       	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
>  	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3_SMBUS,
>  	       	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
> +	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SMBUS,
> +	       	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },

Hint, the PCI_DEVICE() macro makes this a lot simpler :)

thanks,

greg k-h
