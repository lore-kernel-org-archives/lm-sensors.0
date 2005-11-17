From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 17 Nov 2005 14:33:34 +0000
Subject: [lm-sensors] [RFC] adding back i2c_get_clients
Message-Id: <1Pr5phXb.1132233604.7320090.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051117003330.21bfff26@inspiron>
In-Reply-To: <20051117003330.21bfff26@inspiron>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Alessandro,

On 2005-11-17, Alessandro Zummo wrote:
> I agree, but we still have to define the interface between the i2c_driver
> and the external world, as i2c_driver->command is not adeguately
> documented.

I think you should just forget about ->command. It's there for
historical reasons, but all in all doesn't make much sense that I can
see. It's kind of a bold statement at this point, but I think ->command
is likely to be removed in the future. I would need to spend more time
investigating the exact implementation and uses of it before going on
about this though, and such extra time I unfortunately don't have right
now.

> I agree. I think we are saying similar things with different
> terms.. Let's do an example with the X1205:
>
> if you want to use it you must
>
> modprobe x1205
>
> if you want to _also_ use it as the system RTC, you should
> _also_
>
> modprobe rtc-i2c-interfacing-driver
>
> which will take care of interfacing x1205 with the kernel rtc
> subsytem.
>
> Do we agree here?

Probably not. My views are more like:

* The platform code needs x1205, so it loads it if needed.
Platform-specific data can be used to hint x1205 on what adapter,
address pair it should attach to.

* When loaded, x1205 registers with i2c-core (as it already does) and
rtc-core or whatever this will be called.

* The platform code then accesses x1205 through rtc-core, and only this
way.

But I probably better stop here, as I am not the one who will write that
code, at least not within the next few months. Most of the problem
really doesn't depend on i2c, so I will happily leave the discussion
and decision to others.

Thanks,
--
Jean Delvare
