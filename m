From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: adm1026 driver port for kernel 2.6.X
Message-Id: <jIpsQAXg.1098180583.3127540.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041018210758.GB14960@penguincomputing.com>
In-Reply-To: <20041018210758.GB14960@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Justin,

See my comments inline.

>    CHANGELOG
>
>    2003-03-13   Initial development
>    2003-05-07   First Release.  Includes GPIO fixup and full
>                 functionality.
>    2003-05-18   Minor fixups and tweaks.
>                 Print GPIO config after fixup.
>                 Adjust fan MIN if DIV changes.
>    2003-05-21   Fix printing of FAN/GPIO config
>                 Fix silly bug in fan_div logic
>                 Fix fan_min handling so that 0xff is 0 is 0xff
>    2003-05-25   Fix more silly typos...
>    2003-06-11   Change FAN_xx_REG macros to use different scaling
>                 Most (all?) drivers assume two pulses per rev fans
>                 and the old scaling was producing double the RPM's
>                 Thanks to Jerome Hsiao @ Arima for pointing this out.
>    2004-01-27   Remove use of temporary ID.  Define addresses as a range.
>    2004-10-18   Port to kernel 2.6.X and sysfs interface.

Delete the changelog, it doesn't belong to the 2.6 driver file.

>/* Insmod parameters */
>/* Insmod parameters */

Duplicate comment.

>/* The ADM1026 registers */
>#define ADM1026_REG_CONFIG1  (0x00)
>#define CFG1_MONITOR     (0x01)
>#define CFG1_INT_ENABLE  (0x02)
>#define CFG1_INT_CLEAR   (0x04)
>#define CFG1_AIN8_9      (0x08)
>#define CFG1_THERM_HOT   (0x10)
>#define CFG1_DAC_AFC     (0x20)
>#define CFG1_PWM_AFC     (0x40)
>#define CFG1_RESET       (0x80)
>#define ADM1026_REG_CONFIG2  (0x01)
>/* CONFIG2 controls FAN0/GPIO0 through FAN7/GPIO7 */
>#define ADM1026_REG_CONFIG3  (0x07)
>#define CFG3_GPIO16_ENABLE  (0x01)
>#define CFG3_CI_CLEAR  (0x02)
>#define CFG3_VREF_250  (0x04)
>#define CFG3_GPIO16_DIR  (0x40)
>#define CFG3_GPIO16_POL  (0x80)
>#define ADM1026_REG_E2CONFIG  (0x13)
>#define E2CFG_READ  (0x01)
>#define E2CFG_WRITE  (0x02)
>#define E2CFG_ERASE  (0x04)
>#define E2CFG_ROM  (0x08)
>#define E2CFG_CLK_EXT  (0x80)

Please discard the surrounding parenthesis.

>static u16 REG_IN[] = {
>		0x30, 0x31, 0x32, 0x33, 0x34, 0x35,
>		0x36, 0x37, 0x27, 0x29, 0x26, 0x2a,
>		0x2b, 0x2c, 0x2d, 0x2e, 0x2f
>	};
>static u16 REG_IN_MIN[] = {
>		0x58, 0x59, 0x5a, 0x5b, 0x5c, 0x5d,
>		0x5e, 0x5f, 0x6d, 0x49, 0x6b, 0x4a,
>		0x4b, 0x4c, 0x4d, 0x4e, 0x4f
>	};
>static u16 REG_IN_MAX[] = {
>		0x50, 0x51, 0x52, 0x53, 0x54, 0x55,
>		0x56, 0x57, 0x6c, 0x41, 0x6a, 0x42,
>		0x43, 0x44, 0x45, 0x46, 0x47
>	};
>#define ADM1026_REG_IN(nr) (REG_IN[(nr)])
>#define ADM1026_REG_IN_MIN(nr) (REG_IN_MIN[(nr)])
>#define ADM1026_REG_IN_MAX(nr) (REG_IN_MAX[(nr)])

The macros are useless. What about renaming the arrays to e.g.
ADM1026_REG_IN and simply use ADM1026_REG_IN[i] in the code?

>static u16 REG_TEMP[] = { 0x1f, 0x28, 0x29 };
>static u16 REG_TEMP_MIN[] = { 0x69, 0x48, 0x49 };
>static u16 REG_TEMP_MAX[] = { 0x68, 0x40, 0x41 };
>static u16 REG_TEMP_TMIN[] = { 0x10, 0x11, 0x12 };
>static u16 REG_TEMP_THERM[] = { 0x0d, 0x0e, 0x0f };
>static u16 REG_TEMP_OFFSET[] = { 0x1e, 0x6e, 0x6f };
>#define ADM1026_REG_TEMP(nr) (REG_TEMP[(nr)])
>#define ADM1026_REG_TEMP_MIN(nr) (REG_TEMP_MIN[(nr)])
>#define ADM1026_REG_TEMP_MAX(nr) (REG_TEMP_MAX[(nr)])
>#define ADM1026_REG_TEMP_TMIN(nr) (REG_TEMP_TMIN[(nr)])
>#define ADM1026_REG_TEMP_THERM(nr) (REG_TEMP_THERM[(nr)])
>#define ADM1026_REG_TEMP_OFFSET(nr) (REG_TEMP_OFFSET[(nr)])

Ditto.

>#define ADM1026_REG_FAN_DIV_0_3 (0x02)
>#define ADM1026_REG_FAN_DIV_4_7 (0x03)
>
>#define ADM1026_REG_DAC  (0x04)
>#define ADM1026_REG_PWM  (0x05)
>
>#define ADM1026_REG_GPIO_CFG_0_3 (0x08)
>#define ADM1026_REG_GPIO_CFG_4_7 (0x09)
>#define ADM1026_REG_GPIO_CFG_8_11 (0x0a)
>#define ADM1026_REG_GPIO_CFG_12_15 (0x0b)
>/* CFG_16 in REG_CFG3 */
>#define ADM1026_REG_GPIO_STATUS_0_7 (0x24)
>#define ADM1026_REG_GPIO_STATUS_8_15 (0x25)
>/* STATUS_16 in REG_STATUS4 */
>#define ADM1026_REG_GPIO_MASK_0_7 (0x1c)
>#define ADM1026_REG_GPIO_MASK_8_15 (0x1d)
>/* MASK_16 in REG_MASK4 */

Drop all parenthesis here as well.

>/* IN are scaled acording to built-in resistors.  These are the
> *   voltages corresponding to 3/4 of full scale (192 or 0xc0)
> *   NOTE: The -12V input needs an additional factor to account
> *      for the Vref pullup resistor.
> *      NEG12_OFFSET = SCALE * Vref / V-192 - Vref
> *                   = 13875 * 2.50 / 1.875 - 2500
> *                   = 16000
> */
>#if 1
>/* The values in this table are based on Table II, page 15 of the
> *    datasheet.
> */
>static int adm1026_scaling[] = {  /* .001 Volts */
>		2250, 2250, 2250, 2250, 2250, 2250,
>		1875, 1875, 1875, 1875, 3000, 3330,
>		3330, 4995, 2250, 12000, 13875
>	};
>#define NEG12_OFFSET  16000
>#else
>/* The values in this table are based on the resistors in
> *    Figure 5 on page 16.  But the 3.3V inputs are not in
> *    the figure and the values for the 5V input are wrong.
> *    For 5V, I'm guessing that R2 at 55.2k is right, but
> *    the total resistance should be 1400 or 1449 like the
> *    other inputs.  Using 1449, gives 4.922V at 192.
> */
>static int adm1026_scaling[] = {  /* .001 Volts */
>		2249, 2249, 2249, 2249, 2249, 2249,
>		1875, 1875, 1875, 1875, 3329, 3329,
>		3329, 4922, 2249, 11969, 13889
>	};
>#define NEG12_OFFSET  16019
>#endif

If the resistors are built-in, only one of these series is correct,
right? So, just discard the wrong one and go with the right one.

>#if 0   /* If we have extended A/D bits */
>#define INSEXT_FROM_REG(n,val,ext) (SCALE((val)*4 + (ext),192*4,\
>	adm1026_scaling[n]))
>#define INS_FROM_REG(n,val) (INSEXT_FROM_REG(n,val,0))
>#else
>#define INS_FROM_REG(n,val) (SCALE(val,192,adm1026_scaling[n]))
>#endif

Same here. People are not supposed to edit the source code and recompile.
Do the right thing and discard the rest.

>#define DIV_TO_REG(val) ((val)>=8 ? 3 : (val)>=4 ? 2 : (val)>=2 ? 1 : 0)

In 2.6 we handle bad dividers differently. Instead of defaulting to an
arbitrary value, we refuse to do the change and return an error to
userspace. See the various other drivers as an example.

>/* Temperature is reported in 1 degC increments */
>#define TEMP_TO_REG(val) (SENSORS_LIMIT((val+500)/1000,-127,127))
>#define TEMP_FROM_REG(val) (val * 1000)
>#define OFFSET_TO_REG(val) (SENSORS_LIMIT((val+500)/1000,-127,127))
>#define OFFSET_FROM_REG(val) (val * 1000)

Broken roundings for negative values in TO_REG variants.
Missing parenthesis for the FROM_REG variants.

>/* Analog output is a voltage, but it's used like a PWM
> *   Seems like this should be scaled, but to be consistent
> *   with other drivers, we do it this way.
> */
>#define DAC_TO_REG(val) (SENSORS_LIMIT(val,0,255))
>#define DAC_FROM_REG(val) (val)

Analog output should be a voltage value in mV, just like analog inputs.

>/* sensors_vid.h defines vid_from_reg() */
>#define VID_FROM_REG(val,vrm) (vid_from_reg(val,vrm))

What a totally useless macro!

>/* Unlike some other drivers we DO NOT set initial limits.  Use
> * the config file to set limits.
> */

Discard that comment, since all other driver have been changed and do not
set limits either.

>/* Typically used with systems using a v9.1 VRM spec ? */
>#define ADM1026_INIT_VRM  91
>#define ADM1026_INIT_VID  -1

Rudolf Marek introduced a new VRM detection mechanism recently. It picks
the correct VRM version from the CPU, so the driver don't have to deal
with that. See any driver with VID support (except lm78) from 2.6.9-rc1
or above (I think) for an example.

>struct pwm_data {
>	u8 pwm;
>	u8 enable;
>	u8 auto_pwm_min;
>};

Any special reason why pwm has a special structure?

>struct adm1026_data {
>	struct semaphore lock;
>	enum chips type;
>
>	struct semaphore update_lock;
>	int valid;		/* !=0 if following fields are valid */
>	unsigned long last_reading;	/* In jiffies */
>	unsigned long last_config;	/* In jiffies */
>
>	u8 in[17];              /* Register value */
>	u8 in_max[17];          /* Register value */
>	u8 in_min[17];          /* Register value */
>	s8 temp[3];             /* Register value */
>	s8 temp_min[3];         /* Register value */
>	s8 temp_max[3];         /* Register value */
>	s8 temp_tmin[3];        /* Register value */
>	s8 temp_therm[3];       /* Register value */
>	s8 temp_offset[3];      /* Register value */
>	u8 fan[8];              /* Register value */
>	u8 fan_min[8];          /* Register value */
>	u8 fan_div[8];          /* Decoded value */
>	struct pwm_data pwm[2]; /* Pwm control values */
>	int vid;                /* Decoded value */
>	u8 vrm;                 /* VRM version */
>	long alarms;            /* Register encoding, combined */
>	long alarm_mask;        /* Register encoding, combined */
>	long gpio;              /* Register encoding, combined */
>	long gpio_mask;         /* Register encoding, combined */
>	u8 gpio_config[17];     /* Decoded value */
>	u8 config1;             /* Register value */
>	u8 config2;             /* Register value */
>	u8 config3;             /* Register value */
>};

There should be an i2c_client member in there, see other chip drivers.

>static struct i2c_driver adm1026_driver = {
>	.owner          = THIS_MODULE,
>	.name           = "adm1026",
>/*	.id             = I2C_DRIVERID_ADM1026,  */
>	.flags          = I2C_DF_NOTIFY,
>	.attach_adapter = adm1026_attach_adapter,
>	.detach_client  = adm1026_detach_client,
>};

Don't include the .id line at all.

>/* Unique ID assigned to each ADM1026 detected */
>static int adm1026_id = 0;

Don't explicitely initialize it to 0, the compiler will do.

>int adm1026_attach_adapter(struct i2c_adapter *adapter)
>{
>        if (!(adapter->class & I2C_ADAP_CLASS_SMBUS)) {
>                return 0;

Indentation issue here.

>void adm1026_init_client(struct i2c_client *client)
>{
>	int value, i;
>	struct adm1026_data *data = i2c_get_clientdata(client);
>
>	dev_dbg(&client->dev, "adm1026(%d): Initializing device\n",
>		client->id);

dev_dbg will already print "adm1026" in front of the line if I'm not
mistaking, so you shouldn't repeat it.

>	/* If the user asks us to reprogram the GPIO config, then
>	 *   do it now.  But only if this is the first ADM1026.
>	 */
>	if( client->id = 0

Why is the first client special? You don't even know which one will be
picked first by the core.

>	for( i = 0 ; i <= 7 ; ++i ) {

BTW, watch your coding style. No white space inside parenthesis, white
space betweem keywork and opening parenthesis, no white space before
semicolon: for (i = 0; i <= 7; ++i).

>	/* We don't know where or even _if_ the VID might be on the GPIO
>	 *    pins.  But the datasheet gives an example config showing
>	 *    GPIO11-15 being used to monitor VID0-4, so we go with that
>	 *    but make the vid WRITEABLE so if it's wrong, the user can
>	 *    set it in /etc/sensors.conf perhaps using an expression or
>	 *    0 to trigger a re-read from the GPIO pins.
>	 */

Doesn't make much sense to me. If the vid reading isnt't correct (which
can happen with any chip if the pins are not provided) then the user can
simply not use in in the configuration file at all. Making it writable
means that the user-space writes it to kernel-space just in order to
read it again for configuring the chip. Since the vid value is only
really used by "sensors -s", hardcoding it into the configuration file
is easier and more efficiemt.

>static ssize_t show_in(struct device *dev, char *buf, int nr)
>{
>	struct adm1026_data *data = adm1026_update_device(dev);
>	if (nr = 16) {
>		return sprintf(buf,"%d\n", INS_FROM_REG(nr, data->in[nr]) -
>			NEG12_OFFSET );
>	} else {
>		return sprintf(buf,"%d\n", INS_FROM_REG(nr, data->in[nr]) );
>	}
>}
>static ssize_t show_in_min(struct device *dev, char *buf, int nr)
>{
>	struct adm1026_data *data = adm1026_update_device(dev);
>	if (nr = 16) {
>		return sprintf(buf,"%d\n", INS_FROM_REG(nr, data->in_min[nr])
>			- NEG12_OFFSET );
>	} else {
>		return sprintf(buf,"%d\n", INS_FROM_REG(nr,
>			data->in_min[nr])); }
>}
>static ssize_t set_in_min(struct device *dev, const char *buf,
>		size_t count, int nr)
>{
>	struct i2c_client *client = to_i2c_client(dev);
>	struct adm1026_data *data = i2c_get_clientdata(client);
>	int     val;
>
>	down(&data->update_lock);
>	val = simple_strtol(buf, NULL, 10);
>	if (nr = 16) {
>		data->in_min[nr] = INS_TO_REG(nr, val + NEG12_OFFSET);
>	} else {
>		data->in_min[nr] = INS_TO_REG(nr, val);
>	}
>	adm1026_write_value(client, ADM1026_REG_IN_MIN(nr), data->in_min[nr]);
>	up(&data->update_lock);
>	return count;
>}
>
>static ssize_t show_in_max(struct device *dev, char *buf, int nr)
>{
>	struct adm1026_data *data = adm1026_update_device(dev);
>	if (nr = 16) {
>		return sprintf(buf,"%d\n", INS_FROM_REG(nr, data->in_max[nr])
>			- NEG12_OFFSET );
>	} else {
>		return sprintf(buf,"%d\n", INS_FROM_REG(nr,
>			data->in_max[nr]));
>	}
>}
>static ssize_t set_in_max(struct device *dev, const char *buf,
>		size_t count, int nr)
>{
>	struct i2c_client *client = to_i2c_client(dev);
>	struct adm1026_data *data = i2c_get_clientdata(client);
>	int     val;
>
>	down(&data->update_lock);
>	val = simple_strtol(buf, NULL, 10);
>	if (nr = 16) {
>		data->in_max[nr] = INS_TO_REG(nr, val+NEG12_OFFSET);
>	} else {
>		data->in_max[nr] = INS_TO_REG(nr, val);
>	}
>	adm1026_write_value(client, ADM1026_REG_IN_MAX(nr), data->in_max[nr]);
>	up(&data->update_lock);
>	return count;
>}

Write specific callback functions for -12V since it is specific.

>static ssize_t set_fan_min(struct device *dev, const char *buf,
>		size_t count, int nr)
>{
>	struct i2c_client *client = to_i2c_client(dev);
>	struct adm1026_data *data = i2c_get_clientdata(client);
>	int     val;
>
>	down(&data->update_lock);
>	val = simple_strtol(buf, NULL, 10);
>	data->fan_min[nr] = FAN_TO_REG(val, data->fan_div[nr]);
>	adm1026_write_value(client, ADM1026_REG_FAN_MIN(nr),
>		data->fan_min[nr]);
>	up(&data->update_lock);
>	return count;
>}

I see no reason to use the update_lock semaphore here. Other I2C client
drivers don't.

>/* static ssize_t show_analog_out_reg(struct device *dev, char *buf)
>{
>	struct adm1026_data *data = adm1026_update_device(dev);
>	return sprintf(buf,"%d\n", DAC_FROM_REG(data->analog_out) );
>}
>static ssize_t set_analog_out_reg(struct device *dev, const char *buf,
>		size_t count)
>{
>	struct i2c_client *client = to_i2c_client(dev);
>	struct adm1026_data *data = i2c_get_clientdata(client);
>	int     val;
>
>	down(&data->update_lock);
>	val = simple_strtol(buf, NULL, 10);
>	data->analog_out = DAC_TO_REG(val);
>	adm1026_write_value(client, ADM1026_REG_DAC, data->analog_out);
>	up(&data->update_lock);
>	return count;
>}
>
>static DEVICE_ATTR(analog_out, S_IRUGO | S_IWUSR, show_analog_out_reg,
>	set_analog_out_reg)
>
>*/

Why is that part commented out?

>int adm1026_detect(struct i2c_adapter *adapter, int address,
>		int kind)
>{
> (...)
>	if (i2c_is_isa_adapter(adapter)) {
>		/* This chip has no ISA interface */
>		goto exit ;
>	};

Discard that test, it's useless

>	if (!(new_client = kmalloc((sizeof(struct i2c_client)) +
>				    sizeof(struct adm1026_data),
>				    GFP_KERNEL))) {
>		err = -ENOMEM;
>		goto exit;
>	}
>
>	memset(new_client, 0, sizeof(struct i2c_client) +
>			      sizeof(struct adm1026_data));
>	data = (struct adm1026_data *) (new_client + 1);

This memory allocation scheme is outdated. I'm surprised that the code
you started from has that, since all driver in CVS and 2.6 are supposed
to be fixed for a couple months now. See in the other drivers how it is
done now.
>#if 0
>	/* Example of another adm1026 "compatible" device */
>	case adx1000 :
>		type_name = "adx1000";
>                memcpy( template, adx_specific, sizeof(adx_specific) );
>                template_next = template + CTLTBL_ADX1000 ;
>		break ;
>#endif

That code wouldn't work in 2.6 I guess, looks like a legacy from the 2.4
driver; discard.

>	/* Set the VRM version */
>	data->vrm = ADM1026_INIT_VRM ;
>	data->vid = ADM1026_INIT_VID ;

Use Rudolf Marek's functions instead.

>	device_create_file(&new_client->dev, &dev_attr_temp1_offset);
>	device_create_file(&new_client->dev, &dev_attr_temp2_offset);
>	device_create_file(&new_client->dev, &dev_attr_temp3_offset);

These are not standardized in the sysfs interface yet. It seems that
several chips have that functionality though, so it could be fine to
introduce it. Please propose a patch against
Documentation/i2c/sysfs-interface if you use these.

>	device_create_file(&new_client->dev, &dev_attr_temp1_therm);
>	device_create_file(&new_client->dev, &dev_attr_temp2_therm);
>	device_create_file(&new_client->dev, &dev_attr_temp3_therm);

What are these files for?

I have admittedly skipped through most of the sysfs callback functions
code, since I don't have enough time to fully review this part.

Please provide patches for the CVS/2.4 driver when changes you do to the
2.6 driver would be welcome there too.

Thanks,
Jean Delvare
