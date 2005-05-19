From: vojtech@suse.cz (Vojtech Pavlik)
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: [PATCH] i2c driver changes for 2.5.64
Message-Id: <20030315104901.A3923@ucw.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <10476033263399@kroah.com> <10476033262095@kroah.com>
In-Reply-To: <10476033262095@kroah.com>; from greg@kroah.com on Thu, Mar 13, 2003 at 04:55:00PM -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

On Thu, Mar 13, 2003 at 04:55:00PM -0800, Greg KH wrote:

> diff -Nru a/drivers/i2c/busses/i2c-amd8111.c b/drivers/i2c/busses/i2c-amd8111.c
> --- a/drivers/i2c/busses/i2c-amd8111.c	Thu Mar 13 16:56:52 2003
> +++ b/drivers/i2c/busses/i2c-amd8111.c	Thu Mar 13 16:56:52 2003
 		goto out_release_region;
> @@ -389,7 +392,7 @@
>  }
>  
>  static struct pci_driver amd8111_driver = {
> -	.name		= "amd8111 smbus 2.0",
> +	.name		= "amd8111 smbus",
>  	.id_table	= amd8111_ids,
>  	.probe		= amd8111_probe,
>  	.remove		= __devexit_p(amd8111_remove),

The 2.0 was quite intentional in the .name, because the 8111 has *two*
SMBus busses, one SMBus 1.1 and one SMBus 2.0. This driver is only for
the 2.0 SMBus controller.

-- 
Vojtech Pavlik
SuSE Labs
