From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 17 Jul 2013 23:13:52 +0000
Subject: Re: [lm-sensors] [PATCH v3 3/4] tsod: New hwmon driver for Temperature Sensors on DIMM
Message-Id: <CALCETrX+-Jj0rpMeKetVCrWmR01mPM4j6AX1qnOSuFYV5mt45Q@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1374093761.git.luto@amacapital.net> <f358329ff1dd3c3c272cadb4a358a5587cb28e18.1374093761.git.luto@amacapital.net>
 <20130717221902.GC990@roeck-us.net> <CALCETrWQF6p+DveuOxfMhp0r_CrvF=+FOmvfkF-TQ2NVgJ_2aA@mail.gmail.com>
 <20130717230909.GB2120@roeck-us.net>
In-Reply-To: <20130717230909.GB2120-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, James Ralston <james.d.ralston-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andras BALI <drewie-Y8qEzhMunLyT9ig0jae3mg@public.gmane.org>

On Wed, Jul 17, 2013 at 4:09 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Wed, Jul 17, 2013 at 03:49:24PM -0700, Andy Lutomirski wrote:
>> On Wed, Jul 17, 2013 at 3:19 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>> > On Wed, Jul 17, 2013 at 01:53:07PM -0700, Andy Lutomirski wrote:
>> >> Signed-off-by: Andy Lutomirski <luto@amacapital.net>
>> >> ---
>> >
>> > Why don't you just use the existing jc42 driver ?
>>
>> Failure to notice it.  *sigh*.  I assumed that any driver for this
>> device would have "tsod" or "TSOD" somewhere greppable.  I'll at least
>> send a patch to improve the description.
>>
>> That being said, the jc42 driver *writes*.  The iMC controller
>> (AFAICS) uses the data from the TSOD for things like dynamically
>> adjusting the DRAM refresh interval and IMO the kernel has no business
>> at all writing to any registers on the TSOD on this platform.  (FWIW,
>> I tried fiddling with the critical threshold and my box didn't blow up
>> or report thermal trip events.  But still, this scares me a bit.)
>>
> I don't see a problem with that. If the i2c controller supports writes, one can
> perform the write from user space with i2cset, so what is the problem ? Besides,
> jc42 compliant temperature sensors expect to be written to in order to set the
> temperature limits. If you don't like that, you don't have to do it.

Fair enough.

>
>> If I modify the i2c_imc driver to add .class = I2C_CLASS_SPD and get
>> rid of the TSOD probing and load the jc42 module, then it can't
>> actually find my TSODs (because the i2c core isn't capable of probing
>> on the iMC bus).  If I manually add the device, it works.
>>
> You mean it doesn't support the SMBus quick command ? Did you set
> I2C_CLASS_HWMON as well, or just I2C_CLASS_SPD ?

I didn't set I2C_CLASS_HWMON (and I won't -- jc42 is the only hwmon
driver that should ever probe this bus).  The adapter only supports
read byte/word data, write byte/word data, and write byte.  (I'm
pretty sure that the hardware is capable of initiating a read byte
transaction, but not under software control.  I have no idea why write
byte is there without read byte being available, so I didn't implement
it.  I think it's so that you can reset the pointer register after
reading something else, but this is pointless because you don't know
what to reset it to.  This hardware is not exactly a thing of beauty,
but I'm stuck with it.)

>
> If you have the ability to use i2c_board_info, the failure to auto-detect the
> devices should not really matter. In that case you can just use one of the other
> methods to instantiate the i2c devices.

See my other post about dimm_bus.

>
>> But I'd like to keep the enumeration code I wrote around, since the
>> main point of this exercise is to enumerate things that aren't
>> actually hwmon devices.  But I don't want random sensors scripts
>> reprogramming the hardware.  Is the some magic I can work (or should
>> add) with i2c_board_info to force the jc42 driver into a read-only
>> mode?
>>
> Again, that is user space code doing the write, which you can control without
> reverting to a "private" driver. That the driver permits the write doesn't mean
> you have to use it. The only write it always performs is to enable the sensor if
> it is disabled .. which presumably should be ok even for you, since otherwise
> loading the driver doesn't make any sense in the first place.
>

OK, I'm convinced.  I'll scrap my tsod driver.

--Andy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
