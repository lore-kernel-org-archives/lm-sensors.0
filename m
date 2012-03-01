From: Pierantonio Tabaro <toni.tabaro@gmail.com>
Date: Thu, 01 Mar 2012 12:01:26 +0000
Subject: Re: [lm-sensors] help with ads1015
Message-Id: <loom.20120301T125441-701@post.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20120301T115547-727@post.gmane.org>
In-Reply-To: <loom.20120301T115547-727@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare <khali <at> linux-fr.org> writes:

> 
> Yes, you are missing something. Please read:
> Documentation/i2c/instantiating-devices
> Method 3 is not implemented by the ads1015 driver because the devices
> it supports have no identification registers, so you'll have to use one
> of the three other methods.
> 

I have read the doc before posting ;-), i hope to be using method 1:

static struct at24_platform_data picomaster_i2c_eeprom_info = {
	.byte_len	= SZ_256K / 8,
	.page_size	= 64,
	.flags		= AT24_FLAG_ADDR16,
//	.setup		= davinci_get_mac_addr,
//	.context	= (void *)0x7f00,
};

struct ads1015_platform_data picomaster_i2c_ads1015_info = {
	.exported_channels = (1 << 2) | (1 << 4)
};

static struct i2c_board_info __initdata mxs_i2c_device[] = {
	//{ I2C_BOARD_INFO("sgtl5000-i2c", 0xa), .flags = I2C_M_TEN }
	{
		I2C_BOARD_INFO("rtc-ds1307", 0x68),
		.type	= "ds1339",
	},
	{
		I2C_BOARD_INFO("eeprom-24c256", 0x50),
		.platform_data = &picomaster_i2c_eeprom_info,
	},
	{
		I2C_BOARD_INFO("adc-ads1015", 0x48),
		//.platform_data = &picomaster_i2c_ads1015_info,
	},
	{
		I2C_BOARD_INFO("adc-ads1015", 0x49),
		//.platform_data = &picomaster_i2c_ads1015_info,
	},
};

static void __init i2c_device_init(void)
{
	printk("%s\n", __func__);
	i2c_register_board_info(0, mxs_i2c_device, ARRAY_SIZE(mxs_i2c_device));
}




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
