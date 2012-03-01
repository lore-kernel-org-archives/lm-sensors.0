From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 01 Mar 2012 14:45:39 +0000
Subject: Re: [lm-sensors] help with ads1015
Message-Id: <20120301144539.GA16455@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20120301T115547-727@post.gmane.org>
In-Reply-To: <loom.20120301T115547-727@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Mar 01, 2012 at 08:38:01AM -0500, Jean Delvare wrote:
> On Thu, 1 Mar 2012 12:01:26 +0000 (UTC), Pierantonio Tabaro wrote:
> > Jean Delvare <khali <at> linux-fr.org> writes:
> > 
> > > 
> > > Yes, you are missing something. Please read:
> > > Documentation/i2c/instantiating-devices
> > > Method 3 is not implemented by the ads1015 driver because the devices
> > > it supports have no identification registers, so you'll have to use one
> > > of the three other methods.
> > > 
> > 
> > I have read the doc before posting ;-), i hope to be using method 1:
> > 
> > static struct at24_platform_data picomaster_i2c_eeprom_info = {
> > 	.byte_len	= SZ_256K / 8,
> > 	.page_size	= 64,
> > 	.flags		= AT24_FLAG_ADDR16,
> > //	.setup		= davinci_get_mac_addr,
> > //	.context	= (void *)0x7f00,
> > };
> > 
> > struct ads1015_platform_data picomaster_i2c_ads1015_info = {
> > 	.exported_channels = (1 << 2) | (1 << 4)
> > };
> > 
> > static struct i2c_board_info __initdata mxs_i2c_device[] = {
> > 	//{ I2C_BOARD_INFO("sgtl5000-i2c", 0xa), .flags = I2C_M_TEN }
> > 	{
> > 		I2C_BOARD_INFO("rtc-ds1307", 0x68),
> > 		.type	= "ds1339",
> > 	},
> > 	{
> > 		I2C_BOARD_INFO("eeprom-24c256", 0x50),
> > 		.platform_data = &picomaster_i2c_eeprom_info,
> > 	},
> > 	{
> > 		I2C_BOARD_INFO("adc-ads1015", 0x48),
> > 		//.platform_data = &picomaster_i2c_ads1015_info,
> > 	},
> > 	{
> > 		I2C_BOARD_INFO("adc-ads1015", 0x49),
> > 		//.platform_data = &picomaster_i2c_ads1015_info,
> > 	},
> 
> The driver wants "ads1015" not "adc-ads1015".
> 
Also probably "eeprom" or "24c256" instead of "eeprom-24c256",
and "sgtl5000" instead of ""sgtl5000-i2c".

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
