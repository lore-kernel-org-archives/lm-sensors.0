From: Trent Piepho <tpiepho@freescale.com>
Date: Thu, 30 Oct 2008 09:39:03 +0000
Subject: Re: [lm-sensors] Using hwmon in-kernel
Message-Id: <Pine.LNX.4.64.0810300208420.3943@t2.domain.actdsltmp>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081008003041.GA20169@srcf.ucam.org>
In-Reply-To: <20081008003041.GA20169@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 30 Oct 2008, Jean Delvare wrote:
>>> Because any interface that basically enforces integer->string->integer
>>> conversion is an indication that you're already doing it wrong.
>
> I wholeheartedly second Matthew here. Making the string-based sysfs
> interface available to the kernel would certainly be easy, but that
> would be damn inefficient. If we have to do that then let's do it right.

Does it really make that much of a difference?  My guess would be that the
most significant cost of using the sysfs interface from the kernel would be
the attribute lookup and the locking sysfs does.  The int/string stuff
shouldn't be much compared to that.

>> For what it used for, the sysfs int->string->int cost isn't very significant.
>> It's less than the kernel to userspace cost of sysfs.
>>
>> If the overhead of the sysfs interface to userspace is not enough to be a
>> problem, and a kernel interface to sysfs has less overhead than from
>> userspace, then how can the kernel based overhead be too much?
>
> You wrote it yourself: as far as user-space is concerned, the
> int->string->int cost is less than the kernel-to-userspace cost. That's
> the very reason why the sysfs interface concept was deemed acceptable.
> For kernel-space interfaces though, there is no huge kernel-to-kernel
> cost which means that the overall cost _can_ be low. And if it can be
> low, is should be, which means: no useless int->string->int conversion.

The sysfs concept isn't acceptable for everything, only low volume interfaces
where the overhead isn't significant.  You can make a faster kernel interface,
but you can make a faster userspace interface too.  But some things don't need
it.

If userspace sysfs is fast enough for a hwmon chip, why would a faster kernel
sysfs interface not be fast enough?  The rate at which temperatures change,
hwmon chips update their registers, and the speed of I2C haven't changed.

> Note however that, as far as hwmon drivers are concerned, there's more
> than just the access interface to consider. Almost all hwmon drivers
> read all registers at once and cache the results for one or two
> seconds, because this made sense for the user-space users. An in-kernel
> user such as Matthew's driver would instead need to read only _one_
> sensor value, and would probably like to avoid caching it, so that his
> driver can react faster to temperature changes. So, drivers which are
> needed for in-kernel access will need to be reworked a bit anyway, we
> can't just point to the sysfs callback functions, not even if we manage
> to get them to return an integer rather than its string form.

That's a good point.  I've never really liked the one second rate limiting. 
It would be nice if the cache time could be adjusted at run time, or if the
user the request was made under, root/kernel vs non-root, could be taken into
account.

>> Instead of hwmon providing this stuff, sysfs could always do it.  There are a
>> lot of non-hwmon attributes that could make use of it.
>
> If sysfs ever offers a facility for this then yes, the hwmon subsystem
> should be converted to make use of it.

It already does offer something very much like this, see SYSDEV_ULONG_ATTR and
SYSDEV_INT_ATTR in sysdev.h and the various sysdev functions like
sysdev_show_ulong().

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
