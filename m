From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 20 Oct 2005 13:10:17 +0000
Subject: [lm-sensors] feedback request: i2c bus and v4l driver for PCRadio
Message-Id: <bXQipkRR.1129805743.9384390.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <opsik3vcn0bj4yoq@mailhost.ics.ele.tue.nl>
In-Reply-To: <opsik3vcn0bj4yoq@mailhost.ics.ele.tue.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Szymon,

> /usr/src$> diffstat spase.diff
>  i2c/busses/Kconfig            |   11
>  i2c/busses/Makefile           |    1
>  i2c/busses/i2c-spase.c        |  213 +++++++++++
>  media/radio/Kconfig           |    7
>  media/radio/Makefile          |    1
>  media/radio/radio-spase-i2c.c |  754 +++++++++++++++++++++++++++++++++++
>  6 files changed, 987 insertions(+)
> /usr/src$>

A quick note first: why would you have two separate modules, and why
would the I2C bus part be in drivers/i2c/busses? We usually put there
drivers for motherboard I2C busses or SMBus masters, which can be found
on a variety of boards and may have about any chip on them depending on
the board. For I2C busses which are part of a daughter board, it makes
more sense to let the driver live in the proper subsystem (I2C busses on
graphics adapters are most often part of framebuffer drivers in
drivers/video, I2C busses on video adapters are found in
drivers/media/video).

The rationale is that these busses are part of the core hardware design
of these adapters, and you can't use them at all if you don't have a
driver for this bus. Likewise, compiling only the I2C bus driver part
will not be useful, as it only exists on this one radio adapter.

So I would like you to redesign your code to only add code to
drivers/media/radio. It is OK to have two source code files (say
radio-spase.c and radio-spase-i2c.c) but they would be used to generate
a single driver and the user should have a single configuration option
to select in order to be able to use his/her radio device.

And now, my comments on the code itself. Note that I can really only
comment on the i2c part, for the rest you should get in touch with the
media/radio and/or media/video folks.

> --- kernel-source-2.6.8/drivers/i2c/busses/i2c-spase.c
> +++ linux/drivers/i2c/busses/i2c-spase.c

You really should port this to a recent kernel. 2.6.8 is old, there have
been quite a few changes in the i2c subsystem since then, and I'm
pretty sure your driver wouldn't work out of the box.

> +/*
> ------------------------------------------------------------------------ *
> + * i2c-spase-bit.c I2C bus present on the board of PCRadio
> Spase-003            *

This doesn't match the actual filename.

> +   Based on older i2c-parport.c driver and radio-spase.c by Michiel
>    Ronsse <ronsse@elis.rug.ac.be>

i2c-parport.c is not old, it was written specifically for Linux 2.6. And
it wasn't written by Michiel Ronsse, but by me.

> +#include <linux/config.h>

Where do you need this?

> +#include <linux/proc_fs.h>    /* /proc interface              */

I hope you don't actually need this.

> +#define DEFAULT_BASE 0x1B0

Please align the value with a tab, like you did for the three other ones
below.

> +#define SPASE_SCLK	0x00000001
> +#define SPASE_SDAT	0x00000002
> +#define SPASE_SDAT_OE	0x00000004

> +/* #define PROC_READ */
> +

What this? Drop.

> +#define I2C_HW_B_SPASE	0xff	/* Parallel port Philips style
>   adapter */

Comment is out of date. This define doesn't belong there anyway, it
should be in include/linux/i2c-id.h.

> +static int proc = 1;
> (...)
> +struct proc_dir_entry *proc_entry;
> (...)
> +MODULE_PARM(proc, "i");
> +MODULE_PARM_DESC(proc, "enable /proc/i2c status entry  (set to 1 to
> enable)");

You must be kidding. Don't put garbage in /proc. Use sysfs if you need a
user-space interface. Or log messages. Or debugfs, or whatever, but not
procfs.

> +static inline void port_write(unsigned char d)
> +{
> +	outb(d, base);
> +}
> +
> +static inline unsigned char port_read(void)
> +{
> +	return inb(base);
> +}
> +
> +/* ----- Unified line operation functions
>     --------------------------------- */
> +
> +static inline void line_set(int state, unsigned char d)
> +{
> +	if(state)
> +		cur_state |= d;
> +	else
> +		cur_state &= ~d;
> +
> +	port_write(cur_state);
> +}
> +
> +static inline int line_get(void)
> +{
> +	return (SPASE_SDAT_OE & port_read()) = SPASE_SDAT_OE;
> +}
> +
> +/* ----- I2C algorithm call-back functions and structures
>     ----------------- */
> +
> +static void spase_setscl(void *data, int state)
> +{
> +	line_set(state, SPASE_SCLK);
> +}
> +
> +static void spase_setsda(void *data, int state)
> +{
> +	line_set(state, SPASE_SDAT);
> +}
> +
> +static int spase_getsda(void *data)
> +{
> +	return line_get();
> +}

This is uselessy complex if you want my opinion. Please merge line_get
into spase_getsda, and port_write and port_read into line_set and
line_get, respectively.

> +/* Encapsulate the functions above in the correct structure
> +	 Note that getscl will be set to NULL by the attaching code for
>     adapters
> +	 that cannot read SCL back */

Once again, this copied comment doesn't make sense here. You are setting
it to NULL yourself, not the attaching code.

> +static struct i2c_algo_bit_data spase_algo_data = {
> +	.setsda		= spase_setsda,
> +	.setscl		= spase_setscl,
> +	.getsda		= spase_getsda,
> +	.getscl		= NULL, /* spase_getscl,*/

You don't need to explicitely set it to NULL, BTW, the compiler would do
it for you. Also, the comment is needless. If the adapter doesn't
support SCL readback, no spase_getscl function will ever exist. If OTOH
readback is possible, you want to implement it right now. It helps bus
stability.

> +static struct i2c_adapter spase_adapter = {
> +	.owner		= THIS_MODULE,
> +	.class		= I2C_CLASS_HWMON,

Are there REALLY hardware monitoring chips on this bus? I2C_CLASS_SOUND
seems more appropriate, or we could even define I2C_CLASS_RADIO if
needed.

> +	.id		= -1, /* FIXME !!!!! I2C_HW_B_SPASE, */

It says "fix me". Maybe you could actually fix it before submitting
your patch?

> +	.algo_data	= &spase_algo_data,
> +	I2C_DEVNAME("PCRadio Spase-003 adapter"),

This macro is gone in recent kernels. Set .name explicitely.

> +static int read_proc(char *buf, char **start, off_t offset,
> +		     int len, int *eof, void *data )
> +{
> +	*start = 0;
> +	*eof   = 1;
> +
> +	return sprintf(buf,
> +		"Type:       SPASE PCRadio-003 i2c port device\n"
> +		"IO-port: 0x%x\n"
> +		"\n"
> +		"state:   0x%x\n"
> +		"  SDA   %s   |\\           \n"
> +		"      ______| \\_____ ____  \n"
> +		"            | /     T     \n"
> +		"            |/      |     \n"
> +		"  SDA   %s     /|    |     \n"
> +		"      _______/ |____|    \n"
> +		"             \\ |         \n"
> +		"              \\|         \n"
> +		"                         \n"
> +		"  SCL   %s   |\\           \n"
> +		"      ______| \\_____     \n"
> +		"            | /          \n"
> +		"            |/           \n"
> +		"SDA line:       %s -> %s\n"
> +		"SCL line:       %s\n",
> + 		base,
> +		cur_state,
> +		(cur_state & SPASE_SDAT)?("H"):("L"),
> +#ifdef PROC_READ
> +		(line_get()?("H"):("L")),
> +#else
> +		"*",
> +#endif
> +		(cur_state & SPASE_SCLK)?("H"):("L"),
> +		(cur_state & SPASE_SDAT)?("H"):("L"),
> +#ifdef PROC_READ
> +		(line_get()?("H"):("L")),
> +#else
> +		"*",
> +#endif
> +		(cur_state & SPASE_SCLK)?("H"):("L")
> +		);
> +}

You are not seriously thinking we would accept this in the kernel? ASCII
art in /proc files! What next?

Anyway, looks like debug stuff. As I said above, no way this belongs to
procfs. Use dev_dbg().

> +	/* Other init if needed (power on...) */

This comment doesn't seem to apply here.

> +	if(proc)
> +		if((proc_entry = create_proc_entry("i2c", 0, NULL )))
> +			proc_entry->read_proc = read_proc;
> +

Kill this.

> +	if (proc_entry)
> +		remove_proc_entry("i2c", NULL);

And this.

--
Jean Delvare
