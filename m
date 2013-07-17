From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 17 Jul 2013 22:49:24 +0000
Subject: Re: [lm-sensors] [PATCH v3 3/4] tsod: New hwmon driver for Temperature Sensors on DIMM
Message-Id: <CALCETrWQF6p+DveuOxfMhp0r_CrvF=+FOmvfkF-TQ2NVgJ_2aA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1374093761.git.luto@amacapital.net> <f358329ff1dd3c3c272cadb4a358a5587cb28e18.1374093761.git.luto@amacapital.net>
 <20130717221902.GC990@roeck-us.net>
In-Reply-To: <20130717221902.GC990-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, James Ralston <james.d.ralston-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andras BALI <drewie-Y8qEzhMunLyT9ig0jae3mg@public.gmane.org>

On Wed, Jul 17, 2013 at 3:19 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Wed, Jul 17, 2013 at 01:53:07PM -0700, Andy Lutomirski wrote:
>> Signed-off-by: Andy Lutomirski <luto@amacapital.net>
>> ---
>
> Why don't you just use the existing jc42 driver ?

Failure to notice it.  *sigh*.  I assumed that any driver for this
device would have "tsod" or "TSOD" somewhere greppable.  I'll at least
send a patch to improve the description.

That being said, the jc42 driver *writes*.  The iMC controller
(AFAICS) uses the data from the TSOD for things like dynamically
adjusting the DRAM refresh interval and IMO the kernel has no business
at all writing to any registers on the TSOD on this platform.  (FWIW,
I tried fiddling with the critical threshold and my box didn't blow up
or report thermal trip events.  But still, this scares me a bit.)

If I modify the i2c_imc driver to add .class = I2C_CLASS_SPD and get
rid of the TSOD probing and load the jc42 module, then it can't
actually find my TSODs (because the i2c core isn't capable of probing
on the iMC bus).  If I manually add the device, it works.

But I'd like to keep the enumeration code I wrote around, since the
main point of this exercise is to enumerate things that aren't
actually hwmon devices.  But I don't want random sensors scripts
reprogramming the hardware.  Is the some magic I can work (or should
add) with i2c_board_info to force the jc42 driver into a read-only
mode?

In any case, am I doing the right thing by not setting I2C_CLASS_SPD on my bus?

--Andy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
