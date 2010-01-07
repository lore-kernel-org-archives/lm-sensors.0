From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 07 Jan 2010 15:06:43 +0000
Subject: Re: [lm-sensors] [PATCH 1/5] via686a: make PCI device id constant
Message-Id: <20100107160643.35af80a5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4B427D3B.6080709@freemail.hu>
In-Reply-To: <4B427D3B.6080709@freemail.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?TsOpbWV0aCBNw6FydG9u?= <nm127@freemail.hu>
Cc: lm-sensors@lm-sensors.org, Julia Lawall <julia@diku.dk>, LKML <linux-kernel@vger.kernel.org>, cocci@diku.dk

On Tue, 05 Jan 2010 00:43:55 +0100, Németh Márton wrote:
> From: Márton Németh <nm127@freemail.hu>
> 
> The id_table field of the struct pci_driver is constant in <linux/pci.h>
> so it is worth to make pci_device_id also constant.
> 
> The semantic match that finds this kind of pattern is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @r@
> identifier I1, I2, x;
> @@
> 	struct I1 {
> 	  ...
> 	  const struct I2 *x;
> 	  ...
> 	};
> @s@
> identifier r.I1, y;
> identifier r.x, E;
> @@
> 	struct I1 y = {
> 	  .x = E,
> 	};
> @c@
> identifier r.I2;
> identifier s.E;
> @@
> 	const struct I2 E[] = ... ;
> @depends on !c@
> identifier r.I2;
> identifier s.E;
> @@
> +	const
> 	struct I2 E[] = ...;
> // </smpl>
> 
> Signed-off-by: Márton Németh <nm127@freemail.hu>
> Cc: Julia Lawall <julia@diku.dk>
> Cc: cocci@diku.dk
> ---
> diff -u -p a/drivers/hwmon/via686a.c b/drivers/hwmon/via686a.c
> --- a/drivers/hwmon/via686a.c 2009-12-03 04:51:21.000000000 +0100
> +++ b/drivers/hwmon/via686a.c 2010-01-03 20:55:10.000000000 +0100
> @@ -767,7 +767,7 @@ static struct via686a_data *via686a_upda
>  	return data;
>  }
> 
> -static struct pci_device_id via686a_pci_ids[] = {
> +static const struct pci_device_id via686a_pci_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_4) },
>  	{ 0, }
>  };

I've merged all 5 patches are they are doing the exact same thing to 5
drivers. The resulting patch is applied, thanks.


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
