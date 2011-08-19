From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 19 Aug 2011 21:16:24 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (i5k_amb) Replace BUG with WARN
Message-Id: <20110819231624.0bbd1439@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1313689771-31221-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1313689771-31221-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Thu, 18 Aug 2011 10:49:31 -0700, Guenter Roeck wrote:
> Executing BUG as a result of an internal driver error seems to be a bit harsh.

Well, that's pretty much what BUG was designed for: internal errors
that aren't supposed to happen.

> Replace it with WARN and return -ENODEV if the condition is seen.

I'm not sure what is the benefit of WARN over pr_warn() in this case.

> 
> This also resolves the following compile warning seen with some random
> configurations.
> 
> drivers/hwmon/i5k_amb.c: In function 'i5k_channel_pci_id':
> drivers/hwmon/i5k_amb.c:492: warning: control reaches end of non-void function
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
>  drivers/hwmon/i5k_amb.c |   18 +++++++++++-------
>  1 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hwmon/i5k_amb.c b/drivers/hwmon/i5k_amb.c
> index c4c40be..24e37e2 100644
> --- a/drivers/hwmon/i5k_amb.c
> +++ b/drivers/hwmon/i5k_amb.c
> @@ -478,8 +478,7 @@ out:
>  	return res;
>  }
>  
> -static unsigned long i5k_channel_pci_id(struct i5k_amb_data *data,
> -					unsigned long channel)
> +static long i5k_channel_pci_id(struct i5k_amb_data *data, unsigned long channel)
>  {
>  	switch (data->chipset_id) {
>  	case PCI_DEVICE_ID_INTEL_5000_ERR:
> @@ -487,7 +486,8 @@ static unsigned long i5k_channel_pci_id(struct i5k_amb_data *data,
>  	case PCI_DEVICE_ID_INTEL_5400_ERR:
>  		return PCI_DEVICE_ID_INTEL_5400_FBD0 + channel;
>  	default:
> -		BUG();
> +		WARN(1, "Unexpected chipset ID 0x%lx\n", data->chipset_id);
> +		return -ENODEV;
>  	}
>  }
>  
> @@ -528,14 +528,18 @@ static int __devinit i5k_amb_probe(struct platform_device *pdev)
>  		goto err;
>  
>  	/* Copy the DIMM presence map for the first two channels */
> -	res = i5k_channel_probe(&data->amb_present[0],
> -				i5k_channel_pci_id(data, 0));
> +	res = i5k_channel_pci_id(data, 0);
> +	if (res < 0)
> +		goto err;
> +	res = i5k_channel_probe(&data->amb_present[0], res);
>  	if (res)
>  		goto err;
>  
>  	/* Copy the DIMM presence map for the optional second two channels */
> -	i5k_channel_probe(&data->amb_present[2],
> -			  i5k_channel_pci_id(data, 1));
> +	res = i5k_channel_pci_id(data, 1);
> +	if (res < 0)

Note that this cannot happen, by construction. If the first call to
i5k_channel_pci_id succeeded then the second call must succeed too.

> +		goto err;
> +	i5k_channel_probe(&data->amb_present[2], res);
>  
>  	/* Set up resource regions */
>  	reso = request_mem_region(data->amb_base, data->amb_len, DRVNAME);

The whole problem here is that the way the code was designed makes it
seemingly possible for i5k_channel_pci_id to fail, while in practice I
don't think it ever can. The warning might be an opportunity to rework
it all so that not only the warning goes away but the code also gains
in clarity and efficiency. What do you think of the following patch?

Subject: hwmon: (i5k_amb) Drop i5k_channel_pci_id

Function i5k_channel_pci_id looks like it can fail, while a better
code design would make it more obvious that it can't. We can even get
rid of the function.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
Darrick, can you please test this alternative fix?

 drivers/hwmon/i5k_amb.c |   42 ++++++++++++++----------------------------
 1 file changed, 14 insertions(+), 28 deletions(-)

--- linux-3.1-rc2.orig/drivers/hwmon/i5k_amb.c	2011-07-22 04:17:23.000000000 +0200
+++ linux-3.1-rc2/drivers/hwmon/i5k_amb.c	2011-08-19 23:10:35.000000000 +0200
@@ -114,7 +114,6 @@ struct i5k_amb_data {
 	void __iomem *amb_mmio;
 	struct i5k_device_attribute *attrs;
 	unsigned int num_attrs;
-	unsigned long chipset_id;
 };
 
 static ssize_t show_name(struct device *dev, struct device_attribute *devattr,
@@ -444,8 +443,6 @@ static int __devinit i5k_find_amb_regist
 		goto out;
 	}
 
-	data->chipset_id = devid;
-
 	res = 0;
 out:
 	pci_dev_put(pcidev);
@@ -478,23 +475,13 @@ out:
 	return res;
 }
 
-static unsigned long i5k_channel_pci_id(struct i5k_amb_data *data,
-					unsigned long channel)
-{
-	switch (data->chipset_id) {
-	case PCI_DEVICE_ID_INTEL_5000_ERR:
-		return PCI_DEVICE_ID_INTEL_5000_FBD0 + channel;
-	case PCI_DEVICE_ID_INTEL_5400_ERR:
-		return PCI_DEVICE_ID_INTEL_5400_FBD0 + channel;
-	default:
-		BUG();
-	}
-}
-
-static unsigned long chipset_ids[] = {
-	PCI_DEVICE_ID_INTEL_5000_ERR,
-	PCI_DEVICE_ID_INTEL_5400_ERR,
-	0
+static struct {
+	unsigned long err;
+	unsigned long fbd0;
+} chipset_ids[] __devinitdata  = {
+	{ PCI_DEVICE_ID_INTEL_5000_ERR, PCI_DEVICE_ID_INTEL_5000_FBD0 },
+	{ PCI_DEVICE_ID_INTEL_5400_ERR, PCI_DEVICE_ID_INTEL_5400_FBD0 },
+	{ 0, 0 }
 };
 
 #ifdef MODULE
@@ -510,8 +497,7 @@ static int __devinit i5k_amb_probe(struc
 {
 	struct i5k_amb_data *data;
 	struct resource *reso;
-	int i;
-	int res = -ENODEV;
+	int i, res;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -520,22 +506,22 @@ static int __devinit i5k_amb_probe(struc
 	/* Figure out where the AMB registers live */
 	i = 0;
 	do {
-		res = i5k_find_amb_registers(data, chipset_ids[i]);
+		res = i5k_find_amb_registers(data, chipset_ids[i].err);
+		if (res = 0)
+			break;
 		i++;
-	} while (res && chipset_ids[i]);
+	} while (chipset_ids[i].err);
 
 	if (res)
 		goto err;
 
 	/* Copy the DIMM presence map for the first two channels */
-	res = i5k_channel_probe(&data->amb_present[0],
-				i5k_channel_pci_id(data, 0));
+	res = i5k_channel_probe(&data->amb_present[0], chipset_ids[i].fbd0);
 	if (res)
 		goto err;
 
 	/* Copy the DIMM presence map for the optional second two channels */
-	i5k_channel_probe(&data->amb_present[2],
-			  i5k_channel_pci_id(data, 1));
+	i5k_channel_probe(&data->amb_present[2], chipset_ids[i].fbd0 + 1);
 
 	/* Set up resource regions */
 	reso = request_mem_region(data->amb_base, data->amb_len, DRVNAME);


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
