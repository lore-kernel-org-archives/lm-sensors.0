From: Pierantonio Tabaro <toni.tabaro@gmail.com>
Date: Thu, 01 Mar 2012 14:34:03 +0000
Subject: Re: [lm-sensors] help with ads1015
Message-Id: <loom.20120301T144916-981@post.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20120301T115547-727@post.gmane.org>
In-Reply-To: <loom.20120301T115547-727@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare <khali <at> linux-fr.org> writes:

> 
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
> > I have read the doc before posting , i hope to be using method 1:
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

Thank you, this is the solution!, now is working well:

root@picomaster ~$ cat /sys/devices/platform/mxs-i2c.0/i2c-0/0-004[89]/in?_input
-2
0
1
1
943
946
946
945
0
-4
-3
0
944
945
948
949

And also i have fixed the code for eeprom:

-		I2C_BOARD_INFO("eeprom-24c256", 0x50),
+		I2C_BOARD_INFO("24c256", 0x50),

root@picomaster ~$ echo "lm-sensors is great!" > /sys/devices/platform/mxs-
i2c.0/
i2c-0/0-0050/eeprom
root@picomaster ~$ cat  /sys/devices/platform/mxs-i2c.0/i2c-0/0-0050/eeprom     
lm-sensors is great!   

You helped my to fix 2 bug at once!

Another off-topic question:
I need to write a driver for and AD5337 i2c Dac, i searched something in 
internet but without success.
I would like to use one existing driver, there is on linux support for DAC's?
Some suggestion?




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
