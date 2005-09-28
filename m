From: greg@kroah.com (Greg KH)
Date: Wed, 28 Sep 2005 10:52:38 +0000
Subject: [lm-sensors] Re: [PATCH] unhide ICH6 SMBus
Message-Id: <20050928082816.GA11704@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050927215412.29072.qmail@desitka.sh.cvut.cz>
In-Reply-To: <20050927215412.29072.qmail@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Sep 27, 2005 at 09:54:12PM -0000, R.Marek@sh.cvut.cz wrote:
> Hello,
> 
> This patch unhides hidden SMBus on ICH6 chipset installed in
> Asus M6V notebook. I would like to thank Michal Mleczko for 
> testing and help.
> 
> Please apply.
> 
> Signed-Off-By: Rudolf Marek <r.marek@sh.cvut.cz>
> 
> Regards
> Rudolf
> 
> diff -Naur a/drivers/pci/quirks.c c/drivers/pci/quirks.c
> --- a/drivers/pci/quirks.c	2005-09-20 05:00:41.000000000 +0200
> +++ c/drivers/pci/quirks.c	2005-09-27 23:37:56.432160500 +0200
> @@ -847,6 +847,13 @@
>  			case 0x186a: /* M6Ne notebook */
>  				asus_hides_smbus = 1;
>  			}
> +		if (dev->device = PCI_DEVICE_ID_INTEL_82915GM_HB)
> +		{

Wrong brace placement according to the kernel coding style.  Care to
resend?

thanks,

greg k-h
