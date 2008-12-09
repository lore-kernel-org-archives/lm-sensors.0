From: Rudolf Marek <r.marek@assembler.cz>
Date: Tue, 09 Dec 2008 22:18:08 +0000
Subject: Re: [lm-sensors] [PATCH 2/4] hwmon: (k8temp) fix wrong sensor
Message-Id: <493EEEA0.1030606@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081205175050.GC5581@alberich.amd.com>
In-Reply-To: <20081205175050.GC5581@alberich.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Good catch, thanks.

Just one minor comment bellow.

Rudolf


Andreas Herrmann napsal(a):
> Meaning of ThermSenseCoreSel bit was inverted beginning with K8 RevF.
> That means with current driver temp1/temp2 belong to core 1 and
> temp3/temp4 belong to core 0 on a dual core K8 RevF/RevG CPU.
> 
> This patch ensures that temp1/temp2 always belong to core 0 and
> temp3/temp4 to core 1 for all K8 revisions.
> 
> Signed-off-by: Andreas Herrmann <andreas.herrmann3@amd.com>
> ---
>  drivers/hwmon/k8temp.c |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hwmon/k8temp.c b/drivers/hwmon/k8temp.c
> index 712c208..894a929 100644
> --- a/drivers/hwmon/k8temp.c
> +++ b/drivers/hwmon/k8temp.c
> @@ -49,6 +49,7 @@ struct k8temp_data {
>  	/* registers values */
>  	u8 sensorsp;		/* sensor presence bits - SEL_CORE & SEL_PLACE */
>  	u32 temp[2][2];		/* core, place */
> +	u8 swap_core_select;    /* meaning of SEL_CORE is inverted */
>  };
>  
>  static struct k8temp_data *k8temp_update_device(struct device *dev)
> @@ -118,6 +119,9 @@ static ssize_t show_temp(struct device *dev,
>  	int place = attr->index;
>  	struct k8temp_data *data = k8temp_update_device(dev);
>  
> +	if (data->swap_core_select)
> +		core = core ? 0 : 1;
> +
>  	return sprintf(buf, "%d\n",
>  		       TEMP_FROM_REG(data->temp[core][place]));
>  }
> @@ -162,8 +166,17 @@ static int __devinit k8temp_probe(struct pci_dev *pdev,
>  			err = -ENODEV;
>  			goto exit;
>  		}
> +

Not sure if we can change this newline, I guess Jean is best coding style expert 
around.

>  		dev_warn(&pdev->dev, "Temperature readouts might be wrong"
>  			 " - check erratum #141\n");
> +
> +		/*
> +		 * AMD NPT familys 0fh, i.e. RevF and RevG:
> +		 * meaning of SEL_CORE bit is inverted
> +		 */
> +		if (model >= 0x40)
> +			data->swap_core_select = 1;
> +
>  		break;
>  	}
>  

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
