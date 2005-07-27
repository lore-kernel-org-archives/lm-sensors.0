From: BGardner@Wabtec.com (BGardner@Wabtec.com)
Date: Wed, 27 Jul 2005 19:10:14 +0000
Subject: [lm-sensors] [PATCH] I2C: simplify max6875 driver
Message-Id: <F06EB2894F3F0D45AD9BEA7246DE9C90E23CF6@WCSEXCMBS1.ad.wabtec.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200507121321.11458.bgardner@wabtec.com>
In-Reply-To: <200507121321.11458.bgardner@wabtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean, 

> Sorry for the delay. I see that Greg picked your patch, so it's about
> time that I take a look and comment on it.

Thank you for taking time to review it.
There's no rush on this, as I am probably the only one (currently)
interested in it. =)
 
> > +static void max6875_update_slice(struct i2c_client 
> *client, int slice)
> >  {
> >  	struct max6875_data *data = i2c_get_clientdata(client);
> > -	int i, j, addr, count;
> > -	u8 rdbuf[SLICE_SIZE];
> > +	int i, j, addr;
> > +	u8 *buf;
> >  	int retval = 0;
> 
> retval is set in various place in this function, but not returned?

I'll remove it.
Funny how little things slip by no matter how much I look at the code.

> > +static inline struct i2c_client *kobj_to_i2c_client(struct 
> kobject *kobj)
> 
> I don't much like seeing a function with such a generic name in a
> specific driver. This could easily collide with something similar
> declared in a public header (i2c.h comes to mind). Shouldn't 
> this inline
> function be moved to i2c.h right now?

I'll do that.  

> > 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA
> > 				     | I2C_FUNC_SMBUS_READ_BYTE))
> 
> You don't seem to be calling i2c_smbus_read_byte_data() 
> anywhere, so you
> could check for only I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
> I2C_FUNC_SMBUS_READ_BYTE. Not that it should change anything 
> practically
> though.
>
> > +	strlcpy(fake_client->name, "max6875-dummy", I2C_NAME_SIZE);
> 
> The typical name for "fake clients" is "<client name> subclient".

I'll change those as suggested.
 
> On the documentation front:
> 
> > modprobe max6875 force=0,0x50
> 
> This made me realize that forcing eeprom drivers (eeprom and 
> max6875) is
> nor properly handled WRT 24RF08 corruption prevention. I will submit a
> separate patch fixing this for both drivers.

Sounds fine to me.

> > Reads and write are performed differently depending on the 
> address range.
> 
> I'd guess write_s_?

I'll throw together three patches, then:
1) move kobj_to_i2c_client() to i2c.h, under to_i2c_client()
2) code: fix retval, SMB check, and 'fake' client name
3) doc: fix 'writes' and name of the fake client


> As Greg accepted your last updates already, any fix you would 
> submit now
> would be as an incremental patch.
Will do.

Thanks again,
Ben

