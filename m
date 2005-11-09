From: paul.aviles@palei.com (Paul Aviles)
Date: Wed, 09 Nov 2005 05:19:06 +0000
Subject: [lm-sensors] Re: [PATCH] hwmon: Add VRM 10 support for ADT7463
Message-Id: <001301c5e4e4$a700efa0$3224050a@avilespaxp>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051108234728.35b0223b.khali@linux-fr.org>
In-Reply-To: <20051108234728.35b0223b.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I will not be able to upgrade to 2.6.14 until the weekend but can test 
later.

Thanks

Paul Aviles

----- Original Message ----- 
From: "Jean Delvare" <khali@linux-fr.org>
To: "LM Sensors" <lm-sensors@lm-sensors.org>
Cc: "Philip Pokorny" <ppokorny@penguincomputing.com>; "Justin Thiessen" 
<jthiessen@penguincomputing.com>; "Rafael ?vila de Esp?ndola" 
<rafael.espindola@gmail.com>; "Paul Aviles" <paul.aviles@palei.com>
Sent: Tuesday, November 08, 2005 5:47 PM
Subject: [PATCH] hwmon: Add VRM 10 support for ADT7463


> Hi all,
>
> After Paul's report, I've read the ADT7463 datasheet and found that
> this chip does optionally supports VRD 10, while all other chips of the
> family only support VRM 9. The additional VID pin is shared with
> in4/+12V so you can't use this analog input when VRM 10 is used, as is
> the case with recent Pentium 4 CPUs.
>
> I have come up with the following patch which adds support for this
> feature. The VID configuration register is read at
> detection/initialization time to decide whether the shared pin is used
> for in4 or VID5. Then the driver omits to create the in4* sysfs files
> if in4 isn't supported, and allows for a 6th VID bit instead.
>
> Reviews of this patch would be welcome, as would be tests thereof. I
> don't own a compatible chip myself. It would be interesting to test
> both on an ADT7463 chip using VRM 10 and on other chips of the family,
> so as to make sure I didn't inadvertently break anything.
>
> Note that the patch also adds a mask when reading the VID register even
> in the common VRM 9 case. This should have been done that way in the
> first place, as we can't assume the value of the three unused bits.
> We're lucky it didn't cause trouble so far.
>
> Another side effect is that the VID register is now considered as one
> which changes frequently. I think it's better this way because newer
> CPUs tend to change Vcores on the fly to reduce heat generation and
> power consumption, and it's convenient to be able to track this.
>
> Thanks
>
> * * * * *
>
> Support the VRM 10 mode of the ADT7463.
>
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
>
> drivers/hwmon/lm85.c |   44 ++++++++++++++++++++++++++++++++++++--------
> 1 files changed, 36 insertions(+), 8 deletions(-)
>
> --- linux-2.6.14.orig/drivers/hwmon/lm85.c 2005-11-02 14:35:39.000000000 
> +0100
> +++ linux-2.6.14/drivers/hwmon/lm85.c 2005-11-08 17:18:48.000000000 +0100
> @@ -443,7 +443,17 @@
> static ssize_t show_vid_reg(struct device *dev, struct device_attribute 
> *attr, char *buf)
> {
>  struct lm85_data *data = lm85_update_device(dev);
> - return sprintf(buf, "%ld\n", (long) vid_from_reg(data->vid, data->vrm));
> + int vid;
> +
> + if (data->type = adt7463 && (data->vid & 0x80)) {
> + /* 6-pin VID (VRM 10) */
> + vid = vid_from_reg(data->vid & 0x3f, data->vrm);
> + } else {
> + /* 5-pin VID (VRM 9) */
> + vid = vid_from_reg(data->vid & 0x1f, data->vrm);
> + }
> +
> + return sprintf(buf, "%d\n", vid);
> }
>
> static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
> @@ -1176,17 +1186,14 @@
>  device_create_file(&new_client->dev, &dev_attr_in1_input);
>  device_create_file(&new_client->dev, &dev_attr_in2_input);
>  device_create_file(&new_client->dev, &dev_attr_in3_input);
> - device_create_file(&new_client->dev, &dev_attr_in4_input);
>  device_create_file(&new_client->dev, &dev_attr_in0_min);
>  device_create_file(&new_client->dev, &dev_attr_in1_min);
>  device_create_file(&new_client->dev, &dev_attr_in2_min);
>  device_create_file(&new_client->dev, &dev_attr_in3_min);
> - device_create_file(&new_client->dev, &dev_attr_in4_min);
>  device_create_file(&new_client->dev, &dev_attr_in0_max);
>  device_create_file(&new_client->dev, &dev_attr_in1_max);
>  device_create_file(&new_client->dev, &dev_attr_in2_max);
>  device_create_file(&new_client->dev, &dev_attr_in3_max);
> - device_create_file(&new_client->dev, &dev_attr_in4_max);
>  device_create_file(&new_client->dev, &dev_attr_temp1_input);
>  device_create_file(&new_client->dev, &dev_attr_temp2_input);
>  device_create_file(&new_client->dev, &dev_attr_temp3_input);
> @@ -1224,6 +1231,15 @@
>  device_create_file(&new_client->dev, &dev_attr_temp2_auto_temp_crit);
>  device_create_file(&new_client->dev, &dev_attr_temp3_auto_temp_crit);
>
> + /* The ADT7463 has an optional VRM 10 mode where pin 21 is used
> +    as a sixth digital VID input rather than an analog input. */
> + data->vid = lm85_read_value(new_client, LM85_REG_VID);
> + if (!(kind = adt7463 && (data->vid & 0x80))) {
> + device_create_file(&new_client->dev, &dev_attr_in4_input);
> + device_create_file(&new_client->dev, &dev_attr_in4_min);
> + device_create_file(&new_client->dev, &dev_attr_in4_max);
> + }
> +
>  return 0;
>
>  /* Error out and cleanup code */
> @@ -1382,11 +1398,18 @@
>     irrelevant. So it is left in 4*/
>  data->adc_scale = (data->type = emc6d102 ) ? 16 : 4;
>
> - for (i = 0; i <= 4; ++i) {
> + data->vid = lm85_read_value(client, LM85_REG_VID);
> +
> + for (i = 0; i <= 3; ++i) {
>  data->in[i] >      lm85_read_value(client, LM85_REG_IN(i));
>  }
>
> + if (!(data->type = adt7463 && (data->vid & 0x80))) {
> + data->in[4] = lm85_read_value(client,
> +       LM85_REG_IN(4));
> + }
> +
>  for (i = 0; i <= 3; ++i) {
>  data->fan[i] >      lm85_read_value(client, LM85_REG_FAN(i));
> @@ -1450,13 +1473,20 @@
>  /* Things that don't change often */
>  dev_dbg(&client->dev, "Reading config values\n");
>
> - for (i = 0; i <= 4; ++i) {
> + for (i = 0; i <= 3; ++i) {
>  data->in_min[i] >      lm85_read_value(client, LM85_REG_IN_MIN(i));
>  data->in_max[i] >      lm85_read_value(client, LM85_REG_IN_MAX(i));
>  }
>
> + if (!(data->type = adt7463 && (data->vid & 0x80))) {
> + data->in_min[4] = lm85_read_value(client,
> +   LM85_REG_IN_MIN(4));
> + data->in_max[4] = lm85_read_value(client,
> +   LM85_REG_IN_MAX(4));
> + }
> +
>  if ( data->type = emc6d100 ) {
>  for (i = 5; i <= 7; ++i) {
>  data->in_min[i] > @@ -1477,8 +1507,6 @@
>  data->temp_max[i] >      lm85_read_value(client, LM85_REG_TEMP_MAX(i));
>  }
> -
> - data->vid = lm85_read_value(client, LM85_REG_VID);
>
>  for (i = 0; i <= 2; ++i) {
>  int val ;
>
>
> -- 
> Jean Delvare
>
> 


