From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: New driver for MAX663x temperature sensor.
Message-Id: <20040414112944.0cd58492.johnpol@2ka.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <1081775028.11592.294.camel@uganda>
In-Reply-To: <1081775028.11592.294.camel@uganda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 13 Apr 2004 21:26:45 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> > Done.
> 
> My comments inline:
> 
> > @@ -126,7 +126,7 @@
> >  	if (tmp < 0) return (-EIO);
> >  
> >  	/* convert the data to little endian format */
> > -	*value = swab16((u16) tmp);
> > +	*value = ((u16) tmp >> 8) | (u16) ((u16) tmp << 8);
> >  
> >  	return (0);
> >  }
> > @@ -134,10 +134,8 @@
> >  static inline int lm92_write16 (struct i2c_client *client,u8
> >  reg,u16 value){
> >  	/* convert the data to big endian format */
> > -	if (i2c_smbus_write_word_data(client, reg, swab16(value)) < 0)
> > -		return -EIO;
> > -
> > -	return 0;
> > +	u16 be = (value >> 8) | (u16) (value << 8);
> > +	return (i2c_smbus_write_word_data (client,reg,be) < 0 ? -EIO :
> > 0);
> >  }
> 
> 
> These are two changes I just commited to the CVS repository. Please
> don't revert them.

I've reverted them in previous e-mail.
Attached patch also doesn't conain them.

> > +static int max6635_check(struct i2c_client *client)
> > +{
> > +	lm92_t *data = (lm92_t *) client->data;
> > +	int i, cn = 8;
> 
> I hardly can see any reason to define cn as a variable.

Removed.

> > +	u16 temp_low, temp_high, temp_hyst, temp_max;
> > +
> > +	temp_low 	= i2c_smbus_read_word_data(client,
> > LM92_REG_TRIP_LOW);+	temp_high	= i2c_smbus_read_word_data(client,
> > LM92_REG_TRIP_HIGH);+	temp_hyst	= i2c_smbus_read_word_data(client,
> > LM92_REG_TRIP_HYSTERESIS);+	temp_max	= i2c_smbus_read_word_data(client,
> > LM92_REG_TRIP_CRITICAL);+	
> > +	if (!(!(temp_low & 0x7f00) && !(temp_high & 0x7f00) &&
> > !(temp_hyst & 0x7f00) && !(temp_max & 0x7f00)))+		return 0;
> 
> You can spare negations by just using ||'s instead of &&'s (De
> Morgan's law, http://en.wikipedia.org/wiki/De_Morgan's_law).

:)

> > +	for (i=0; i<32; ++i)
> 
> You can skip i=0, it cannot fail.
> 
> > +	{
> > +		if ((i % 2 = 0) && (i < 16))
> > +		{
> > +			if ((i2c_smbus_read_word_data(client, LM92_REG_TRIP_LOW
> > + i*cn) != temp_low) ||+				(temp_high !> > i2c_smbus_read_word_data(client, LM92_REG_TRIP_HIGH + i*cn)) ||+	
> > 		(temp_hyst != i2c_smbus_read_word_data(client,
> > 		LM92_REG_TRIP_HYSTERESIS + i*cn)) ||
> > +				(temp_max != i2c_smbus_read_word_data(client,
> > LM92_REG_TRIP_CRITICAL + i*cn)))+				return 0;
> > +		}
> > +		else
> > +		{
> > +			if ((i2c_smbus_read_word_data(client, LM92_REG_TRIP_LOW
> > + i*cn) != 0) ||+				(0 != i2c_smbus_read_word_data(client,
> > LM92_REG_TRIP_HIGH + i*cn)) ||+				(0 !> > i2c_smbus_read_word_data(client, LM92_REG_TRIP_HYSTERESIS + i*cn))
> > ||
> > +				(0 != i2c_smbus_read_word_data(client,
> > LM92_REG_TRIP_CRITICAL + i*cn)))+				return 0;
> 
> I don't think you can rely of these zeroes. Maybe other chips would
> return random values or the limits.

I removed them, although they were always zero.

> I would simply do "for (i=2; i<16; i+=2)" (or even "for (i=1; i<8;
> ++i)" with cn) and discard that second test.
> 
> > +	data->temp.low 	= swab16(temp_low);
> > +	data->temp.high = swab16(temp_high);
> > +	data->temp.crit	= swab16(temp_max);
> > +	data->temp.hyst = swab16(temp_hyst);
> > +	data->temp.low 	= swab16(i2c_smbus_read_word_data(client,
> > LM92_REG_TEMPERATURE));
> 
> Bug here.
> 
> Anyway I don't see the point in filling the variables since you don't
> update data->timestamp accordingly (so everything will be read again
> anyway). And you cannot update data->timestamp if you don't read the
> alarms too. All in all you would have to duplicate lm92_read here. So
> either don't store the values at all (recommended) or call lm92_read
> instead or rewriting it.

I just removed caching from detect path.

> > @@ -294,20 +335,25 @@
> >  		return (-ERESTARTSYS);
> >  	}
> >  
> > -	if ((kind < 0 && lm92_read16
> > (client,LM92_REG_MANUFACTURER,&manufacturer) < 0) ||-		manufacturer !> > LM92_MANUFACTURER_ID) {-		kfree (client);
> > -		up (&mutex);
> > -		return (-ENODEV);
> > -	}
> > -
> >  	if ((result = i2c_attach_client (client))) {
> >  		kfree (client);
> >  		up (&mutex);
> >  		return (result);
> >  	}
> >  
> > -	if ((result = i2c_register_entry
> > (client,client->name,lm92_dir_table)) < 0) {+	if ((kind < 0 &&
> > lm92_read16 (client,LM92_REG_MANUFACTURER,&manufacturer) < 0) ||+	
> > manufacturer != LM92_MANUFACTURER_ID) {+
> > +		if (!max6635_check(client))
> > +		{
> > +			i2c_detach_client (client);
> > +			kfree (client);
> > +			up (&mutex);
> > +			return (-ENODEV);
> > +		}
> > +	}
> > +
> > +	if ((result = i2c_register_entry
> > (client,client->name,lm92_dir_table, THIS_MODULE)) < 0) {
> >  		i2c_detach_client (client);
> >  		kfree (client);
> >  		up (&mutex);
> 
> Why did you move swapped the detection and the client attachement?
> Detecting before we attempt to attach the client is actually the
> correct order.

Just to be sure that adapter can manage this client, but it is actually
not needed.

> The additional parameter to i2c_register_entry breaks compilation. I
> suspect that you use an outdated version of i2c. Get at least version
> 2.8.2.

i2c from 2.4.25 requires this. Attached patch for lm_sensors doesn't
contain this change.

> >  static struct i2c_driver lm92_driver = {
> > -	.owner		= THIS_MODULE,
> >  	.name		= "lm92",
> > -	.id		= I2C_DRIVERID_LM92,
> >  	.flags		= I2C_DF_NOTIFY,
> >  	.attach_adapter	= lm92_attach_adapter,
> >  	.detach_client	= lm92_detach_client,
> 
> No, don't do that.

The same here. Attached patch doesn't contain this change.

> -- 
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/


	Evgeniy Polyakov ( s0mbre )

Only failure makes us experts. -- Theo de Raadt
-------------- next part --------------
--- /tmp/lm_sensors-2.8.6/kernel/chips/lm92.c.orig	2004-04-14 11:09:35.000000000 +0400
+++ /home/s0mbre/aWork/bitkeeper/exp-i2c/drivers/i2c/max6635.c	2004-04-14 11:10:47.000000000 +0400
@@ -107,7 +107,7 @@
 
 /* addresses to scan */
 static unsigned short normal_i2c[] = { SENSORS_I2C_END };
-static unsigned short normal_i2c_range[] = { 0x48, 0x4b, SENSORS_I2C_END };
+static unsigned short normal_i2c_range[] = { 0x48, 0x4f, SENSORS_I2C_END };
 static unsigned int normal_isa[] = { SENSORS_ISA_END };
 static unsigned int normal_isa_range[] = { SENSORS_ISA_END };
 
@@ -231,6 +229,32 @@
 	}
 }
 
+static int max6635_check(struct i2c_client *client)
+{
+	lm92_t *data = (lm92_t *) client->data;
+	int i;
+	u16 temp_low, temp_high, temp_hyst, temp_max;
+
+	temp_low 	= i2c_smbus_read_word_data(client, LM92_REG_TRIP_LOW);
+	temp_high	= i2c_smbus_read_word_data(client, LM92_REG_TRIP_HIGH);
+	temp_hyst	= i2c_smbus_read_word_data(client, LM92_REG_TRIP_HYSTERESIS);
+	temp_max	= i2c_smbus_read_word_data(client, LM92_REG_TRIP_CRITICAL);
+	
+	if ((temp_low & 0x7f00) || (temp_high & 0x7f00) || (temp_hyst & 0x7f00) || (temp_max & 0x7f00))
+		return 0;
+
+	for (i=1; i<8; ++i)
+	{
+		if ((i2c_smbus_read_word_data(client, LM92_REG_TRIP_LOW + i*16) != temp_low) ||
+			(temp_high != i2c_smbus_read_word_data(client, LM92_REG_TRIP_HIGH + i*16)) ||
+			(temp_hyst != i2c_smbus_read_word_data(client, LM92_REG_TRIP_HYSTERESIS + i*16)) ||
+			(temp_max != i2c_smbus_read_word_data(client, LM92_REG_TRIP_CRITICAL + i*16)))
+			return 0;
+	}
+	
+	return 1;
+}
+
 static int lm92_init_client (struct i2c_client *client)
 {
 	lm92_t *data = (lm92_t *) client->data;
@@ -296,9 +320,13 @@
 
 	if ((kind < 0 && lm92_read16 (client,LM92_REG_MANUFACTURER,&manufacturer) < 0) ||
 		manufacturer != LM92_MANUFACTURER_ID) {
-		kfree (client);
-		up (&mutex);
-		return (-ENODEV);
+
+		if (!max6635_check(client))
+		{
+			kfree (client);
+			up (&mutex);
+			return (-ENODEV);
+		}
 	}
 
 	if ((result = i2c_attach_client (client))) {
