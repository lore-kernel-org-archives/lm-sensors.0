From: Trent Piepho <tpiepho@freescale.com>
Date: Wed, 05 Nov 2008 23:14:57 +0000
Subject: Re: [lm-sensors] How to pass board specific info to I2C driver
Message-Id: <Pine.LNX.4.64.0811051317560.3864@t2.domain.actdsltmp>
List-Id: <lm-sensors.vger.kernel.org>
References: <CF6163088BDE8747873ADAA4AF922BF258D76E@zmy16exm21.fsl.freescale.net>
In-Reply-To: <CF6163088BDE8747873ADAA4AF922BF258D76E@zmy16exm21.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 5 Nov 2008, Jean Delvare wrote:
> On Mon, 27 Oct 2008 16:52:06 +0800, Hu Mingkai-B21284 wrote:
> One thing that makes sense to pass to the driver is the chip's work
> voltage, if measurements depend on it. This isn't something libsensors
> handles (nor do I think it should).

This chip basically returns voltage in units of Vdd/1024, where Vdd is the
work voltage.  Can't libsensors scale voltages?  I still think platform data
is the way to go, but it should be possible to do it with libsensors,
shouldn't it?

>> Here is the way I can think of:
>> 1. to use dts file to pass the info to the module.
>>     This way make the driver is bound to OF implement.
>
> I don't think that would make your driver OF-dependent. Every device
> can have platform data associated with it. So you could convert the OF
> data to driver-specific platform data and the driver doesn't even have
> to know that it has been instantiated through OF.

This is a problem that's been brought up before.  What you need is small
driver-specific block of code that turns an OF device node's properties into a
filled in platform data structure.  It's not entirely clear where it should
go, somewhere in drivers/of or somewhere in drivers/hwmon, like in
drivers/hwmon/mcp3021.c?  But that's a small detail.

A bigger problem is that there are a lot of i2c clients, so while writing one
OF binding function isn't a big deal, writing bindings for everything ends up
being a rather large amount of code and a lot of bindings to define.

The problem that doesn't have a clear solution is that i2c clients can have
function pointers in their platform data, like pca953x for example.  You can't
put functions in an OF property.  So what do you do here?

One thing I thought of would be a function that's like i2c_register_board_info(),
but instead:

of_i2c_register_platform_data(const char *node_path, void *platform_data);

The other stuff in struct i2c_board_info (driver_name, type, flags, addr, irq)
isn't needed because it already comes from the OF device tree.  It's only the
platform_data that's a problem.  Instead of binding the data to a device
using the adapter number and device address like i2c_register_board_info()
does, the OF path of the device is used.

Code like this:

static struct pca953x_platform_data pdata = { ... };
static struct i2c_board_info __initdata gpiochips[] = {
 	{ I2C_BOARD_INFO("pca953x", 0x18), .type = "pca9557", .platform_data = &pdata },
};
static int __init add_gpio_chips(void)
{
 	i2c_register_board_info(1, gpiochips, ARRAY_SIZE(gpiochips));
 	/* How do we know the adapter number will be 1?  We don't!  Ugly hack */
}

Becomes this:

static struct pca953x_platform_data pdata = { ... };
static int __init add_gpio_chips(void)
{
 	of_i2c_register_platform_data("/soc8572@e0000000/i2c@3100/gpio", &pdata);
}

The advantage here is that we can provide platform data for any i2c device,
without needing to add device specific OF binding code for each and every
device we might want.  The other advantage is that we can have function
pointers in the platform data, which isn't possible otherwise.

The disadvantage is that the platform data is compiled into the kernel, rather
than in the OF device tree.  But, this is the way platform data has always
worked since it was created.  It's the way it works now.  It's the way non-OF
arches will continue to work.  So maybe it's not ideal, but it's clearly not
the end of the world.

>> 2. to use the module parameter.
>>     For different chips, the work voltage and the ratio may be
>>     different, but the chip uses the same driver.
>
> That's not really practical as you found out yourself. If the platform
> code knows the work voltage and other parameters for the given system
> then filling platform data inside the kernel and passing it to the
> driver is the way to go.

The Vdd parameter can be made an array, one element for each chip.  This is
the standard to pass device data to a driver for something like a PCI card. 
Just run "modinfo bttv" or a hundred other drivers that work this way. 
Problems come up when you want to compile drivers into the kernel, figuring
out which position in the array corresponds to which device, adding or
removing a device changing said positions, and passing function pointers.

Another solution, though I know you're not a fan of it Jean, but I think it's
a great idea when possible, is to make the parameter a settable attribute in
sysfs.  E.g, the mcp3021 driver would have a "vdd" attribute that one could
set to "3300" via sysfs.

That solves a lot of the problems.  Want it in the device tree?  Put it
somewhere and then have a userspace script that grabs
"/proc/device-tree/.../vdd" and puts it into
"/sys/class/hwmon/.../device/vdd".  No kernel code needed.  The mcp3021 driver
doesn't need to know or care about the OF device tree.  On non-OF arches, the
value could come from DMI or anything.

And sometimes it's not so simple as vdd = 3300.  Maybe vdd is specific to each
board and gets measured during production and stored into an eeprom or on
flash?  "cat /mnt/flash/vdd > /sys/.../vdd" is a lot easier to do from
a userspace script than from the kernel!

Or maybe you have a chip with absolute voltage, like an lm87, and a relative
voltage chip like an mcp3021?  Suppose the Vdd to the mcp3021 is one of the
voltages being measured by the lm87?  You could do this, no kernel code
needed:

cat /sys/class/hwmon/hwmon0/device/in0_input > /sys/class/hwmon/hwmon1/device/vdd

And many of these settings don't have obviously correct values.  If you're the
one who has to figure them out, being able to change them while the system is
running is incredibly useful.  Do you remember what it was like to develop
device drivers before Linux had loadable modules?  You had to reboot your
computer for every single compile you wanted to test.  I remember, and I don't
want to go back to that.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
