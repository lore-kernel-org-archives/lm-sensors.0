From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 13 Oct 2011 15:33:49 +0000
Subject: Re: [lm-sensors] [PATCH v2 2/2] hwmon: (coretemp) Add support for
Message-Id: <1318520029.3720.63.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1317162831-30628-3-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1317162831-30628-3-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2011-10-13 at 10:31 -0400, Jean Delvare wrote:
> Hi Guenter,
> 
> Sorry for the late reply...
> 
> On Tue, 27 Sep 2011 15:33:51 -0700, Guenter Roeck wrote:
> > Add support for T0 and T1 temperature thresholds using the new sysfs ABI
> > attributes tempX_thresholdY and tempX_thresholdY_triggered.
> > 
> > This patch is based on commit c814a4c7c4aad795835583344353963a0a673eb0, which
> > was reverted. For details on the threshold registers, see IA Manual vol 3A,
> > which can be downloaded from here:
> >         http://download.intel.com/design/processor/manuals/253668.pdf
> > 
> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > ---
> >  Documentation/hwmon/coretemp |   12 +++
> >  drivers/hwmon/coretemp.c     |  153 ++++++++++++++++++++++++++++++++++++++----
> >  2 files changed, 151 insertions(+), 14 deletions(-)
> 
> This works as designed, tested on both a Xeon E5520 and my Thinkpad
> laptop with a Core T2600. On the Thinkpad, I can see the values change
> in real time under load. The "triggered" files always read 0,
> presumably because the BIOS resets the bits to 0 when changing the
> threshold values.
> 
> Still, I am a little worried that:
> * We are adding a new interface but have no idea who is supposed to use
>   it (when the BIOS is not, that is) nor how. If user-space is supposed
>   to set the threshold values, how does it decide what happens when
>   they are crossed? Interrupts handlers would have to live in kernel
>   space. Do we want to add support for these thresholds to libsensors?
>   If so, how exactly, and how would applications (starting with
>   "sensors") expose them?
> * The coretemp implementation itself is strange, as we don't even know
>   what kind of interrupt is generated on threshold crossing. My
>   experiments with my laptop suggests these are SMI, but that may not
>   always be the case, I just don't know. If they are SMI then it's up
>   to the BIOS to decide, in which case we have no idea what the actions
>   will be. If they are not SMI, then what are they?
> 
> Without answer to these questions, it doesn't seem reasonable to push
> this upstream. And I am still unsure why this would be handled by hwmon
> drivers rather than CPU power / thermal management code. Don't get me
> wrong, I am not trying to push back the code. Simply I would like to
> know where we are going before we accept it.
> 
I think we both have the same questions/concerns. Interrupts are
handled, as far as I can see, in the thermal code. It may make more
sense to put the threshold values there as well.

> Meanwhile, I have some minor comments below if you are interested. It
> might not be worth spending time on this until the above points are
> answered though.
> 
I'll look through it.

> > diff --git a/Documentation/hwmon/coretemp b/Documentation/hwmon/coretemp
> > index 84d46c0..d9f09fc 100644
> > --- a/Documentation/hwmon/coretemp
> > +++ b/Documentation/hwmon/coretemp
> > @@ -35,6 +35,18 @@ the Out-Of-Spec bit. Following table summarizes the exported sysfs files:
> >  All Sysfs entries are named with their core_id (represented here by 'X').
> >  tempX_input	 - Core temperature (in millidegrees Celsius).
> >  tempX_max	 - All cooling devices should be turned on (on Core2).
> > +tempX_threshold1 - Reflects value of CPU thermal threshold T0.
> > +tempX_threshold1_triggered
> > +		 - A value of 1 indicates that T0 was crossed from either
> > +		   direction. Reflects value of CPU thermal status register
> > +		   bit 7 (THERM_LOG_THRESHOLD0).
> > +		   Value is reset by writing 0 into the file.
> > +tempX_threshold2 - Reflects value of CPU thermal threshold T1.
> > +tempX_threshold2_triggered
> > +		 - A value of 1 indicates that T1 was crossed from either
> > +		   direction. Reflects value of CPU thermal status register
> > +		   bit 9 (THERM_LOG_THRESHOLD1).
> > +		   Value is reset by writing 0 into the file.
> 
> FWIW, the Intel datasheet numbers the thresholds #1 and #2. I have no
> idea why Durgadoss decided to go with 0 and 1.
> 
> >  tempX_crit	 - Maximum junction temperature (in millidegrees Celsius).
> >  tempX_crit_alarm - Set when Out-of-spec bit is set, never clears.
> >  		   Correct CPU operation is no longer guaranteed.
> > diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> > index 44b2391..b0cb454 100644
> > --- a/drivers/hwmon/coretemp.c
> > +++ b/drivers/hwmon/coretemp.c
> > @@ -52,9 +52,10 @@ MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius");
> >  
> >  #define BASE_SYSFS_ATTR_NO	2	/* Sysfs Base attr no for coretemp */
> >  #define NUM_REAL_CORES		16	/* Number of Real cores per cpu */
> > -#define CORETEMP_NAME_LENGTH	17	/* String Length of attrs */
> > -#define MAX_CORE_ATTRS		4	/* Maximum no of basic attrs */
> > -#define TOTAL_ATTRS		(MAX_CORE_ATTRS + 1)
> > +#define CORETEMP_NAME_LENGTH	33	/* String Length of attrs */
> 
> Curious where the 33 comes from... My own computations suggest 28
> should be enough.
> 
I don't remember. Too long ago ... maybe I just wanted to play it safe.
But even then 32 would be a better length.

Guenter

> > +#define MAX_CORE_ATTRS		5	/* Maximum no of basic attrs */
> > +#define MAX_THRESH_ATTRS	4	/* Maximum no of threshold attrs */
> > +#define TOTAL_ATTRS		(MAX_CORE_ATTRS + MAX_THRESH_ATTRS)
> >  #define MAX_CORE_DATA		(NUM_REAL_CORES + BASE_SYSFS_ATTR_NO)
> >  
> >  #ifdef CONFIG_SMP
> > @@ -77,6 +78,8 @@ MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius");
> 
> > (...)
> > @@ -150,7 +154,7 @@ static ssize_t show_crit_alarm(struct device *dev,
> >  static ssize_t show_tjmax(struct device *dev,
> >  			struct device_attribute *devattr, char *buf)
> >  {
> > -	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> > +	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
> >  	struct platform_data *pdata = dev_get_drvdata(dev);
> >  
> >  	return sprintf(buf, "%d\n", pdata->core_data[attr->index]->tjmax);
> > @@ -159,12 +163,98 @@ static ssize_t show_tjmax(struct device *dev,
> >  static ssize_t show_ttarget(struct device *dev,
> >  				struct device_attribute *devattr, char *buf)
> >  {
> > -	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> > +	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
> >  	struct platform_data *pdata = dev_get_drvdata(dev);
> >  
> >  	return sprintf(buf, "%d\n", pdata->core_data[attr->index]->ttarget);
> >  }
> >  
> > +static const u32 thresh_log_mask[2] = {
> > +		THERM_LOG_THRESHOLD0, THERM_LOG_THRESHOLD1 };
> > +
> > +static ssize_t show_thresh_triggered(struct device *dev,
> > +				     struct device_attribute *devattr,
> > +				     char *buf)
> > +{
> > +	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
> > +	struct platform_data *pdata = dev_get_drvdata(dev);
> > +	struct temp_data *tdata = pdata->core_data[attr->index];
> > +	u32 eax, edx;
> > +
> > +	rdmsr_on_cpu(tdata->cpu, tdata->status_reg, &eax, &edx);
> > +
> > +	return sprintf(buf, "%d\n", !!(eax & thresh_log_mask[attr->nr]));
> > +}
> > +
> > +static ssize_t store_thresh_triggered(struct device *dev,
> > +				      struct device_attribute *devattr,
> > +				      const char *buf, size_t count)
> > +{
> > +	struct platform_data *pdata = dev_get_drvdata(dev);
> > +	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
> 
> Nitpicking: for consistency with the other callback functions, I'd put
> this line first (same for the two following functions.)
> 
> > +	struct temp_data *tdata = pdata->core_data[attr->index];
> > +	u32 mask = thresh_log_mask[attr->nr];
> > +	u32 eax, edx;
> > +	unsigned long val;
> > +
> > +	if (strict_strtoul(buf, 10, &val) || val != 0)
> > +		return -EINVAL;
> > +
> > +	rdmsr_on_cpu(tdata->cpu, tdata->status_reg, &eax, &edx);
> > +	if (eax & mask)
> 
> I wouldn't bother with this test. If the user (root) asks for a write,
> just write. The user isn't supposed to write 0 to this file randomly,
> so odds are that the test will always succeed. As a matter of fact, you
> don't do any equality test when writing the threshold value itself.
> 
> > +		wrmsr_on_cpu(tdata->cpu, tdata->status_reg, eax & ~mask, edx);
> > +	return count;
> > +}
> > +
> > +static const u32 thresh_mask[2] = {
> > +		THERM_MASK_THRESHOLD0, THERM_MASK_THRESHOLD1 };
> > +static const u32 thresh_shift[2] = {
> > +		THERM_SHIFT_THRESHOLD0, THERM_SHIFT_THRESHOLD1 };
> 
> u32 for a shift value seems odd, unsigned int would be more natural, or
> u8 if you really want to save space (but I don't think it makes much
> sense here.)
> 
> > +static ssize_t show_thresh(struct device *dev,
> > +			   struct device_attribute *devattr, char *buf)
> > +{
> > +	struct platform_data *pdata = dev_get_drvdata(dev);
> > +	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
> > +	struct temp_data *tdata = pdata->core_data[attr->index];
> > +	u32 eax, edx;
> > +	int thresh;
> > +	u32 mask = thresh_mask[attr->nr];
> > +	u32 shift = thresh_shift[attr->nr];
> 
> Nitpicking: ordering here (and below) is different from what you chose
> for store_thresh_triggered. Code is easier to read when order is
> consistent.
> 
> > +
> > +	rdmsr_on_cpu(tdata->cpu, tdata->intrpt_reg, &eax, &edx);
> > +	thresh = tdata->tjmax - ((eax & mask) >> shift) * 1000;
> > +	return sprintf(buf, "%d\n", thresh);
> > +}
> > +
> > +static ssize_t store_thresh(struct device *dev,
> > +			    struct device_attribute *devattr,
> > +			    const char *buf, size_t count)
> > +{
> > +	struct platform_data *pdata = dev_get_drvdata(dev);
> > +	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
> > +	struct temp_data *tdata = pdata->core_data[attr->index];
> > +	u32 eax, edx;
> > +	long val, diff;
> > +	u32 mask = thresh_mask[attr->nr];
> > +	u32 shift = thresh_shift[attr->nr];
> > +
> > +	if (strict_strtol(buf, 10, &val))
> > +		return -EINVAL;
> > +
> > +	diff = (tdata->tjmax - val) / 1000;
> > +	if (diff < 0 || diff > 127)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&tdata->update_lock);
> > +	rdmsr_on_cpu(tdata->cpu, tdata->intrpt_reg, &eax, &edx);
> > +	eax = (eax & ~mask) | (diff << shift);
> > +	wrmsr_on_cpu(tdata->cpu, tdata->intrpt_reg, eax, edx);
> > +	mutex_unlock(&tdata->update_lock);
> 
> Why do you need the mutex here, and not in store_thresh_triggered()?
> 
> > +
> > +	return count;
> > +}
> > (...)
> 



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
