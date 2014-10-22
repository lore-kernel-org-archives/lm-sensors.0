From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 22 Oct 2014 16:31:04 +0000
Subject: Re: [lm-sensors] hwmon: (i5500_temp) Convert to module_pci_driver
Message-Id: <20141022163104.GC31045@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1413984455.15240.1.camel@phoenix>
In-Reply-To: <1413984455.15240.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Oct 22, 2014 at 09:27:35PM +0800, Axel Lin wrote:
> Use module_pci_driver to simplify the code a bit.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/hwmon/i5500_temp.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
> 
> diff --git a/drivers/hwmon/i5500_temp.c b/drivers/hwmon/i5500_temp.c
> index ee3f6d9..82a6116 100644
> --- a/drivers/hwmon/i5500_temp.c
> +++ b/drivers/hwmon/i5500_temp.c
> @@ -171,7 +171,6 @@ static int i5500_temp_probe(struct pci_dev *pdev,
>  							   "intel5500",
>  							   data,
>  							   i5500_temp_groups);
> -

Always those whitespace changes ;-. I'd leave that up to Jean to decide
if he wants an empty line at this place or not.

Otherwise makes sense and looks good.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

>  	return PTR_ERR_OR_ZERO(hwmon_dev);
>  }
>  
> @@ -181,19 +180,8 @@ static struct pci_driver i5500_temp_driver = {
>  	.probe = i5500_temp_probe,
>  };
>  
> -static int __init i5500_temp_init(void)
> -{
> -	return pci_register_driver(&i5500_temp_driver);
> -}
> -
> -static void __exit i5500_temp_exit(void)
> -{
> -	pci_unregister_driver(&i5500_temp_driver);
> -}
> +module_pci_driver(i5500_temp_driver);
>  
>  MODULE_AUTHOR("Jean Delvare <jdelvare@suse.de>");
>  MODULE_DESCRIPTION("Intel 5500/5200/X58 chipset thermal sensor driver");
>  MODULE_LICENSE("GPL");
> -
> -module_init(i5500_temp_init)
> -module_exit(i5500_temp_exit)
> -- 
> 1.9.1
> 
> 
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
