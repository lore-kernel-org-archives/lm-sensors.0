From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 09 Apr 2007 10:06:21 +0000
Subject: Re: [lm-sensors] asb_100 sensor location in /sys heirarchy changes
Message-Id: <20070409120621.8cfcdbed.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4615F494.6070403@hhs.nl>
In-Reply-To: <4615F494.6070403@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Sun, 08 Apr 2007 20:49:41 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > On Fri, 06 Apr 2007 09:19:48 +0200, Hans de Goede wrote:
> >> Here is what I have on my system:
> >> /sys/bus/i2c/devices/0-0050
> >> /sys/bus/i2c/devices/0-0051
> >>
> >> And here is what I would like to have:
> >> /sys/bus/i2c/devices/viapro-0-0050
> >> /sys/bus/i2c/devices/viapro-0-0051
> >>
> >> The idea here is that the 0 added here is in case one can have multiple 
> >> instances of the same i2c master driver
> > 
> > Which directly points to a weakness in your proposal: if you have two
> > adapters of the same type, they'll get named foo-0 and foo-1. How do
> > you know which is which? You don't, so you only moved the problem one
> > step further, you didn't solve it.
> 
> I agree, but still I think there is some worth in my proposal. For one it makes 
> the problem smaller, for example in case of the poster of the asb_100 problem, 
> it will make the problem go away.

If we decide to change the sysfs naming scheme, this isn't a trivial
change, and we will have to keep the new scheme in place pretty much
forever. Thus making the problem smaller isn't nearly enough. If we
change something, the new scheme must address the problem as a whole,
and as permanently as we can imagine now.

> Also say I have a system with multiple identical masters, for example 2 nvidea 
> cards in SDI. Last time I looked at the device model code (2 years ago) when 
> you would register a new driver, the bus code would do a linear pass along all 
> the devices on the bus (and sub-busses) and see if the driver matched a device, 
> device by device, then upon a match the bus code will call the driver_detect 
> method, and once that has returned, it will go look at the next device on the 
> bus, etc. Thus AFAIK assuming for example PCI masters, foo-0 and foo-1 will 
> always get enumerated in fixed order.

You build the new names stability on the assumption that something else
will keep being stable (here, the order in which a given driver
registers multiple devices). This is exactly what was done before, and
the reason why you are proposing a change. The current device naming
was stable as long as drivers were loaded in a well-defined order,
which pretty much everyone assumed, 5 years ago, would forever be the
case.

If we can't find a naming scheme which is absolutely stable, then I'd
rather live with what we have, and handle the bus number changes in
user-space - where I believe it belongs anyway, and you seem to agree.

> > My understanding is that this is a problem for user-space to solve, it
> > should not assume stable device numbering accross reboots. But it used
> > to be the case and many user-space tools still rely on this.
> 
> After writing my initial mail about this, I've done some more thinking about 
> this and I agree, this should be solved at the userspace level.
> 
> So in our case in libsensors, thus I would like to propose to change the 
> libsensors name format for i2c from chipname-i2c-busnumber-address to
> chipname-i2cmastername-masternumber-address
> 
> So for example. the SPD eeprom at i2c address 50 of my via smbus master would 
> be: "eeprom-i2c_viapro-0-50", Yes i know libsensors doesn't handle eeproms, 
> this is just an example.
> 
> I have also been thinking about ways to give the masters even uniquer names 
> then just numbering indentical masters, but anything I came up with was full of 
> holes.
> 
> The whole idea behind this "exercise" is to be able to make the dmi autoloaded 
> configs more explicit on which chip is located on which bus, and thus not 
> loading any drivers on i2c busses where they might do harm.

You don't actually load a driver "on an i2c bus". You load a driver,
and something decides what devices the driver attaches to. Right now,
that "something" is the hardware monitoring drivers themselves. It
might change in the future, though.

> Which brings me to the question, when insmodding an i2c-client driver, is it 
> possible to tell it which masters to scan?

If the driver uses one of the I2C_CLIENT_INSMOD* macros, yes, you have
fine-grained control over which busses and addresses are scanned. Try
"modinfo lm90" for an example. Additionally, in the case of hardware
monitoring drivers, I2C busses also need to have the I2C_CLASS_HWMON
flag set, otherwise they cannot be probed (not even if forced with a
module parameter, and that's a bug.)

The problem, however, is that these module parameters take I2C bus
numbers. So if the numbers change (and they will certainly change from
one system to the next) the parameters must be altered accordingly.
That's not portable.

Thanks to David Brownell's recent patchset, it should be possible to
replace these module parameters with something else, probably control
files in sysfs. I need some time to write a prototype though, this
probably won't happen before 3 weeks from now. And after that, it'll
take even longer before the drivers are converted to use the new way.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
