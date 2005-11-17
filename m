From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 17 Nov 2005 13:03:31 +0000
Subject: [lm-sensors] [RFC] adding back i2c_get_clients
Message-Id: <MI8VkP9d.1132228154.0638950.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051117003330.21bfff26@inspiron>
In-Reply-To: <20051117003330.21bfff26@inspiron>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Alessandro,

On 2005-11-17, Alessandro Zummo wrote:
> > If the command is really specific, I see no reason why exporting a
> > function would be avoided.
>
> abstraction. If we can abstract some rtc specific commands, less code
> will have to be written and maintaining it will be easier.

OK, so what you call "specific", I call "generic" ;) Sure, exporting
functions is not suitable for a generic interface. You want to either
define an ioctl-like interface (f(target, command, &parameter), but Greg
doesn't seem to be happy with that solution?), or a structure with
attributes and function pointers to specific implementations of the
interface. Something like:

struct rtc_operations
{
        int(* set_time)(struct rtc_time),
        int(* get_time)(strcut rtc_time *),
}

> > The fact that your RTC chip is I2C-based is an implementation detail.
> > If you want a command to work on all RTC drivers, you certainly do
> > not want to rely on i2c-core in any way. Better have some rtc-core
> > driver (if it doesn't already exist) and have your RTC driver register
> > with it.
>
> That would bind the i2c driver definitely with its rtc counterpart.

Exactly the contrary. There would no more be a specific rtc counterpart,
or at least it would no more bound directly to the i2c part. This is the
point of having a core and well-defined interfaces.

> as I have said, rtc are not always rtcs. they may have memory, they may
> be used or not as a system rtc, thay may be timers. Should I have
>
> rtc-generic -> rtc-mychip -> i2c-myrtcchip *repeated* for each
> i2c rtc chip?
>
> that makes no sense to me.
>
> I'd rather prefer having
>
> rtc-i2c -> i2c-anyrtcchip .

And I'd rather have:

platform-rtc <-> rtc-core <-> rtc-i2c

What you call "rtc counterpart of the rtc-i2c driver" is actually
platform-specific. The same RTC chip could be used as the system RTC on
one system, and used differently on other systems. We don't want to
write as many drivers as platforms for the same chip.

There is an additional difficulty due to the lack of possible
indentification of I2C-based RTC chips. The "rtc-i2c" driver above may
need platform-specific data. This is being discussed in a different
thread on this list.

All an rtc-i2c driver needs to do is offer a standard interface to get,
and set, the date and/or time. And maybe other things (alarms?). It does
not need to know how these functions will be used.

> This way, the i2c part could also be used to do other things on the rtc.

This is true regardless of how it interfaces with the hypothetical
rtc-core or "rtc-counterpart" or anything else.

> If one needs to use it as the system rtc, you can simply modprobe the
> generic rtc i2c driver.

There is no such thing as a "generic rtc i2c driver", and won't ever
be. I2C is really only the transport layer here. Whatever you want to
implement here doesn't belong to the i2c-core in any way.

> I don't expect the i2c core to do anything specific, but I need to be
> sure all the i2c drivers conform to a standard, whatever that standard
> is.

Again, no. You want to be sure that all *RTC* drivers conform to a
standard. I am very surprised that it ain't the case already, given the
large number of rtc drivers which already exist.

Whatever, we should really implement the alternative driver attaching
method which was discussed earlier before doing anything else, because
once we have that, it will probably help us think of better solutions to
all the other i2c-related problems which are currently being discussed
here and there. I will try to work on this again as soon as possible. Oh
my, why am I so short of time all the time? :(

Thanks,
--
Jean Delvare
