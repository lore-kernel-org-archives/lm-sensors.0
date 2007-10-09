From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 09 Oct 2007 08:43:46 +0000
Subject: Re: [lm-sensors] PATCH: hwmon-fschmd-new-driver-v2.patch
Message-Id: <20071009104346.72ac81de@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <470A0F98.5070400@hhs.nl>
In-Reply-To: <470A0F98.5070400@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Tue, 09 Oct 2007 09:22:09 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > Hi Hans,
> > 
> > On Mon, 08 Oct 2007 13:08:08 +0200, Hans de Goede wrote:
> >> This patch adds a new merged driver for FSC sensor chips, it merges the fscher
> >> and fscpos drivers and adds support for the FSC Scylla, Heracles and Heimdall
> >> chips.
> >>
> >> This version of the patch has had all issues found during the review by Jean
> >> Delvare addressed:
> >> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-October/021396.html
> >>
> >> Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>
> >>
> >> Jean, can you please ack this one?
> > 
> > Can't ack it as there's one bug remaining :/ And I have a few
> > suggestions for improvements as well.
> > 
> >> +static ssize_t store_alert_led(struct device *dev,
> >> +	struct device_attribute *devattr, const char *buf, size_t count)
> >> +{
> >> +	u8 reg;
> >> +	struct fschmd_data *data = dev_get_drvdata(dev);
> >> +	unsigned long v = simple_strtoul(buf, NULL, 10);
> >> +
> >> +	mutex_lock(&data->update_lock);
> >> +
> >> +	reg = i2c_smbus_read_byte_data(&data->client, FSCHMD_REG_CONTROL);
> >> +
> >> +	if (v)
> >> +		reg |= FSCHMD_CONTROL_ALERT_LED_MASK;
> >> +	else
> >> +		reg &= ~FSCHMD_CONTROL_ALERT_LED_MASK;
> >> +
> >> +	i2c_smbus_write_byte_data(&data->client, FSCHMD_REG_CONTROL, v);
> > 
> > You want to write "reg" here, not "v".
> 
> Good catch (caused by the do not use update_device changes).

Actually not, the first version of the driver had the same bug, but I
didn't see it during my review.

> >> +static int fschmd_detect(struct i2c_adapter *adapter, int address, int kind)
> >> +{
> >> (...)
> >> +	for (i = 0; i < ARRAY_SIZE(fschmd_attr); i++) {
> >> +		err = device_create_file(&client->dev,
> >> +					&fschmd_attr[i].dev_attr);
> >> +		if (err)
> >> +			goto exit_detach;
> >> +	}
> >> +
> >> +	for (i = 0; i < (FSCHMD_NO_TEMP_SENSORS[data->kind] * 4); i++) {
> > 
> > Why don't you just use ARRAY_SIZE()? Less likely to break with future
> > changes.
> 
> Because the array contains attributes for the maximum number of temp sensors 
> and not all models have the maximum number, hence 
> FSCHMD_NO_TEMP_SENSORS[data->kind] gets used, I agree this isn't ideal.

Oops, completely right of course, sorry for the noise.

> > One more note: there's a lot of trailing whitespace in your driver. I
> > think Mark will strip it before committing your patch but it would be
> > easier for everyone if you could avoid trailing whitespace in future
> > patches.
> 
> Are there any tools for this? You've mentioned this before and I have tried to 
> avoid adding trailing whitespace while editing, but I guess that doesn't help much.

When using quilt, the refresh command as a --strip-trailing-whitespace
options which comes in handy. I have it enabled by default.

Other than that, if your text editor supports regexp-based file-wide
replacement, you can ask it to replace '\s+$' (or '[\t ]*$' if it
doesn't support perl-like syntax) with nothing.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
