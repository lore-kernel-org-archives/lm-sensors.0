From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: We will port w83792d.c to linux-2.6
Message-Id: <Itz1Y6LL.1109587824.9010970.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Chunhao,

> During the porting of w83792d driver, we have two questions here:
> (1) The sysfs interface in linux-2.6.10/Documentation/i2c/sysfs-interface
> is not enough for w83792d driver, we want to add some other interfaces,
> which are about Winbond Smart Fan(SmartFan I and SmartFan II).
> You may refer to w83792d for linux-2.4, it also has the interfaces about
> Smart Fan.
> Could you give me some guidance on how to add some new sysfs interface?
> Need we ask for the permission from LM_Sensors group or Linux kernel group?

I just took a look at the datasheet. It happens that Smart Fan II fits
rather good in the auto-fan-speed-control scheme currently defined in
the 2.6 kernel, so it shouldn't be a problem. The only difference is
that for each trip point, we define a high temperature limit and an
hysteresis temperature, while the W83792D chip defines a medium limit
with a tolerance. It's just a matter of arithmetics to convert from one
to the other.

Smart Fan I, aka cruise mode, doesn't quite fit in the model, although
it could be seen as an approximate subset of Smart Fan II. I see little
reason to implement Smart Fan I when Smart Fan II is so obviously
better, so I wouldn't implement it at all.

The only thing I think is missing the the sysfs interface for the W83792D
is the possibility to switch from PWM to DC and back. I would propose
new files named "pwmN_mode", that would have possible values "PWM"
and "DC". This however needs to be discussed, and approval by the
majority of i2c/lm_sensors devs is required (this is obviously
sujective).

> (2) In linux-2.4, the interface in /proc can be edited directly by "vi"
> command, But it seems that in linux-2.6, the interface in /sys can NOT,
> error message will appear when save:
> "/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002f/in3_max" E667: Fsync
> failed
>
> So, In linux-2.6, if we want to build some application later, how to use
> the sysfs interface directly instead of using the libsensors? In linux-2.4,
> it's possible.

I didn't know it was even possible to use vi directly on procfs files,
and frankly I wouldn't do it, since these are NOT regular files, and
sometimes you have to write in a different format than you read from
these files. Just use "echo", it should work just fine with both
procfs and sysfs files, I'm using it all the time. You may also use
"cat" to/from these files.

I took some time to review your current 2.4 driver and here are my
comments:

1* Use static arrays for registers. For example:

> #define W83792D_REG_IN0 0x20     /* Vcore A in DataSheet */
> #define W83792D_REG_IN1 0x21     /* Vcore B in DataSheet */
> #define W83792D_REG_IN2 0x22     /* VIN0 in DataSheet */
> #define W83792D_REG_IN3 0x23     /* VIN1 in DataSheet */
> #define W83792D_REG_IN4 0x24     /* VIN2 in DataSheet */
> #define W83792D_REG_IN5 0x25     /* VIN3 in DataSheet */
> #define W83792D_REG_IN6 0x26     /* 5VCC in DataSheet */
> #define W83792D_REG_IN7 0xB0     /* 5VSB in DataSheet */
> #define W83792D_REG_IN8 0xB1     /* VBAT in DataSheet */

becomes:

static const u8 W83792D_REG_IN = {
	0x20, /* Vcore A in datasheet */
	0x21, /* Vcore B in datasheet */
	0x22, /* VIN0 in datasheet */
	0x23, /* VIN1 in datasheet */
	0x24, /* VIN2 in datasheet */
	0x25, /* VIN3 in datasheet */
	0x26, /* 5VCC in datasheet */
	0xB0, /* 5VSB in datasheet */
	0xB1, /* VBAT in datasheet */
};

The advantage is that you can then refactor code like this:

> /* Update the Voltages/High Limit/Low Limit */
> data->in[0] = w83792d_read_value(client, W83792D_REG_IN0);
> data->in[1] = w83792d_read_value(client, W83792D_REG_IN1);
> data->in[2] = w83792d_read_value(client, W83792D_REG_IN2);
> data->in[3] = w83792d_read_value(client, W83792D_REG_IN3);
> data->in[4] = w83792d_read_value(client, W83792D_REG_IN4);
> data->in[5] = w83792d_read_value(client, W83792D_REG_IN5);
> data->in[6] = w83792d_read_value(client, W83792D_REG_IN6);
> data->in[7] = w83792d_read_value(client, W83792D_REG_IN7);
> data->in[8] = w83792d_read_value(client, W83792D_REG_IN8);

becomes:

int i;
for (i = 0; i < 9; i++)
	data->in[i] = w83792d_read_value(client, W83792D_REG_IN[i]);

Which is both less error-prone and more efficient. You can do the same
change for almost all register sets. If you do, you'll see that the
driver will become much smaller!

2* You sometimes give different names to the same register:

> #define W83792D_REG_FAN1_TOL 0x87	/* (bit3-0)SmartFan Fan1 tolerance */
> #define W83792D_REG_FAN2_TOL 0x87	/* (bit7-4)SmartFan Fan2 tolerance */

This is a bad idea, because you then do:

> /* Update Smart Fan I/II tolerance */
> data->fan_tolerance[0] >     w83792d_read_value(client, W83792D_REG_FAN1_TOL) & 0x0f;
> data->fan_tolerance[1] >     (w83792d_read_value(client, W83792D_REG_FAN2_TOL)>>4) & 0x0f;

You actually read the same register twice in a row! Since SMBus reads are
rather slow, this introduces a performance penalty. You should instead
do:

#define W83792D_REG_FAN1_TOL 0x87	/* bits 3-0: SmartFan Fan1 tolerance
					   bits 7-4: SmartFan Fan2 tolerance */

int temp = w83792d_read_value(client, W83792D_REG_FAN1_TOL);
data->fan_tolerance[0] = temp & 0x0f;
data->fan_tolerance[1] = temp >> 4;

That way you read the register only once.

3* Do not define nor use w83792d_id. It has been removed from most other
drivers because it is in fact useless.

4* That comment:
> /* For each registered W83792D, we need to keep some data in memory. That
>    data is pointed to by w83792d_list[NR]->data. The structure itself is
>    dynamically allocated, at the same time when a new w83792d client is
>    allocated. */
is bogus and should be deleted

5* Maybe you should leave some values for W83792D_SYSCTL_PWM4-7 in case
they are implemented later.

6* Initialization to 0 is usless:

> static int w83792d_attach_adapter(struct i2c_adapter *adapter)
> {
> 	int i_tmp = 0;
> 	ENTER()
> 
> 	i_tmp = i2c_detect(adapter, &addr_data, w83792d_detect);

7* This can go away completely:

> #ifdef W83792D_DEBUG
> 	if (i2c_is_isa_adapter(adapter))
> 	{
> 		printk("w83792d.o: Called for an ISA bus adapter, aborting.\n");
> 		LEAVE()
> 		return 0;
> 		/* This should NOT happen! because 792 chip
> 		   only appears on I2C instead of ISA. */
> 	}
> #endif

The i2c_check_functionality right after that will discard the ISA bus
case.

8* Each printk should use one of the KERN_ERR, KERN_DEBUG, KERN_WARNING
or KERN_INFO constant. Also, don't use "w83792d.o" in the messages
but only "w83792".

9* It looks like you only use bank 0 of the W83792D chip, and that
registers in bank 1 are unlikely to be ever used, Also, all register
seem to be byte-sized. This means that you could simplify the
w83792d_read_value and w83792d_write_value functions: get rid of the
lock, get rid of the bank, use u8 instead of u16 and get rid of the
bitmasking. In fact you'll end up with very simple functions just
calling one ambus function.

10* In w83792d_update_client, you declare variables (reg0-3) in the
middle of a block. Older gcc compilers will not accept it, so for best
compatibility you should declare them at the beginning of the block.

11* In several callback functions, you define nr = ctl_name -
W83792D_SYSCTL_SOMETHING + 1, then use nr - 1 everywhere in the
function. It would be both more efficient and more readable to define nr
= ctl_name - W83792D_SYSCTL_SOMETHING and use nr everywhere after that.

I hope that my comments will help you improve your driver.

Thanks,
--
Jean Delvare
