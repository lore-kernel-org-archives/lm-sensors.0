From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sat, 21 Jan 2006 19:23:30 +0000
Subject: [lm-sensors] w83627ehf fan controll?
Message-Id: <43D28A32.5050602@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051230143805.GA21201@Apollo>
In-Reply-To: <20051230143805.GA21201@Apollo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Sorry for late response. I did some quick review of this code. Maybe Yuan can find it useful.

1) max and min regs are switched
2) code does not use sensor_dev_attr and uses old macro system
3) it contains some tweaks to force PWM (seems from Aurelian attempts to get his PWM working :)

I have a question now:

1) does anyone else has something to show?
2) does anyone has userspace voltage support?

I cant work much on this next moth (feb) busy with final exams. Well maybe I will - as brain relax subroutine :)

Yuan have you this on your own schedule?

Thanks,
Regards
Rudolf


> --- /usr/src/linux-2.6.14/drivers/hwmon/w83627ehf.c	2005-10-28 02:02:08.000000000 +0200
> +++ w83627ehf.c	2006-01-09 11:14:20.000000000 +0100
> @@ -30,7 +30,7 @@
>      Supports the following chips:
>  
>      Chip        #vin    #fan    #pwm    #temp   chip_id man_id
> -    w83627ehf   -       5       -       3       0x88    0x5ca3
> +    w83627ehf   10      5       -       3       0x88    0x5ca3
>  
>      This is a preliminary version of the driver, only supporting the
>      fan and temperature inputs. The chip does much more than that.
> @@ -114,6 +114,10 @@
>  #define W83627EHF_REG_CHIP_ID		0x49
>  #define W83627EHF_REG_MAN_ID		0x4F
>  
> +static const u16 W83627EHF_REG_IN[] = { 0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x550, 0x551, 0x552 };
> +static const u16 W83627EHF_REG_IN_MIN[] = { 0x2B, 0x2D, 0x2F, 0x31, 0x33, 0x35, 0x37, 0x554, 0x556, 0x558 };
> +static const u16 W83627EHF_REG_IN_MAX[] = { 0x2C, 0x2E, 0x30, 0x32, 0x34, 0x36, 0x38, 0x555, 0x557, 0x559 };
> +

Min and max are switched.

>  static const u16 W83627EHF_REG_FAN[] = { 0x28, 0x29, 0x2a, 0x3f, 0x553 };
>  static const u16 W83627EHF_REG_FAN_MIN[] = { 0x3b, 0x3c, 0x3d, 0x3e, 0x55c };
>  
> @@ -137,6 +141,22 @@
>   */
>  
>  static inline unsigned int
> +in_from_reg(u8 reg)
> +{
> +	return reg * 8;
> +}
> +
> +static inline u8
> +reg_from_in(int val)
> +{
> +	if (val < 0)
> +		return 0;
> +	if (val > 2040)
> +		return 255;
> +	return (val + 4) / 8;
> +}
> +
> +static inline unsigned int
>  fan_from_reg(u8 reg, unsigned int div)
>  {
>  	if (reg = 0 || reg = 255)
> @@ -182,6 +202,9 @@
>  	unsigned long last_updated;	/* In jiffies */
>  
>  	/* Register values */
> +	u8 in[10];		/* Register value */
> +	u8 in_max[10];		/* Register value */
> +	u8 in_min[10];		/* Register value */
>  	u8 fan[5];
>  	u8 fan_min[5];
>  	u8 fan_div[5];
> @@ -324,6 +347,16 @@
>  
>  	if (time_after(jiffies, data->last_updated + HZ)
>  	 || !data->valid) {
> +		/* Measured voltages and limits */
> +		for (i = 0; i < 10; i++) {
> +			data->in[i] = w83627ehf_read_value(client,
> +				      W83627EHF_REG_IN[i]);
> +			data->in_min[i] = w83627ehf_read_value(client,
> +				          W83627EHF_REG_IN_MIN[i]);
> +			data->in_max[i] = w83627ehf_read_value(client,
> +				          W83627EHF_REG_IN_MAX[i]);
Maybe one tab missing?
> +		}
> +
>  		/* Fan clock dividers */
>  		i = w83627ehf_read_value(client, W83627EHF_REG_FANDIV1);
>  		data->fan_div[0] = (i >> 4) & 0x03;
> @@ -402,6 +435,81 @@
>  /*
>   * Sysfs callback functions
>   */
> +#define show_in_reg(reg) \
> +static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
> +{ \
> +	struct w83627ehf_data *data = w83627ehf_update_device(dev); \
> +	return sprintf(buf,"%d\n", in_from_reg(data->reg[nr])); \
> +}
> +show_in_reg(in)
> +show_in_reg(in_min)
> +show_in_reg(in_max)
> +
> +#define store_in_reg(REG, reg) \
> +static ssize_t \
> +store_in_##reg (struct device *dev, const char *buf, size_t count, int nr) \
> +{ \
> +	struct i2c_client *client = to_i2c_client(dev); \
> +	struct w83627ehf_data *data = i2c_get_clientdata(client); \
> +	u32 val; \
> +	 \
> +	val = simple_strtoul(buf, NULL, 10); \
> +	 \
> +	down(&data->update_lock); \
> +	data->in_##reg[nr] = reg_from_in(val); \
> +	w83627ehf_write_value(client, W83627EHF_REG_IN_##REG[nr], \
> +			    data->in_##reg[nr]); \
> +	 \
> +	up(&data->update_lock); \

I think I have seen some patch that is changing this semaphore to mutexes.

> +	return count; \
> +}
> +store_in_reg(MIN, min)
> +store_in_reg(MAX, max)
> +	
> +#define sysfs_in_offset(offset) \
> +static ssize_t \
> +show_regs_in_##offset (struct device *dev, struct device_attribute *attr, char *buf) \
> +{ \
> +	return show_in(dev, buf, offset); \
> +} \
> +static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_regs_in_##offset, NULL);

Why this way?


What about this:

static struct sensor_device_attribute sda_in_input[] = {
	SENSOR_ATTR(in0_input, S_IRUGO, show_in, NULL, 0),
	SENSOR_ATTR(in1_input, S_IRUGO, show_in, NULL, 1),

and
static struct sensor_device_attribute sda_in_min[] = {
       SENSOR_ATTR(in0_min, S_IWUSR | S_IRUGO, show_in_min, store_in_min, 0),
       SENSOR_ATTR(in1_min, S_IWUSR | S_IRUGO, show_in_min, store_in_min, 1),
       SENSOR_ATTR(in2_min, S_IWUSR | S_IRUGO, show_in_min, store_in_min, 2),

/* following are the sysfs callback functions */
static ssize_t show_in(struct device *dev, struct device_attribute *attr,
                        char *buf)
{
        struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
        int nr = sensor_attr->index;
        struct w83792d_data *data = w83792d_update_device(dev);
        return sprintf(buf,"%ld\n", IN_FROM_REG(nr,(in_count_from_reg(nr, data))));
}
I think you get it :)

> +
> +#define sysfs_in_reg_offset(reg, offset) \
> +static ssize_t show_regs_in_##reg##offset (struct device *dev, struct device_attribute *attr, char *buf) \
> +{ \
> +	return show_in_##reg (dev, buf, offset); \
> +} \
> +static ssize_t \
> +store_regs_in_##reg##offset (struct device *dev, struct device_attribute *attr, \
> +			    const char *buf, size_t count) \
> +{ \
> +	return store_in_##reg (dev, buf, count, offset); \
> +} \
> +static DEVICE_ATTR(in##offset##_##reg, S_IRUGO | S_IWUSR, \
> +		  show_regs_in_##reg##offset, store_regs_in_##reg##offset);
> +
> +#define sysfs_in_offsets(offset) \
> +sysfs_in_offset(offset) \
> +sysfs_in_reg_offset(min, offset) \
> +sysfs_in_reg_offset(max, offset)
> +	
> +sysfs_in_offsets(0);
> +sysfs_in_offsets(1);
> +sysfs_in_offsets(2);
> +sysfs_in_offsets(3);
> +sysfs_in_offsets(4);
> +sysfs_in_offsets(5);
> +sysfs_in_offsets(6);
> +sysfs_in_offsets(7);
> +sysfs_in_offsets(8);
> +sysfs_in_offsets(9);
> +
> +#define device_create_file_in(client, offset) \
> +do { \
> +	device_create_file(&client->dev, &dev_attr_in##offset##_input); \
> +	device_create_file(&client->dev, &dev_attr_in##offset##_max); \
> +	device_create_file(&client->dev, &dev_attr_in##offset##_min); \
> +} while (0)
>  
>  #define show_fan_reg(reg) \
>  static ssize_t \
> @@ -522,21 +630,23 @@
>  static DEVICE_ATTR(fan##offset##_div, S_IRUGO, \
>  		   show_reg_fan##offset##_div, NULL);
>  
> -sysfs_fan_offset(1);
> -sysfs_fan_min_offset(1);
> -sysfs_fan_div_offset(1);
> -sysfs_fan_offset(2);
> -sysfs_fan_min_offset(2);
> -sysfs_fan_div_offset(2);
> -sysfs_fan_offset(3);
> -sysfs_fan_min_offset(3);
> -sysfs_fan_div_offset(3);
> -sysfs_fan_offset(4);
> -sysfs_fan_min_offset(4);
> -sysfs_fan_div_offset(4);
> -sysfs_fan_offset(5);
> -sysfs_fan_min_offset(5);
> -sysfs_fan_div_offset(5);
> +#define sysfs_fan_offsets(offset) \
> +sysfs_fan_offset(offset) \
> +sysfs_fan_min_offset(offset) \
> +sysfs_fan_div_offset(offset)
> +
> +sysfs_fan_offsets(1);
> +sysfs_fan_offsets(2);
> +sysfs_fan_offsets(3);
> +sysfs_fan_offsets(4);
> +sysfs_fan_offsets(5);
> +
> +#define device_create_file_fan(client, offset) \
> +do { \
> +	device_create_file(&client->dev, &dev_attr_fan##offset##_input); \
> +	device_create_file(&client->dev, &dev_attr_fan##offset##_min); \
> +	device_create_file(&client->dev, &dev_attr_fan##offset##_div); \
> +} while (0)
>  
>  #define show_temp1_reg(reg) \
>  static ssize_t \
> @@ -639,6 +749,13 @@
>  sysfs_temp_reg_offset(max, 3);
>  sysfs_temp_reg_offset(max_hyst, 3);
>  
> +#define device_create_file_temp(client, offset) \
> +do { \
> +	device_create_file(&client->dev, &dev_attr_temp##offset##_input); \
> +	device_create_file(&client->dev, &dev_attr_temp##offset##_max); \
> +	device_create_file(&client->dev, &dev_attr_temp##offset##_max_hyst); \
> +} while (0)
> +
>  /*
>   * Driver and client management
>   */
> @@ -665,6 +782,13 @@
>  					      W83627EHF_REG_TEMP_CONFIG[i],
>  					      tmp & 0xfe);
>  	}
> +	w83627ehf_write_value(client, 0x00, 0x04);
> +	w83627ehf_write_value(client, 0x02, 0x04);
> +	w83627ehf_write_value(client, 0x04, 0x00);
> +	w83627ehf_write_value(client, 0x10, 0x04);
> +	w83627ehf_write_value(client, 0x12, 0x00);
> +	w83627ehf_write_value(client, 0x60, 0x04);
> +	w83627ehf_write_value(client, 0x62, 0x00);

It seems this are your own tweaks. This needs to be removed.

>  }
>  
>  static int w83627ehf_detect(struct i2c_adapter *adapter)
> @@ -724,36 +848,31 @@
>  		goto exit_detach;
>  	}
>  
> -	device_create_file(&client->dev, &dev_attr_fan1_input);
> -	device_create_file(&client->dev, &dev_attr_fan1_min);
> -	device_create_file(&client->dev, &dev_attr_fan1_div);
> -	device_create_file(&client->dev, &dev_attr_fan2_input);
> -	device_create_file(&client->dev, &dev_attr_fan2_min);
> -	device_create_file(&client->dev, &dev_attr_fan2_div);
> -	device_create_file(&client->dev, &dev_attr_fan3_input);
> -	device_create_file(&client->dev, &dev_attr_fan3_min);
> -	device_create_file(&client->dev, &dev_attr_fan3_div);
> +	device_create_file_in(client, 0);
> +	device_create_file_in(client, 1);
> +	device_create_file_in(client, 2);
> +	device_create_file_in(client, 3);
> +	device_create_file_in(client, 4);
> +	device_create_file_in(client, 5);
> +	device_create_file_in(client, 6);
> +	device_create_file_in(client, 7);
> +	device_create_file_in(client, 8);
> +	device_create_file_in(client, 9);
> +
> +	device_create_file_fan(client, 1);
> +	device_create_file_fan(client, 2);
> +	device_create_file_fan(client, 3);
>  
>  	if (data->has_fan & (1 << 3)) {
> -		device_create_file(&client->dev, &dev_attr_fan4_input);
> -		device_create_file(&client->dev, &dev_attr_fan4_min);
> -		device_create_file(&client->dev, &dev_attr_fan4_div);
> +		device_create_file_fan(client, 4);
>  	}
>  	if (data->has_fan & (1 << 4)) {
> -		device_create_file(&client->dev, &dev_attr_fan5_input);
> -		device_create_file(&client->dev, &dev_attr_fan5_min);
> -		device_create_file(&client->dev, &dev_attr_fan5_div);
> +		device_create_file_fan(client, 5);
>  	}
> -
> -	device_create_file(&client->dev, &dev_attr_temp1_input);
> -	device_create_file(&client->dev, &dev_attr_temp1_max);
> -	device_create_file(&client->dev, &dev_attr_temp1_max_hyst);
> -	device_create_file(&client->dev, &dev_attr_temp2_input);
> -	device_create_file(&client->dev, &dev_attr_temp2_max);
> -	device_create_file(&client->dev, &dev_attr_temp2_max_hyst);
> -	device_create_file(&client->dev, &dev_attr_temp3_input);
> -	device_create_file(&client->dev, &dev_attr_temp3_max);
> -	device_create_file(&client->dev, &dev_attr_temp3_max_hyst);
> +	
> +	device_create_file_temp(client, 1);
> +	device_create_file_temp(client, 2);
> +	device_create_file_temp(client, 3);
>  
>  	return 0;
>  
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors at lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

