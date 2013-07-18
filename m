From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 18 Jul 2013 00:57:44 +0000
Subject: Re: [lm-sensors] [PATCH v3 1/4] i2c: Add DIMM bus code
Message-Id: <CALCETrW5vVMxzERAj9+vQnmmq2L0xZgmG5tqQeG4oi9qzdCP7g@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1374093761.git.luto@amacapital.net> <b8e50b55358b4f0cd1db96174a9e6a2e69780359.1374093761.git.luto@amacapital.net>
 <20130717222349.GD990@roeck-us.net> <CALCETrVCotmG2PCQUF1BaAcbvnysMbS-kE4SJHoSokgzaML0jg@mail.gmail.com>
In-Reply-To: <CALCETrVCotmG2PCQUF1BaAcbvnysMbS-kE4SJHoSokgzaML0jg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, James Ralston <james.d.ralston-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Some thoughts on an alternative solution below:

On Wed, Jul 17, 2013 at 4:04 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Wed, Jul 17, 2013 at 3:23 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>> On Wed, Jul 17, 2013 at 01:53:05PM -0700, Andy Lutomirski wrote:
>>> Add i2c_scan_dimm_bus to declare that a particular i2c_adapter
>>> contains DIMMs.  This will probe (and autoload modules!) for useful
>>> SMBUS devices that live on DIMMs.
>>>
>>> As more SMBUS-addressable DIMM components become supported, this
>>> code can be extended to probe for them.
>>>
>> I don't think this code is necessary. The temperature sensor would be
>> auto-detected if you mark the bus driver as I2C_CLASS_HWMON, and DIM eeprom
>> auto-detection should not be needed.
>
> I'm not at all sure I want to mark this thing I2C_CLASS_HWMON.  I
> don't want random hwmon drivers probing the bus.  (Although I wouldn't
> need to -- jc42 is looking for I2C_CLASS_SPD.)
>
> Also, my code is IMO better than the i2c core probing code for several reasons:
>
>  - i2c_imc is incompatible with the i2c core class-based detection
> code because it can't do a read byte operation.  I believe that,
> because of exactly this limitation, devices soldered onto DIMMs are
> unlikely to ever require this operation.  (LGA2011 is the premier
> platform for interesting DIMM-like devices right now.)  So I'd have to
> modify the i2c core with more nasty hard-coded lists of what can be
> safely probed how, and ISTM that kind of thing is better handled in
> code that runs on busses that are really known to contain DIMMs (and
> not, say, i2c-gpio).
>
>  - The eventual goal is to write a driver for NVDIMMs, which will also
> appear on this bus, and I want them to pull in the right drivers via
> modalias and udev, which the i2c core code can't do.  To do this well,
> I'll want the SMBUS driver to pass in (via platform-data) information
> on which DIMM channel is which, and I don't know any way to do
> anything like that without using i2c_new_device.

Perhaps i2c_adapter could have a new field for this purpose.  For DIMM
busses it could store topology information.  Then any clients
instantiated on the bus could read it to figure out where they are.

>
>  - Busses like i2c_i801 may or may not contain DIMMs.  They do on some
> machines I have.  But on my Core i7 Extreme box, there are no DIMMs on
> that bus, and there are no SPDs on that bus (i.e. addresses 0x50
> through 0x57 don't answer), but there is an unknown device at address
> 0x19.  I don't really want to think about whether it's safe to probe
> by, say, read_word_data(0).  When NVDIMMs show up, even more bizarre
> addresses may be populated.  My code can probe *carefully* by looking
> for SPDs first, whereas the i2c-core code is not nearly as careful.
>
> One option would be to move code like this into the core and replace
> I2C_CLASS_SPD with something like it.  That way everything could get
> the benefit of DIMM-specific probing.

What if the core code got a little smarter than just matching
arbitrary bits in the class?  For example, if the adapter is
I2C_CLASS_SPD, then the core could look for eeproms (and optionally
instantiate them itself instead of relying on the eeprom driver being
loaded).  Or, more generally, adapters could have a list of named
classes, and there could be a module or something for each class that
knows how to probe and instantiate devices of that class.  So the
class "nvdimm" could instantiate whatever it needs to instantiate, the
class "tsod" could instantiate jc42 instances, etc.  (I'm pretty sure
I'll eventually want nvdimm to be autoloaded, it may want to depend on
the eeprom driver somehow in case I need to read the SPD data -- I'm
not sure yet.)

I guess the logic of "probe 0x50, then, if there's an eeprom there,
probe 0x18 for jc42" isn't perfect.  For example, lm90 can live at
0x18 or 0x19, and if there are DIMMs on the same segment as an lm90,
then it's possible for a jc42 and an lm90 to collide.  So if my bus
were I2C_CLASS_SPD | I2C_CLASS_DIMM, then perhaps the jc42 (and core)
code could probe more aggressively.

--Andy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
