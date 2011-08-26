From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 26 Aug 2011 13:51:39 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (pmbus/adm1275) Add support for
Message-Id: <20110826135139.GA30002@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1314324755-18514-2-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1314324755-18514-2-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Fri, Aug 26, 2011 at 07:15:52AM -0400, Jean Delvare wrote:
> Hi Guenter,
> 
> On Thu, 25 Aug 2011 19:12:34 -0700, Guenter Roeck wrote:
> > ADM1275 supports a second current limit, which can be configured as either lower
> > or upper limit. Add support for it and report it as either lower or upper
> > critical current limit.
> > 
> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > ---
> >  Documentation/hwmon/adm1275   |    8 ++++
> >  drivers/hwmon/pmbus/adm1275.c |   88 ++++++++++++++++++++++++++++++++++++++--
> >  2 files changed, 91 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Documentation/hwmon/adm1275 b/Documentation/hwmon/adm1275
> > index 097b3cc..c438c98 100644
> > --- a/Documentation/hwmon/adm1275
> > +++ b/Documentation/hwmon/adm1275
> > @@ -60,5 +60,13 @@ curr1_label		"iout1"
> >  curr1_input		Measured current. From READ_IOUT register.
> >  curr1_max		Maximum current. From IOUT_OC_WARN_LIMIT register.
> >  curr1_max_alarm		Current high alarm. From IOUT_OC_WARN_LIMIT register.
> > +curr1_lcrit		Critical minimum current. Depending on the chip
> > +			configuration, either curr1_lcrit or curr1_crit is
> > +			supported, but not both.
> > +curr1_lcrit_alarm	Critical current low alarm.
> > +curr1_crit		Critical maximum current. Depending on the chip
> > +			configuration, either curr1_lcrit or curr1_crit is
> > +			supported, but not both.
> > +curr1_crit_alarm	Critical current high alarm.
> >  curr1_highest		Historical maximum current.
> >  curr1_reset_history	Write any value to reset history.
> > diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
> > index c936e27..061e7e7 100644
> > --- a/drivers/hwmon/pmbus/adm1275.c
> > +++ b/drivers/hwmon/pmbus/adm1275.c
> > @@ -31,14 +31,44 @@
> >  #define ADM1275_VIN_VOUT_SELECT		(1 << 6)
> >  #define ADM1275_VRANGE			(1 << 5)
> >  
> > +#define ADM1275_IOUT_WARN2_LIMIT	0xd7
> > +#define ADM1275_DEVICE_CONFIG		0xd8
> > +
> > +#define ADM1275_IOUT_WARN2_SELECT	(1 << 4)
> > +
> > +#define	ADM1275_MFR_STATUS_IOUT_WARN2	(1 << 0)
> > +
> > +struct adm1275_data {
> > +	bool have_oc_fault;
> > +	struct pmbus_driver_info info;
> > +};
> > +
> > +#define to_adm1275_data(x)  container_of(x, struct adm1275_data, info)
> > +
> >  static int adm1275_read_word_data(struct i2c_client *client, int page, int reg)
> >  {
> > +	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
> > +	const struct adm1275_data *data = to_adm1275_data(info);
> >  	int ret;
> >  
> >  	if (page)
> >  		return -EINVAL;
> >  
> >  	switch (reg) {
> > +	case PMBUS_IOUT_UC_FAULT_LIMIT:
> > +		if (data->have_oc_fault) {
> > +			ret = -EINVAL;
> > +			break;
> > +		}
> > +		ret = pmbus_read_word_data(client, 0, ADM1275_IOUT_WARN2_LIMIT);
> > +		break;
> > +	case PMBUS_IOUT_OC_FAULT_LIMIT:
> > +		if (!data->have_oc_fault) {
> > +			ret = -EINVAL;
> > +			break;
> > +		}
> > +		ret = pmbus_read_word_data(client, 0, ADM1275_IOUT_WARN2_LIMIT);
> > +		break;
> 
> I am not familiar with the pmbus layer (is it documented anywhere?), is
> it possible for these errors to happen at all? I am a little surprised
> that you return errors here and not in adm1275_write_word_data below.
> But maybe it's OK.
> 
> If you really have to return these errors, then why do you return
> -EINVAL when other unsupported features get -ENODATA?
> 
Guess I'll need to document the logic here.

EINVAL:
	The calling code does not try to access the real register and returns the error
	to the caller. Not sure about EINVAL here; maybe I should return EIO.
ENODATA:
	There is no chip specific register to return this data, but there may be
	a standard register. The calling code tries to access the standard register.

> >  	case PMBUS_VIRT_READ_IOUT_MAX:
> >  		ret = pmbus_read_word_data(client, 0, ADM1275_PEAK_IOUT);
> >  		break;
> > @@ -69,6 +99,11 @@ static int adm1275_write_word_data(struct i2c_client *client, int page, int reg,
> >  		return -EINVAL;
> >  
> >  	switch (reg) {
> > +	case PMBUS_IOUT_UC_FAULT_LIMIT:
> > +	case PMBUS_IOUT_OC_FAULT_LIMIT:
> > +		ret = pmbus_write_word_data(client, 0, ADM1275_IOUT_WARN2_LIMIT,
> > +					    word);
> > +		break;
> >  	case PMBUS_VIRT_RESET_IOUT_HISTORY:
> >  		ret = pmbus_write_word_data(client, 0, ADM1275_PEAK_IOUT, 0);
> >  		break;
> > @@ -85,19 +120,49 @@ static int adm1275_write_word_data(struct i2c_client *client, int page, int reg,
> >  	return ret;
> >  }
> >  
> > +static int adm1275_read_byte_data(struct i2c_client *client, int page, int reg)
> > +{
> > +	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
> > +	const struct adm1275_data *data = to_adm1275_data(info);
> > +	int mfr_status, ret;
> 
> No check for "page" as you have in adm1275_read_word_data() and
> adm1275_write_word_data()?
> 
Oversight. I'll add it.

> > +
> > +	switch (reg) {
> > +	case PMBUS_STATUS_IOUT:
> > +		ret = pmbus_read_byte_data(client, page, PMBUS_STATUS_IOUT);
> > +		if (ret < 0)
> > +			break;
> > +		mfr_status = pmbus_read_byte_data(client, page,
> > +						  PMBUS_STATUS_MFR_SPECIFIC);
> > +		if (mfr_status < 0) {
> > +			ret = mfr_status;
> > +			break;
> > +		}
> > +		if (mfr_status & ADM1275_MFR_STATUS_IOUT_WARN2) {
> > +			ret |= data->have_oc_fault ?
> > +			  PB_IOUT_OC_FAULT : PB_IOUT_UC_FAULT;
> > +		}
> > +		break;
> > +	default:
> > +		ret = -ENODATA;
> > +		break;
> > +	}
> > +	return ret;
> > +}
> > +
> >  static int adm1275_probe(struct i2c_client *client,
> >  			 const struct i2c_device_id *id)
> >  {
> > -	int config;
> > +	int config, device_config;
> >  	int ret;
> >  	struct pmbus_driver_info *info;
> > +	struct adm1275_data *data;
> >  
> >  	if (!i2c_check_functionality(client->adapter,
> >  				     I2C_FUNC_SMBUS_READ_BYTE_DATA))
> >  		return -ENODEV;
> >  
> > -	info = kzalloc(sizeof(struct pmbus_driver_info), GFP_KERNEL);
> > -	if (!info)
> > +	data = kzalloc(sizeof(struct adm1275_data), GFP_KERNEL);
> > +	if (!data)
> >  		return -ENOMEM;
> >  
> >  	config = i2c_smbus_read_byte_data(client, ADM1275_PMON_CONFIG);
> > @@ -106,6 +171,14 @@ static int adm1275_probe(struct i2c_client *client,
> >  		goto err_mem;
> >  	}
> >  
> > +	device_config = i2c_smbus_read_byte_data(client, ADM1275_DEVICE_CONFIG);
> > +	if (device_config < 0) {
> > +		ret = device_config;
> > +		goto err_mem;
> > +	}
> > +
> > +	info = &data->info;
> > +
> >  	info->pages = 1;
> >  	info->format[PSC_VOLTAGE_IN] = direct;
> >  	info->format[PSC_VOLTAGE_OUT] = direct;
> > @@ -116,6 +189,7 @@ static int adm1275_probe(struct i2c_client *client,
> >  	info->func[0] = PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT;
> >  
> >  	info->read_word_data = adm1275_read_word_data;
> > +	info->read_byte_data = adm1275_read_byte_data;
> >  	info->write_word_data = adm1275_write_word_data;
> >  
> >  	if (config & ADM1275_VRANGE) {
> > @@ -134,6 +208,9 @@ static int adm1275_probe(struct i2c_client *client,
> >  		info->R[PSC_VOLTAGE_OUT] = -1;
> >  	}
> >  
> > +	if (device_config & ADM1275_IOUT_WARN2_SELECT)
> > +		data->have_oc_fault = true;
> > +
> >  	if (config & ADM1275_VIN_VOUT_SELECT)
> >  		info->func[0] |= PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
> >  	else
> > @@ -145,17 +222,18 @@ static int adm1275_probe(struct i2c_client *client,
> >  	return 0;
> >  
> >  err_mem:
> > -	kfree(info);
> > +	kfree(data);
> >  	return ret;
> >  }
> >  
> >  static int adm1275_remove(struct i2c_client *client)
> >  {
> >  	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
> > +	const struct adm1275_data *data = to_adm1275_data(info);
> >  	int ret;
> >  
> >  	ret = pmbus_do_remove(client);
> > -	kfree(info);
> > +	kfree(data);
> >  	return ret;
> >  }
> 
> Unrelated to this patch, but this error path seems wrong. If
> pmbus_do_remove() returns an error, then presumably the device is not
> actually removed. As you return the error value up to the caller, the
> device will not be considered unbound from its driver either. In these
> conditions, freeing the data structure doesn't seem right.
> 
> Thankfully it should never happen. It's even questionable why remove
> functions can return an error value at all...
> 
In practive pmbus_do_remove returns what all other driver remove functions do,
ie it always returns 0. But you are right, the path is wrong. I'll submit a separate
set of patches to address this - probably I'll make pmbus_do_remove a void function.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
