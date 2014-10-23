From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 23 Oct 2014 08:46:38 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (i5500_temp) Fix typo in module description
Message-Id: <20141023104638.77d5b185@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1414051988.26829.0.camel@phoenix>
In-Reply-To: <1414051988.26829.0.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Axel,

On Thu, 23 Oct 2014 16:13:08 +0800, Axel Lin wrote:
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/hwmon/i5500_temp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/i5500_temp.c b/drivers/hwmon/i5500_temp.c
> index 3774911..e19d5d7 100644
> --- a/drivers/hwmon/i5500_temp.c
> +++ b/drivers/hwmon/i5500_temp.c
> @@ -184,5 +184,5 @@ static struct pci_driver i5500_temp_driver = {
>  module_pci_driver(i5500_temp_driver);
>  
>  MODULE_AUTHOR("Jean Delvare <jdelvare@suse.de>");
> -MODULE_DESCRIPTION("Intel 5500/5200/X58 chipset thermal sensor driver");
> +MODULE_DESCRIPTION("Intel 5500/5520/X58 chipset thermal sensor driver");
>  MODULE_LICENSE("GPL");

Good catch, thanks. As the patch introducing the typo isn't upstream
yet, I've merged the fixup in it.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
