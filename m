From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 26 Feb 2006 11:47:18 +0000
Subject: [lm-sensors] [PATCH 1/1] i2c: m41txx driver for ST i2c RTC chips
Message-Id: <44019546.4040807@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060217011359.GA16247@mag.az.mvista.com>
In-Reply-To: <20060217011359.GA16247@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Please note that you will have to fix some files in ./arch/powerpc/configs/ and ./arch/ppc/configs/
too.( they mention CONFIG_SENSORS_M41T00) And of course /arch/ppc/platforms/katana.c
I think it will need the platform stuff so it can connect to this platform driver.

I'm not very sure what will happen when some users dont have this chip in their platform?
Ideally they should just force the driver to specific addr. As far I can judge this cannot
be done (I looked to _probe function) Maybe there can be some workaround so they can force
the parameters somehow? Please can you throw some light on this?

We will need certainly a Documentation/i2c/chips/m41txx to document how this issue can be solved.

I tried to review the driver and seems OK to me.

Thanks,
regards
Rudolf

> diff -Nurp linux-2.6.16-rc3-mm1/drivers/i2c/chips/m41txx.c linux-2.6.16-rc3-mm1-m41txx/drivers/i2c/chips/m41txx.c
> --- linux-2.6.16-rc3-mm1/drivers/i2c/chips/m41txx.c	1969-12-31 17:00:00.000000000 -0700
> +++ linux-2.6.16-rc3-mm1-m41txx/drivers/i2c/chips/m41txx.c	2006-02-16 17:23:30.000000000 -0700
> @@ -0,0 +1,365 @@
> +/*
> + * I2C client/driver for the ST M41Txx family of i2c rtc chips.
> + *
> + * Author: Mark A. Greer <mgreer at mvista.com>
> + *
> + * 2005 (c) MontaVista Software, Inc. This file is licensed under
> + * the terms of the GNU General Public License version 2. This program
> + * is licensed "as is" without any warranty of any kind, whether express
> + * or implied.
> + */
> +/*
> + * This i2c client/driver wedges between the drivers/char/genrtc.c RTC
> + * interface and the SMBus interface of the i2c subsystem.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/i2c.h>
> +#include <linux/rtc.h>
> +#include <linux/m41txx.h>
> +#include <linux/bcd.h>
> +#include <linux/workqueue.h>
> +#include <linux/platform_device.h>
> +
> +#include <asm/time.h>
> +#include <asm/rtc.h>
> +
> +static struct work_struct set_rtc_time_task;
> +
> +static struct i2c_driver m41txx_driver;
> +static struct i2c_client *save_client;
> +
> +static unsigned short ignore[] = { I2C_CLIENT_END };
> +static unsigned short normal_addr[] = { 0, I2C_CLIENT_END };
> +
> +static struct i2c_client_address_data addr_data = {
> +	.normal_i2c	= normal_addr,
> +	.probe		= ignore,
> +	.ignore		= ignore,
> +};
> +
> +struct m41txx_chip_info {
> +	u16	type;
> +	u16	read_limit;
> +	u8	sec;		/* Offsets for chip regs */
> +	u8	min;
> +	u8	hour;
> +	u8	day;
> +	u8	mon;
> +	u8	year;
> +	u8	alarm_mon;
> +	u8	alarm_hour;
> +	u8	sqw;
> +	u32	sqw_freq;
> +};
> +
> +static struct m41txx_chip_info m41txx_chip_info_tbl[] = {
> +	{ M41TXX_TYPE_M41T00, 5, 0, 1, 2, 4, 5, 6,   0,   0,    0, 0 },
> +	{ M41TXX_TYPE_M41T81, 1, 1, 2, 3, 5, 6, 7, 0xa, 0xc, 0x13, 0 },
> +	{ M41TXX_TYPE_M41T85, 1, 1, 2, 3, 5, 6, 7, 0xa, 0xc, 0x13, 0 },
> +};
> +static struct m41txx_chip_info *m41txx_chip;
> +
> +unsigned long
> +m41txx_get_rtc_time(void)
> +{
> +	s32 sec, min, hour, day, mon, year;
> +	s32 sec1, min1, hour1, day1, mon1, year1;
> +	u16 reads = 0;
> +	u8 buf[8], msgbuf[1] = { 0 }; /* offset into rtc's regs */
> +	struct i2c_msg msgs[] = {
> +		{ save_client->addr, 0, 1, msgbuf },
> +		{ save_client->addr, I2C_M_RD, 8, buf }
> +	};
> +
> +	sec = min = hour = day = mon = year = 0;
> +
> +	do {
> +		if (i2c_transfer(save_client->adapter, msgs, 2) < 0)
> +			goto read_err;
> +
> +		sec1  = sec;
> +		min1  = min;
> +		hour1 = hour;
> +		day1  = day;
> +		mon1  = mon;
> +		year1 = year;
> +
> +		sec  =  buf[m41txx_chip->sec]  & 0x7f;
> +		min  =  buf[m41txx_chip->min]  & 0x7f;
> +		hour =  buf[m41txx_chip->hour] & 0x3f;
> +		day  =  buf[m41txx_chip->day]  & 0x3f;
> +		mon  =  buf[m41txx_chip->mon]  & 0x1f;
> +		year =  buf[m41txx_chip->year] & 0xff;
> +	} while ((++reads < m41txx_chip->read_limit) && ((sec != sec1)
> +			|| (min != min1) || (hour != hour1) || (day != day1)
> +			|| (mon != mon1) || (year != year1)));
> +
> +	if ((m41txx_chip->read_limit > 1) && ((sec != sec1) || (min != min1)
> +			|| (hour != hour1) || (day != day1) || (mon != mon1)
> +			|| (year != year1)))
> +		goto read_err;
> +
> +	sec  = BCD2BIN(sec);
> +	min  = BCD2BIN(min);
> +	hour = BCD2BIN(hour);
> +	day  = BCD2BIN(day);
> +	mon  = BCD2BIN(mon);
> +	year = BCD2BIN(year);
> +
> +	year += 1900;
> +	if (year < 1970)
> +		year += 100;
> +
> +	return mktime(year, mon, day, hour, min, sec);
> +
> +read_err:
> +	dev_err(&save_client->dev, "m41txx_get_rtc_time: Read error\n");
> +	return 0;
> +}
> +
> +static void
> +m41txx_set(void *arg)
> +{
> +	struct rtc_time	tm;
> +	int nowtime = *(int *)arg;
> +	s32 sec, min, hour, day, mon, year;
> +	u8 wbuf[9], *buf = &wbuf[1], msgbuf[1] = { 0 };
> +	struct i2c_msg msgs[] = {
> +		{ save_client->addr, 0, 1, msgbuf },
> +		{ save_client->addr, I2C_M_RD, 8, buf }
> +	};
> +
> +	to_tm(nowtime, &tm);
> +	tm.tm_year = (tm.tm_year - 1900) % 100;
> +
> +	sec  = BIN2BCD(tm.tm_sec);
> +	min  = BIN2BCD(tm.tm_min);
> +	hour = BIN2BCD(tm.tm_hour);
> +	day  = BIN2BCD(tm.tm_mday);
> +	mon  = BIN2BCD(tm.tm_mon);
> +	year = BIN2BCD(tm.tm_year);
> +
> +	/* Read reg values into buf[0..7]/wbuf[1..8] */
> +	if (i2c_transfer(save_client->adapter, msgs, 2) < 0) {
> +		dev_err(&save_client->dev, "m41txx_set: Read error\n");
> +		return;
> +	}
> +
> +	wbuf[0] = 0; /* offset into rtc's regs */
> +	buf[m41txx_chip->sec]  = (buf[m41txx_chip->sec] & ~0x7f) | (sec & 0x7f);
> +	buf[m41txx_chip->min]  = (buf[m41txx_chip->min] & ~0x7f) | (min & 0x7f);
> +	buf[m41txx_chip->hour] = (buf[m41txx_chip->hour]& ~0x3f) | (hour& 0x3f);
> +	buf[m41txx_chip->day]  = (buf[m41txx_chip->day] & ~0x3f) | (day & 0x3f);
> +	buf[m41txx_chip->mon]  = (buf[m41txx_chip->mon] & ~0x1f) | (mon & 0x1f);
> +
> +	if (i2c_master_send(save_client, wbuf, 9) < 0)
> +		dev_err(&save_client->dev, "m41txx_set: Write error\n");
> +}
> +
> +static u32	new_time;
> +
> +int
> +m41txx_set_rtc_time(unsigned long nowtime)
> +{
> +	new_time = nowtime;
> +
> +	if (in_interrupt())
> +		schedule_work(&set_rtc_time_task);
> +	else
> +		m41txx_set((void *)&new_time);
> +	return 0;
> +}
> +
> +/*
> + *****************************************************************************
> + *
> + *	platform_data Driver Interface
> + *
> + *****************************************************************************
> + */
> +static int __init
> +m41txx_platform_probe(struct platform_device *pdev)
> +{
> +	struct m41txx_platform_data *pdata;
> +	int i;
> +
> +	if (pdev && (pdata = pdev->dev.platform_data)) {
> +		normal_addr[0] = pdata->i2c_addr;
> +
> +		for (i=0; i<ARRAY_SIZE(m41txx_chip_info_tbl); i++)
> +			if (m41txx_chip_info_tbl[i].type = pdata->type) {
> +				m41txx_chip = &m41txx_chip_info_tbl[i];
> +				m41txx_chip->sqw_freq = pdata->sqw_freq;
> +				return 0;
> +			}
> +	}
> +	return -ENODEV;
> +}
> +
> +static int __exit
> +m41txx_platform_remove(struct platform_device *pdev)
> +{
> +	return 0;
> +}
> +
> +static struct platform_driver m41txx_platform_driver = {
> +	.probe  = m41txx_platform_probe,
> +	.remove = m41txx_platform_remove,
> +	.driver = {
> +		.owner = THIS_MODULE,
> +		.name  = M41TXX_DRV_NAME,
> +	},
> +};
> +
> +/*
> + *****************************************************************************
> + *
> + *	Driver Interface
> + *
> + *****************************************************************************
> + */
> +static int
> +m41txx_probe(struct i2c_adapter *adap, int addr, int kind)
> +{
> +	struct i2c_client *client;
> +	int rc;
> +	u8 rbuf[1], wbuf[2], msgbuf[1] = { 0 }; /* offset into rtc's regs */
> +	struct i2c_msg msgs[] = {
> +		{ 0, 0, 1, msgbuf },
> +		{ 0, I2C_M_RD, 1, rbuf }
> +	};
> +
> +	client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
> +	if (!client)
> +		return -ENOMEM;
> +
> +	strlcpy(client->name, m41txx_driver.driver.name, I2C_NAME_SIZE);
> +	client->addr = addr;
> +	client->adapter = adap;
> +	client->driver = &m41txx_driver;
> +
> +	if ((rc = i2c_attach_client(client)) != 0)
> +		goto attach_err;
> +
> +	msgs[0].addr = addr;
> +	msgs[1].addr = addr;
> +
> +	if (m41txx_chip->type != M41TXX_TYPE_M41T00) {
> +		/* If asked, set SQW frequency & enable */
> +		if (m41txx_chip->sqw_freq) {
> +			msgbuf[0] = m41txx_chip->alarm_mon;
> +			if ((rc = i2c_transfer(client->adapter, msgs, 2)) < 0)
> +				goto sqw_err;
> +
> +			wbuf[0] = m41txx_chip->alarm_mon;
> +			wbuf[1] = rbuf[0] & ~0x40;
> +			if ((rc = i2c_master_send(client, wbuf, 2)) < 0)
> +				goto sqw_err;
> +
> +			wbuf[0] = m41txx_chip->sqw;
> +			wbuf[1] = m41txx_chip->sqw_freq;
> +			if ((rc = i2c_master_send(client, wbuf, 2)) < 0)
> +				goto sqw_err;
> +
> +			wbuf[0] = m41txx_chip->alarm_mon;
> +			wbuf[1] = rbuf[0] | 0x40;
> +			if ((rc = i2c_master_send(client, wbuf, 2)) < 0)
> +				goto sqw_err;
> +		}
> +
> +		/* Make sure HT (Halt Update) bit is cleared */
> +		msgbuf[0] = m41txx_chip->alarm_hour;
> +		if ((rc = i2c_transfer(client->adapter, msgs, 2)) < 0)
> +			goto ht_err;
> +
> +		if (rbuf[0] & 0x40) {
> +			wbuf[0] = m41txx_chip->alarm_hour;
> +			wbuf[1] = rbuf[0] & ~0x40;
> +			if ((rc = i2c_master_send(client, wbuf, 2)) < 0)
> +				goto ht_err;
> +		}
> +	}
> +
> +	/* Make sure ST (stop) bit is cleared */
> +	msgbuf[0] = m41txx_chip->sec;
> +	if ((rc = i2c_transfer(client->adapter, msgs, 2)) < 0)
> +		goto st_err;
> +
> +	if (rbuf[0] & 0x80) {
> +		wbuf[0] = m41txx_chip->sec;
> +		wbuf[1] = rbuf[0] & ~0x80;
> +		if ((rc = i2c_master_send(client, wbuf, 2)) < 0)
> +			goto st_err;
> +	}
> +
> +	INIT_WORK(&set_rtc_time_task, &m41txx_set, &new_time);
> +	save_client = client;
> +	return 0;
> +
> +st_err:
> +	dev_err(&client->dev, "m41txx_probe: Can't clear ST bit\n");
> +	goto attach_err;
> +ht_err:
> +	dev_err(&client->dev, "m41txx_probe: Can't clear HT bit\n");
> +	goto attach_err;
> +sqw_err:
> +	dev_err(&client->dev, "m41txx_probe: Can't set SQW Frequency\n");
> +attach_err:
> +	kfree(client);
> +	return rc;
> +}
> +
> +static int
> +m41txx_attach(struct i2c_adapter *adap)
> +{
> +	return i2c_probe(adap, &addr_data, m41txx_probe);
> +}
> +
> +static int
> +m41txx_detach(struct i2c_client *client)
> +{
> +	int	rc;
> +
> +	if ((rc = i2c_detach_client(client)) = 0) {
> +		kfree(client);
> +		flush_scheduled_work();
> +	}
> +	return rc;
> +}
> +
> +static struct i2c_driver m41txx_driver = {
> +	.driver = {
> +		.owner	= THIS_MODULE,
> +		.name	= M41TXX_DRV_NAME,
> +	},
> +	.id		= I2C_DRIVERID_STM41TXX,
> +	.attach_adapter	= m41txx_attach,
> +	.detach_client	= m41txx_detach,
> +};
> +
> +static int __init
> +m41txx_init(void)
> +{
> +	int rc;
> +
> +	if (!(rc = platform_driver_register(&m41txx_platform_driver)))
> +		rc = i2c_add_driver(&m41txx_driver);
> +	return rc;
> +}
> +
> +static void __exit
> +m41txx_exit(void)
> +{
> +	i2c_del_driver(&m41txx_driver);
> +	platform_driver_unregister(&m41txx_platform_driver);
> +}
> +
> +module_init(m41txx_init);
> +module_exit(m41txx_exit);
> +
> +MODULE_AUTHOR("Mark A. Greer <mgreer at mvista.com>");
> +MODULE_DESCRIPTION("ST Microelectronics M41TXX RTC I2C Client Driver");
> +MODULE_LICENSE("GPL");
> diff -Nurp linux-2.6.16-rc3-mm1/drivers/i2c/chips/Makefile linux-2.6.16-rc3-mm1-m41txx/drivers/i2c/chips/Makefile
> --- linux-2.6.16-rc3-mm1/drivers/i2c/chips/Makefile	2006-02-12 17:27:25.000000000 -0700
> +++ linux-2.6.16-rc3-mm1-m41txx/drivers/i2c/chips/Makefile	2006-02-16 17:23:30.000000000 -0700
> @@ -6,7 +6,6 @@ obj-$(CONFIG_SENSORS_DS1337)	+= ds1337.o
>  obj-$(CONFIG_SENSORS_DS1374)	+= ds1374.o
>  obj-$(CONFIG_SENSORS_EEPROM)	+= eeprom.o
>  obj-$(CONFIG_SENSORS_MAX6875)	+= max6875.o
> -obj-$(CONFIG_SENSORS_M41T00)	+= m41t00.o
>  obj-$(CONFIG_SENSORS_PCA9539)	+= pca9539.o
>  obj-$(CONFIG_SENSORS_PCF8574)	+= pcf8574.o
>  obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
> @@ -14,6 +13,7 @@ obj-$(CONFIG_SENSORS_RTC8564)	+= rtc8564
>  obj-$(CONFIG_ISP1301_OMAP)	+= isp1301_omap.o
>  obj-$(CONFIG_TPS65010)		+= tps65010.o
>  obj-$(CONFIG_RTC_X1205_I2C)	+= x1205.o
> +obj-$(CONFIG_RTC_M41TXX_I2C)	+= m41txx.o
>  
>  ifeq ($(CONFIG_I2C_DEBUG_CHIP),y)
>  EXTRA_CFLAGS += -DDEBUG
> diff -Nurp linux-2.6.16-rc3-mm1/include/linux/i2c-id.h linux-2.6.16-rc3-mm1-m41txx/include/linux/i2c-id.h
> --- linux-2.6.16-rc3-mm1/include/linux/i2c-id.h	2006-02-16 17:21:12.000000000 -0700
> +++ linux-2.6.16-rc3-mm1-m41txx/include/linux/i2c-id.h	2006-02-16 17:23:30.000000000 -0700
> @@ -79,7 +79,7 @@
>  #define I2C_DRIVERID_SAA7114	49	/* video decoder		*/
>  #define I2C_DRIVERID_ZR36120	50     /* Zoran 36120 video encoder	*/
>  #define I2C_DRIVERID_24LC32A	51	/* Microchip 24LC32A 32k EEPROM	*/
> -#define I2C_DRIVERID_STM41T00	52	/* real time clock		*/
> +#define I2C_DRIVERID_STM41TXX	52	/* real time clock		*/
>  #define I2C_DRIVERID_UDA1342	53	/* UDA1342 audio codec		*/
>  #define I2C_DRIVERID_ADV7170	54	/* video encoder		*/
>  #define I2C_DRIVERID_RADEON	55	/* I2C bus on Radeon boards	*/
> diff -Nurp linux-2.6.16-rc3-mm1/include/linux/m41txx.h linux-2.6.16-rc3-mm1-m41txx/include/linux/m41txx.h
> --- linux-2.6.16-rc3-mm1/include/linux/m41txx.h	1969-12-31 17:00:00.000000000 -0700
> +++ linux-2.6.16-rc3-mm1-m41txx/include/linux/m41txx.h	2006-02-16 17:23:30.000000000 -0700
> @@ -0,0 +1,47 @@
> +/*
> + * Definitions for the ST M41Txx family of i2c rtc chips.
> + *
> + * Author: Mark A. Greer <mgreer at mvista.com>
> + *
> + * 2005 (c) MontaVista Software, Inc. This file is licensed under
> + * the terms of the GNU General Public License version 2. This program
> + * is licensed "as is" without any warranty of any kind, whether express
> + * or implied.
> + */
> +
> +#ifndef _M41TXX_H
> +#define _M41TXX_H
> +
> +#define	M41TXX_DRV_NAME		"m41txx rtc"
> +#define	M41TXX_I2C_ADDR		0x68
> +
> +#define	M41TXX_TYPE_M41T00	0
> +#define	M41TXX_TYPE_M41T81	81
> +#define	M41TXX_TYPE_M41T85	85
> +
> +struct m41txx_platform_data {
> +	u16	type;
> +	u16	i2c_addr;
> +	u32	sqw_freq;
> +};
> +
> +/* SQW output disabled, this is default value by power on*/
> +#define SQW_FREQ_DISABLE	(0)
> +
> +#define SQW_FREQ_32KHZ	(1<<4)		/* 32.768 KHz */
> +#define SQW_FREQ_8KHZ	(2<<4)		/* 8.192 KHz */
> +#define SQW_FREQ_4KHZ	(3<<4)		/* 4.096 KHz */
> +#define SQW_FREQ_2KHZ	(4<<4)		/* 2.048 KHz */
> +#define SQW_FREQ_1KHZ	(5<<4)		/* 1.024 KHz */
> +#define SQW_FREQ_512HZ	(6<<4)		/* 512 Hz */
> +#define SQW_FREQ_256HZ	(7<<4)		/* 256 Hz */
> +#define SQW_FREQ_128HZ	(8<<4)		/* 128 Hz */
> +#define SQW_FREQ_64HZ	(9<<4)		/* 64 Hz */
> +#define SQW_FREQ_32HZ	(10<<4)		/* 32 Hz */
> +#define SQW_FREQ_16HZ	(11<<4)		/* 16 Hz */
> +#define SQW_FREQ_8HZ	(12<<4)		/* 8 Hz */
> +#define SQW_FREQ_4HZ	(13<<4)		/* 4 Hz */
> +#define SQW_FREQ_2HZ	(14<<4)		/* 2 Hz */
> +#define SQW_FREQ_1HZ	(15<<4)		/* 1 Hz */
> +
> +#endif /* _M41TXX_H */
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors at lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

