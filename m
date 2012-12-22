From: Chris Verges <kg4ysn@gmail.com>
Date: Sat, 22 Dec 2012 07:37:29 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] lm73: detect i2c bus errors before scnprintf()
Message-Id: <CAG4_upQ2858eBu5UZd-0PfNnjYu3M9gA+1OutKkhQ7PpKdCBSA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1356083914-17579-1-git-send-email-kg4ysn@gmail.com>
In-Reply-To: <1356083914-17579-1-git-send-email-kg4ysn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Dec 21, 2012 at 10:59 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Fri, Dec 21, 2012 at 05:37:38PM -0800, Chris Verges wrote:
>> On Fri, Dec 21, 2012 at 5:30 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>> >
>> > Just wondering - how comes the detect function did not report the
>> > error ?
>>
>> Excellent question.  I didn't debug into this any further, but it is
>> a good area for additional investigation.
>>
> Depends on how it is instantiated. Is this a PC, or some embedded
> device ?  It could be configured with devicetree, for example.

This is an embedded device.  In looking further at the BSP, it is
defined in the i2c device list there.  (Pre-device-tree.)

> Question though is if there is some other chip on that address, and it
> is wrongly detected as LM73. Do you know by any chance?

Definitely not another chip at that address.  This board only has lm73's
on the i2c bus -- 2 at different addresses, in fact.  Plus, the detect
function in the lm73 appears to be quite thorough in vetting
LM73-specific registers.

There may be error conditions or corner cases whereby this issue could
arise independently from the detect function.  For example:

   1. if an i2c bus adapter has a bug which causes i2c transfers to
      terminate prematurely, this could result in the detect functioning
      properly and the temperature poll to return an error code.

   2. if the lm73's power rail is being controlled by a
      GPIO-connected FET, and the lm73 is powered down to save power.
      (Admittedly, the lm73 doesn't eat up much power, but every electron
      counts in some applications.)

I discovered this issue through a combination of the sensor not being
connected, yet being defined statically in the i2c device list for the
board, and then there also being an i2c bus adapter bug causing transfer
truncation.  So even if the sensor was connected, 1 out of every 100
polls would return an error.  (Software blaming hardware?  Unthinkable.)

Related to the lm73, but off the main topic ...

There are some potential other checks which could be performed at the
driver layer to validate the responses back.  I couldn't decide whether
they would be valuable or not.  For example, the lm73 should only return
temperature values inside its operating range.  If something goes
haywire on the bus and causes all 1's to be received by the master, this
could translate to ~256 C ... outside the 150 C spec for the sensor.
Any advice for whether to go forth with these changes?

I'd also like to find a way to expose the variable precision control
available to the driver.  I submitted a patch previously, but it was a
first pass and not well conceived.  Does hwmon have a standard way of
exposing resolution settings?  Perhaps this should be a compile-time
Kconfig option?  Or maybe a module option?

Thanks,
Chris

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
