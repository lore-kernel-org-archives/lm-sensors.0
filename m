From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 09 Jan 2009 14:08:46 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] hwmon: (k8temp) fix wrong sensor
Message-Id: <20090109150846.117b24e5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 16 Dec 2008 00:10:41 +0100, Andreas Herrmann wrote:
> Meaning of ThermSenseCoreSel bit was inverted beginning with K8 RevF.
> That means with current driver temp1/temp2 belong to core 1 and
> temp3/temp4 belong to core 0 on a K8 RevF/RevG CPU.
> 
> This patch ensures that temp1/temp2 always belong to core 0 and
> temp3/temp4 to core 1 for all K8 revisions.
> 
> ... and warn about erratum #141 only for RevF/RevG CPUs.
> 
> Cc: Rudolf Marek <r.marek@assembler.cz>
> Signed-off-by: Andreas Herrmann <andreas.herrmann3@amd.com>
> ---
>  drivers/hwmon/k8temp.c |   17 +++++++++++++++--
>  1 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/k8temp.c b/drivers/hwmon/k8temp.c
> index be93387..ff12281 100644
> --- a/drivers/hwmon/k8temp.c
> +++ b/drivers/hwmon/k8temp.c
> @@ -48,6 +48,7 @@ struct k8temp_data {
>  	/* registers values */
>  	u8 sensorsp;		/* sensor presence bits - SEL_CORE & SEL_PLACE */
>  	u32 temp[2][2];		/* core, place */
> +	u8 swap_core_select;    /* meaning of SEL_CORE is inverted */
>  };
>  
>  static struct k8temp_data *k8temp_update_device(struct device *dev)
> @@ -117,6 +118,9 @@ static ssize_t show_temp(struct device *dev,
>  	int place = attr->index;
>  	struct k8temp_data *data = k8temp_update_device(dev);
>  
> +	if (data->swap_core_select)
> +		core = core ? 0 : 1;
> +
>  	return sprintf(buf, "%d\n",
>  		       TEMP_FROM_REG(data->temp[core][place]));
>  }
> @@ -161,8 +165,17 @@ static int __devinit k8temp_probe(struct pci_dev *pdev,
>  			err = -ENODEV;
>  			goto exit;
>  		}
> -		dev_warn(&pdev->dev, "Temperature readouts might be wrong"
> -					" - check errata #141\n");
> +
> +		/*
> +		 * AMD NPT family 0fh, i.e. RevF and RevG:
> +		 * meaning of SEL_CORE bit is inverted
> +		 */
> +		if (model >= 0x40) {
> +			data->swap_core_select = 1;
> +			dev_warn(&pdev->dev, "Temperature readouts might be "
> +				 "wrong - check erratum #141\n");
> +		}
> +
>  		break;
>  	}
>  

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
