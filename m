From: Lars-Peter Clausen <lars@metafoo.de>
Date: Tue, 11 Feb 2014 12:12:24 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (jz4740) Use devm_ioremap_resource()
Message-Id: <52FA13A8.5080208@metafoo.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <000701cf2722$4dba9ac0$e92fd040$%han@samsung.com>
In-Reply-To: <000701cf2722$4dba9ac0$e92fd040$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 02/11/2014 01:10 PM, Jingoo Han wrote:
> Use devm_ioremap_resource() in order to make the code simpler,
> and move 'struct resource *mem' from 'struct jz4740_hwmon' to
> jz4740_hwmon_probe() because the 'mem' variable is used only in
> jz4740_hwmon_probe(). Also the redundant return value check of
> platform_get_resource() is removed, because the value is checked
> by devm_ioremap_resource().
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
>   drivers/hwmon/jz4740-hwmon.c |   25 +++++--------------------
>   1 file changed, 5 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/hwmon/jz4740-hwmon.c b/drivers/hwmon/jz4740-hwmon.c
> index a183e48..7488e36 100644
> --- a/drivers/hwmon/jz4740-hwmon.c
> +++ b/drivers/hwmon/jz4740-hwmon.c
> @@ -28,7 +28,6 @@
>   #include <linux/hwmon.h>
>
>   struct jz4740_hwmon {
> -	struct resource *mem;
>   	void __iomem *base;
>
>   	int irq;
> @@ -106,6 +105,7 @@ static int jz4740_hwmon_probe(struct platform_device *pdev)
>   {
>   	int ret;
>   	struct jz4740_hwmon *hwmon;
> +	struct resource *mem;
>
>   	hwmon = devm_kzalloc(&pdev->dev, sizeof(*hwmon), GFP_KERNEL);
>   	if (!hwmon)
> @@ -120,25 +120,10 @@ static int jz4740_hwmon_probe(struct platform_device *pdev)
>   		return hwmon->irq;
>   	}
>
> -	hwmon->mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!hwmon->mem) {
> -		dev_err(&pdev->dev, "Failed to get platform mmio resource\n");
> -		return -ENOENT;
> -	}
> -
> -	hwmon->mem = devm_request_mem_region(&pdev->dev, hwmon->mem->start,
> -			resource_size(hwmon->mem), pdev->name);
> -	if (!hwmon->mem) {
> -		dev_err(&pdev->dev, "Failed to request mmio memory region\n");
> -		return -EBUSY;
> -	}
> -
> -	hwmon->base = devm_ioremap_nocache(&pdev->dev, hwmon->mem->start,
> -					   resource_size(hwmon->mem));
> -	if (!hwmon->base) {
> -		dev_err(&pdev->dev, "Failed to ioremap mmio memory\n");
> -		return -EBUSY;
> -	}
> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	hwmon->base = devm_ioremap_resource(&pdev->dev, mem);
> +	if (IS_ERR(hwmon->base))
> +		return PTR_ERR(hwmon->base);
>
>   	init_completion(&hwmon->read_completion);
>   	mutex_init(&hwmon->lock);
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
