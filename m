From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 19 Oct 2008 16:20:00 +0000
Subject: Re: [lm-sensors] Using hwmon in-kernel
Message-Id: <20081019182000.29e50529@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081008003041.GA20169@srcf.ucam.org>
In-Reply-To: <20081008003041.GA20169@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Matthew,

On Wed, 8 Oct 2008 01:30:41 +0100, Matthew Garrett wrote:
> I'm possibly missing something here, but. I'm working on improving the 
> thermal management of nvidia cards in nouveau. I've got I2C up and 
> running and I can bind appropriate hwmon drivers to the chips and read 
> temperatures. I've got a couple of remaining problems:
> 
> 1) I know the offsets that need to be applied to the lm99 sensors. How 
> do I do that in-kernel?

Depends on what you're speaking of exactly. If you refer to the +16
degrees offset that must be applied to all LM99 readings per hardware
design, the problem is that the LM89 can't be differentiated from the
LM99 by probing (they have the same die revision code register value.)
The LM99 needs the +16 degrees offset while the LM89 doesn't, so it
isn't possible to get both right when the devices are auto-detected.
For this reason, I decided to not handle the offset in the lm90 driver.
Instead, it is handled in user-space using a compute statement
in /etc/sensors.conf, assuming that users know whether they have an
LM89 or LM99 chip.

As the lm90 driver has been converted to a new-style i2c device driver,
it is now possible to explicitly instantiate an LM89 or LM99 chip,
without relying on auto-detection. So I admit that it would make sense
to handle the +16 degrees offset in the driver for the LM99. This will
cause some compatibility issues during the transition period though, as
using a recent lm90 driver with an old sensors.conf file will report a
temperature 16 degrees higher than it really is.

If you instead refer to a board-specific offset that should be applied
to compensate for the distance between the thermal sensor and the
graphics core, or for a non-standard thermal diode, the lm90 driver
exposes attribute temp2_offset so user-space can set and read the
temperature offset.

> 2) How do I read the temperature in-kernel? This only seems to be 
> exported via sysfs, which is obviously not ideal (I'm not willing to 
> leave the thermal management up to userspace).

You are right, there is no in-kernel interface to read temperature
values, only a sysfs interface. The reason for that is that in most
cases, the kernel doesn't have enough information about the wirings to
make the information useful. The labelling and voltage scaling is all
done in user-space.

Why do you want to retrieve the temperature value from the kernel?
Please explain your use case.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
