From: Clemens Ladisch <clemens@ladisch.de>
Date: Thu, 12 Sep 2013 08:19:45 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (k10temp) remove unnecessary pci_set_drvdata()
Message-Id: <52317921.30406@ladisch.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <001801ceaf83$d5633bb0$8029b310$%han@samsung.com>
In-Reply-To: <001801ceaf83$d5633bb0$8029b310$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jingoo Han wrote:
> The driver core clears the driver data to NULL after device_release
> or on probe failure. Thus, it is not needed to manually clear the
> device driver data to NULL.
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Acked-by: Clemens Ladisch <clemens@ladisch.de>

> ---
>  drivers/hwmon/k10temp.c |    1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index e633856..d65f3fd 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -202,7 +202,6 @@ static void k10temp_remove(struct pci_dev *pdev)
>  			   &sensor_dev_attr_temp1_crit.dev_attr);
>  	device_remove_file(&pdev->dev,
>  			   &sensor_dev_attr_temp1_crit_hyst.dev_attr);
> -	pci_set_drvdata(pdev, NULL);
>  }
>
>  static DEFINE_PCI_DEVICE_TABLE(k10temp_id_table) = {

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
