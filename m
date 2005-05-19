From: alex@alexdalton.org (Alexandre d'Alton)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: ADM1030 Driver
Message-Id: <1081373834.1690.20.camel@megapc>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040319224106.79f6cec3.cedric.pradalier@inrialpes.fr>
In-Reply-To: <20040319224106.79f6cec3.cedric.pradalier@inrialpes.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean,

The comments are meaningfull, I'll rework the code and send an update
soon.

Thanks for your time.

Alex.

On Wed, 2004-04-07 at 23:35, Jean Delvare wrote:
> Hi Alexandre,
> 
> See my comments on your ADM1030 driver inline.
> 
> > #include <linux/config.h>
> 
> You don't need this, do you?
> 
> > /* Addresses to scan */
> > static unsigned short normal_i2c[] = { I2C_CLIENT_END };
> > static unsigned short normal_i2c_range[] = { 0x2e, I2C_CLIENT_END };
> 
> That's not a valid range. You want "{ 0x2c, 0x2e, I2C_CLIENT_END };"
> according to the datasheet.
> 
> > /* Each client has this additional data */
> > struct adm1030_data {
> >   struct semaphore	update_lock;
> >   char			valid;		/* !=0 if following fields are valid */
> >   unsigned long		last_updated;	/* In jiffies */
> >   u16			temp_local_in;	/* Register values */
> >   u16			temp_remote_in;
> >   u16			fan_rpm;
> >   u16		        conf1;
> >   u16			conf2;
> >   u16			ftac;
> >   u16			pwm;
> >   u16                   temp_local_min;
> >   u16                   temp_local_range;
> >   u16                   temp_remote_min;
> >   u16                   temp_remote_range;
> > };
> 
> This is likely to make the code impossible to refactor. A better
> approach IMHO would be:
> 
> struct adm1030_data {
>   struct semaphore	update_lock;
>   char			valid;		/* !=0 if following fields are valid */
>   unsigned long		last_updated;	/* In jiffies */
>   u16			temp[2];	/* Register values */
>   u16                   temp_min[2];
>   u16                   temp_range[2];
>   u16			fan_rpm;
>   u16		        conf1;
>   u16			conf2;
>   u16			ftac;
>   u16			pwm;
> };
> 
> I guess you get the idea. That way you can hope to have the same code
> handling both temperature channels. This becomes even more convenient if
> you want to support the ADM1031 driver, which has a second remote
> temperature channel. Same of course goes for the voltages and fans once
> you start handling them.
> 
> This supposes that you define registers a bit differently, see below.
> 
> > /* This is the driver that will be inserted */
> > static struct i2c_driver adm1030_driver = {
> > 	.owner		= THIS_MODULE,
> > 	.name		= "adm1030",
> > 	.id		= I2C_DRIVERID_ADM1030,
> 
> I invite you not to declare any id. It's not needed for normal operation
> and will make testing more difficult. It's always possible to add it
> later if needed.
> 
> > 	.flags		= I2C_DF_NOTIFY,
> > 	.attach_adapter	= adm1030_attach_adapter,
> > 	.detach_client	= adm1030_detach_client,
> > };
> 
> > #define show(value)	\
> > static ssize_t show_##value(struct device *dev, char *buf)		\
> > {									\
> > 	struct adm1030_data *data = adm1030_update_device(dev);		\
> > 	return sprintf(buf, "%d\n", data->value);	\
> > }
> 
> %u, not %d.
> 
> > show(temp_local_in);
> > show(temp_remote_in);
> > show(conf1);
> > show(conf2);
> > show(ftac);
> > show(pwm);
> > show(temp_local_min);
> > show(temp_local_range);
> > show(temp_remote_min);
> > show(temp_remote_range);
> 
> It's probably not correct for temperatures. According to
> Documentation/i2c/sysfs-interface, temperatures are exported in
> millidegrees Celcius.
> 
> Also, we usually do not export configuration registers to user-space.
> 
> What is ftac?
> 
> > static ssize_t show_fan_rpm(struct device *dev, char *buf)		
> > {									
> >   int fan_speed;
> >   struct adm1030_data *data = adm1030_update_device(dev);		
> >   fan_speed = (11250 * 60) / (data->fan_rpm * 8);
> >   return sprintf(buf, "%d\n", fan_speed);	
> > }
> 
> Is that "* 8" a hardcoded fan divisor? Looks bad.
> 
> You should define a macro for fan conversions. See w83781d.c for
> example. More generally, you should follow w83781d or lm78.c instead of
> lm75.c for examples, since these devices are more similar to the
> adm1030.
> 
> > void set_temp_min(struct i2c_client *client, int value, int reg)
> > {
> >   int val = adm1030_read_value(client, reg);
> >   val = ( ( ( value >> 2 ) & 0x1f ) << 3 ) | ( val & 0x7 ); 
> >   adm1030_write_value(client, reg, val);
> > }
> > void set_temp_range(struct i2c_client *client, int value, int reg)
> > {
> >   int val = adm1030_read_value(client, reg);
> >   switch (value) {
> >   case 5: value = 0; break;
> >   case 10: value = 1; break;
> >   case 20: value = 2; break;
> >   case 40: value = 3; break;
> >   case 80: value = 4; break;
> >   default: return;
> >   }
> >   val = (val&0xf8) | (value & 0x7); 
> >   adm1030_write_value(client, reg, val);
> > }
> 
> These functions should not return void. And they should return -1 in
> case of error.
> 
> > static ssize_t set_temp_local_min(struct device *dev, const char *buf,
> > size_t
> > 				  count) 
> > {
> >   struct i2c_client * client = to_i2c_client(dev);
> >   int temp = simple_strtoul(buf, NULL, 10);		
> >   set_temp_min(client, temp, ADM1030_REG_LTR);
> >   return count;
> > }
> > static ssize_t set_temp_local_range(struct device *dev, const char
> > *buf, size_t
> > 				  count) 
> > {
> >   struct i2c_client * client = to_i2c_client(dev);
> >   int temp = simple_strtoul(buf, NULL, 10);		
> >   set_temp_range(client, temp, ADM1030_REG_LTR);
> >   return count;
> >   
> > }
> > static ssize_t set_temp_remote_min(struct device *dev, const char
> > *buf, size_t
> > 				  count) 
> > {
> >   struct i2c_client * client = to_i2c_client(dev);
> >   int temp = simple_strtoul(buf, NULL, 10);		
> >   set_temp_min(client, temp, ADM1030_REG_RTR);
> >   return count;  
> > }
> > 
> > static ssize_t set_temp_remote_range(struct device *dev, const char
> > *buf, size_t
> > 				  count) 
> > {
> >   struct i2c_client * client = to_i2c_client(dev);
> >   int temp = simple_strtoul(buf, NULL, 10);		
> >   set_temp_range(client, temp, ADM1030_REG_RTR);
> >   return count;
> >   
> > }
> 
> This can be considerably simplified (using macros) if you use arrays to
> store the values, as adviced above. Again, lm78.c is a good example of
> how to do that.
> 
> > 
> > //static DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max,
> > set_temp_max);
> > //static DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO,
> > show_temp_hyst, set_temp_hyst);
> > static DEVICE_ATTR(conf1, S_IWUSR | S_IRUGO, show_conf1, set_conf1);
> > static DEVICE_ATTR(conf2, S_IWUSR | S_IRUGO, show_conf2, set_conf2);
> > static DEVICE_ATTR(ftac, S_IWUSR | S_IRUGO, show_ftac, set_ftac);
> > static DEVICE_ATTR(pwm, S_IWUSR | S_IRUGO, show_pwm, set_pwm);
> > static DEVICE_ATTR(temp_local_in, S_IRUGO, show_temp_local_in, NULL);
> > static DEVICE_ATTR(temp_remote_in, S_IRUGO, show_temp_remote_in,
> > NULL); static DEVICE_ATTR(fan_rpm, S_IRUGO , show_fan_rpm, NULL);
> > static DEVICE_ATTR(temp_local_min, S_IRUGO | S_IWUSR, 
> > 		   show_temp_local_min, set_temp_local_min);
> > static DEVICE_ATTR(temp_local_range, S_IRUGO | S_IWUSR, 
> > 		   show_temp_local_range, set_temp_local_range);
> > static DEVICE_ATTR(temp_remote_min, S_IRUGO | S_IWUSR, 
> > 		   show_temp_remote_min, set_temp_remote_min);
> > static DEVICE_ATTR(temp_remote_range, S_IRUGO | S_IWUSR, 
> > 		   show_temp_remote_range, set_temp_remote_range);
> 
> Names don't follow the sysfs-interface convention at all! Please
> correct.
> 
> > static int adm1030_detect(struct i2c_adapter *adapter, int address,
> > int kind)
> > (...)
> > 	/* Make sure we aren't probing the ISA bus!! This is just a
> > 	safety
> > check
> > 	   at this moment; i2c_detect really won't call us. */
> > #ifdef DEBUG
> > 	if (i2c_is_isa_adapter(adapter)) {
> > 		dev_dbg(&adapter->dev,
> > 			"adm1030_detect called for an ISA bus adapter?!?\n");
> > 		goto exit;
> > 	}
> > #endif
> 
> You can drop that test, it's useless.
> 
> > 	/* Now, we do the remaining detection. It is lousy. */
> 
> No, it is not lousy. The detection of the LM75 is, not yours, so the comment doesn't apply.
> 
> > 	if (kind < 0) {
> > 		id = i2c_smbus_read_byte_data(new_client, 0x3d);
> > 		co = i2c_smbus_read_byte_data(new_client, 0x3e);
> 
> These could be local variables.
> 
> > static int adm1030_detach_client(struct i2c_client *client)
> > {
> > 	i2c_detach_client(client);
> 
> Please check on error returned by i2c_detach_client. lm75.c doesn't, but
> it's bad. See any other driver for the correct way to handle it.
> 
> > static void adm1030_init_client(struct i2c_client *client)
> > {
> >   int read_val;
> > 	/* Initialize the ADM1030 chip (enables fan speed reading )*/
> > 	adm1030_write_value(client, ADM1030_REG_CONF2, 0x3f);
> 
> Looks a bit agressive, but I would need to read the datasheet.
> 
> > 	/* Increase the accuracy on rpm measurements */
> > 	read_val = adm1030_read_value(client, ADM1030_REG_FCH);
> > 	adm1030_write_value(client, ADM1030_REG_FCH, 0xc0 | read_val);
> > 
> > }
> > 
> > static struct adm1030_data *adm1030_update_device(struct device *dev)
> > {
> > 	struct i2c_client *client = to_i2c_client(dev);
> > 	struct adm1030_data *data = i2c_get_clientdata(client);
> > 	int temp_range;
> > 	static unsigned short values[5] = {5, 10, 20, 40, 80};
> 
> This can be computed (5 * (x << n)).
> 
> 
> HEADER:
> 
> 
> > #include <linux/i2c-sensor.h>
> 
> You don't need this, do you?
> 
> > #define ADM1030_REG_TEMP_INT		0x0a
> > #define ADM1030_REG_TEMP_EXT		0x0b
> 
> For example you can #define ADM1031_REG_TEMP(nr)	(0x09 + (nr)).
> 
> Same for the rest. That way you should be able to treat most values
> regardless of the channel number, which makes the code shorted and more
> readable.
> 
> This was simply a first pass, more later if I find some time.
> 
> Thanks.
