From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: SiS735 chipset SMBus driver for kernel 2.6
Message-Id: <20040221011216.GG18346@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040219020339.GE21829@earth.solarsys.private>
In-Reply-To: <20040219020339.GE21829@earth.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Feb 18, 2004 at 09:03:39PM -0500, Mark M. Hoffman wrote:
> diff -Nru linux-2.6.3-orig/drivers/pci/quirks.c linux-2.6.3-mmh/drivers/pci/quirks.c
> --- linux-2.6.3-orig/drivers/pci/quirks.c	2004-02-10 12:55:18.000000000 -0500
> +++ linux-2.6.3-mmh/drivers/pci/quirks.c	2004-02-18 20:37:32.000000000 -0500
> @@ -757,7 +757,7 @@
>  
>  #define SIS_DETECT_REGISTER 0x40
>  
> -static void __init quirk_sis_503_smbus(struct pci_dev *dev)
> +static void __init quirk_sis_503(struct pci_dev *dev)

Why rename the function?

thanks,

greg k-h
