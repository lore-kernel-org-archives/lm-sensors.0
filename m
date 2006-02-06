From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 06 Feb 2006 15:41:39 +0000
Subject: [lm-sensors] New abituguru driver using platform_device
Message-Id: <Jv3VPvWU.1139240499.6800470.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <43E4ABF8.4010201@hhs.nl>
In-Reply-To: <43E4ABF8.4010201@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Hans,

On 2006-02-04, Hans de Goede wrote:
> The subject says it all, could someone review this one please? And can
> we then get some movement with regards to upstreaming this?

Thanks a lot for having converted your driver to a platform driver so
quickly, this is very much appreciated. See my comments below, after
you've addressed them I'll consider the driver for inclusion into -mm.

> If you prefer a patch including docs and the necessary makefile mods
> please lett me know against which tree and howto get this tree.

This is a requirement actually. I can't merge anything but proper
patches. You would base such a patch on Andrew's latest -mm. In the
case of the uguru, I also make it a requirement that the patch adds you
to MAINTAINERS as the maintainer of the driver. Also don't forget to
tag the driver EXPERIMENTAL in Kconfig.

The documentation must come in a patch format too, but could be a
separate patch.

Also make sure you include a Signed-off-by line in your mail, as
mentioned in Documentation/SubmittingPatches

Here come my comments on your code:

> /*
>     abituguru.c - Part of lm_sensors, Linux kernel modules
>                   for hardware monitoring

No, it's not part of lm_sensors. Many drivers have this comment as a
legacy from the Linux 2.4 version - but new drivers shouldn't say that.

>     Copyright (c) 2005 Hans de Goede <j.w.r.degoede at hhs.nl>

You may want to add 2006 now.

> /* This is needed untill this gets merged upstream */
> #ifndef SENSOR_ATTR_2
> #define SENSOR_ATTR_2(_name, _mode, _show, _store, _nr, _index)	\
> 	{ .dev_attr = __ATTR(_name, _mode, _show, _store),	\
> 	  .index = _index,					\
> 	  .nr = _nr }
> #endif

This has been merged upstream, so don't include it here.

> #define ABIT_UGURU_PRINTK(level, format, arg...)			\
> 	do {							\
> 		if (level <= verbose) {				\
> 			if (level = 1)				\
> 			      printk(KERN_WARNING ABIT_UGURU_NAME ": "\
> 					format , ## arg);		\
> 			else if (level = 2)			\
> 				printk(KERN_INFO ABIT_UGURU_NAME ": "\
> 					format , ## arg);		\
> 			else					\
> 				printk(KERN_DEBUG ABIT_UGURU_NAME ": "\
> 					format , ## arg);		\
> 		}						\
> 	} while (0)

I see very little interest in letting the user hide warnings and
informational messages. It's even a dangerous feature for warnings.
Additionally, you must use dev_warn, dev_info and dev_dbg to print
messages whenever possible, not printk directly.

> /* Constants */
> /* in (Volt) sensors go up to 3494 mV, temp to 255000 milli degrees
>    celcius */
> const int abituguru_bank1_max_value[2] = { 3494, 255000 };
> /* Register 0 is a bitfield, 1 and 2 are pwm settings (255 = 100%), 3 and
>    4 are temperature trip points. */
> const int abituguru_pwm_settings_multiplier[5] = { 0, 1, 1, 1000, 1000 };

These should be declared static.

> /* Default verbose is 4, since this driver is still in the testing fase */

Typo: phase.

> static int verbose = 4;
> module_param(verbose, int, 0);
> MODULE_PARM_DESC(verbose, "How verbose should the driver be? (0-5):\n"
> 	"   0 no output at all\n"
> 	"   1 + warnings\n"
> 	"   2 + normal output\n"
> 	"   3 + standard debug output\n"
> 	"   4 + sensors type probing info\n"
> 	"   5 + retryable errors");

Maybe you could let the user change it after load with:
module_param(verbose, int, 0644);

Also, as said above, I think that modes 0 and 1 should not exist at all.

>   unsigned char update_timeouts; /* number of update timeouts since last
> 					   successfull update. */

Typo: successful.

> static int abituguru_wait(struct abituguru_data *data, u8 state)
> {
> 	int timeout = ABIT_UGURU_WAIT_TIMEOUT;
> 
> 	while (inb_p(data->addr + ABIT_UGURU_DATA) != state)
> 	{

Coding style!

> 		timeout--;
> 		if (timeout = 0)
> 			return -EBUSY;
> 	}
> 	return 0;
> }

Hm, this is a busy waiting loop. Not recommended. Why don't you msleep()
between retries? Or at the very least yield()? In both cases, the
timeout should be a duration rather than a number of tries.

>  while(inb_p(data->addr+ABIT_UGURU_DATA) != ABIT_UGURU_STATUS_INPUT){

Coding style: missing spaces.

> 	if (!data->uguru_ready && (abituguru_ready(data) != 0))
> 			return -EIO;

The first check is redundant, abituguru_ready() starts with the same
check.

> 			ABIT_UGURU_PRINTK(3, "timeout exceeded "
> 				"waiting for more input state "
> 				"(bank: %d)\n", (int)bank_addr);

The cast shouldn't be needed (you may need %u instead of %d). Same in
various other places.

> 	if (abituguru_write(data, ABIT_UGURU_SENSOR_BANK1+2,
> 		sensor_addr, data->bank1_settings[sensor_addr],
> 		3) != 3)	return -EIO;

Coding style.

> 	if (abituguru_write(data, ABIT_UGURU_SENSOR_BANK1+2, sensor_addr,
> 			buf,3) != 3)

Coding style: missing space.

> 	if (abituguru_write(data, ABIT_UGURU_SENSOR_BANK1+2, sensor_addr,
> 		data->bank1_settings[sensor_addr], 3) != 3)	return -EIO;

Coding style: missing new line.

> return sprintf(buf,"%d\n",(data->bank1_settings[attr->index][attr->nr]*
> 	data->bank1_max_value[attr->index] + 128) / 255);

Coding style: missing spaces. Same in many other places.

> 	return sprintf(buf, "%d\n",  (data->bank2_value[attr->index]*
> 		ABIT_UGURU_FAN_MAX + 128) / 255);

Coding style: doubled space.

> 		if ( (data->bank2_settings[i][0] != orig_val) &&
> 		     (abituguru_write(data, ABIT_UGURU_SENSOR_BANK2+2,
> 				i, data->bank2_settings[i], 2) < 1) ) {

Coding style: extra spaces. Same in a few other places.

> 	unsigned long val = simple_strtoul(buf, NULL, 10) - 1;

Doesn't look safe: if the input value is "0", you end up with val ~0. Is it what you want?

> static struct sensor_device_attribute_2 abituguru_sysfs_attr[] = {
> 	SENSOR_ATTR_2(fan1_input,  0444, show_bank2_value, NULL, 0, 0),

Do not use spaces for alignment please. Use tabs.

> 	u8 data_val = inb_p(ABIT_UGURU_BASE + ABIT_UGURU_DATA);

You don't use this value anywhere?

> 	int i,j,res,err = 0;

Coding style: missing spaces.

> 	const u8 probe_order[16] = {
> 		0x00,0x01,0x03,0x04,0x0A,0x08,0x0E,0x02,
> 		0x09,0x06,0x05,0x0B,0x0F,0x0D,0x07,0x0C };

Ditto.

> ERROR1:
> 	kfree(data);
> ERROR0:
> 	return err;

Please rename these labels to something more explicit (like exit_free...)

> 	data->bank1_attr[i*3   ].dev_attr.attr.mode  = 0444;
> 	data->bank1_attr[i*3   ].dev_attr.attr.owner = THIS_MODULE;
> 	data->bank1_attr[i*3   ].dev_attr.show  = show_bank1_value;
> 	data->bank1_attr[i*3   ].dev_attr.store = NULL;
> 	data->bank1_attr[i*3   ].index = probe_order[i];
> 	data->bank1_attr[i*3 +1].dev_attr.attr.mode  = 0644;
> 	data->bank1_attr[i*3 +1].dev_attr.attr.owner = THIS_MODULE;
> 	data->bank1_attr[i*3 +1].dev_attr.show  = show_bank1_setting;
> 	data->bank1_attr[i*3 +1].dev_attr.store = store_bank1_setting;
> 	data->bank1_attr[i*3 +1].index = probe_order[i];
> 	data->bank1_attr[i*3 +1].nr = 1;
> 	data->bank1_attr[i*3 +2].dev_attr.attr.mode  = 0644;
> 	data->bank1_attr[i*3 +2].dev_attr.attr.owner = THIS_MODULE;
> 	data->bank1_attr[i*3 +2].dev_attr.show  = show_bank1_setting;
> 	data->bank1_attr[i*3 +2].dev_attr.store = store_bank1_setting;
> 	data->bank1_attr[i*3 +2].index = probe_order[i];
> 	data->bank1_attr[i*3 +2].nr = 2;

Naaah, really, you don't make things clearer with all this alignment
masquerade. Rather the contrary.

> 	for (i = 0; i < (sizeof(abituguru_sysfs_attr)/
> 			sizeof(struct sensor_device_attribute_2)); i++)

Use the ARRAY_SIZE macro please.

> 		data->last_updated = jiffies;
> (...)
> 	/* upon error force the next update */
> 	if (res != 1)
> 		data->last_updated = jiffies - (unsigned long)HZ;

Why don't you just wait for the end of the (successful) update before
setting data->last_updated?

> 	if ( ((data_val = 0x00) || (data_val = 0x08)) &&
> 	     ((cmd_val  = 0x00) || (cmd_val  = 0xAC)) )
> 		return ABIT_UGURU_BASE;

Coding style: drop the extra spaces.

> 			printk(KERN_INFO "Asuming Abit uGuru is present "
> 				"because of \"force\" parameter\n");

Typo: assuming.

> module_init(sm_abituguru_init);
> module_exit(sm_abituguru_exit);

Please drop the "sm_" prefix, some old drivers have it but I don't
even know what it is supposed to mean.

--
Jean Delvare

