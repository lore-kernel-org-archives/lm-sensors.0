From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 02 Sep 2006 14:24:01 +0000
Subject: [lm-sensors] TODO: "dynamic" sysfs callbacks
Message-Id: <20060902162401.61eae156.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44F1E5B6.1080105@gmail.com>
In-Reply-To: <44F1E5B6.1080105@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

On Sat, 2 Sep 2006 00:08:09 -0700, while he should have been sleeping,
Greg KH wrote:
> On Sat, Sep 02, 2006 at 08:52:47AM +0200, Jean Delvare wrote:
> > Could happen once every second or every other second, if the user has a
> > GUI with sensors data (gkrellm, ksensors, xsensors...) I think it
> > qualifies as "frequent".
> 
> No, that's not "frequent" at all for cache related things.  A processor
> can do an lot in a second or two :)

Hm, in fact I failed to describe the situation clearly. The "once every
second" was intended to underline that it's worth optimizing if
possible and reasonable. The fact that the cache may matter is related
to another implementation detail of the hardware drivers. Let me
explain it better.

Each hardware monitoring driver presents a user-space interface in
sysfs. Large drivers export many files (easily over 50) and hardware
monitoring applications will read from most of them on every refresh.
These sysfs files may of may not share their callbacks. The older
drivers didn't, the newer do. So, depending on the driver
implementation, the same callback function may be called 10 times in a
row.

This is where I suspect cache could matter. I am in no way a hardware
architecture expert though, so I was merely waving my hands, I admit.

> > Not all hardware monitoring chips are i2c-based. I agree that all hwmon
> > drivers do quite a lot of I/O though, be it on the SMBus or ISA bus. But
> > it's hardly a reason not to make the rest of the driver code smaller
> > and faster if we can.
> 
> Sure, I'm not saying that at all.  It's just that trying to optimize for
> things that you can not even measure, isn't a good thing.

Agreed, actually it was quite my original point: let's not change the
code if there is no benefit.

> Size of the module, yes, that's fine, but look at percentages.  Shaving
> a few bytes here and there at the expense of readablity and
> maintainablity is not worth it.

Agreed again; here the idea was to get rid of ugly macros in the older
drivers, gaining both in readability and size (i.e. smaller driver),
and, I suspect, compilation time. The only point of disagreement (I
think) between Jim and me was, how far we wanted to go in that
direction. I am admittedly a conservative person ;)

> Cache usage of driver code that is run every other second?  Very hard to
> measure, it will be lost in the noise...

I don't have the time to even try measuring it. I just thought I would
mention performance in the conversation, after I noticed with a user
some days ago that logging sensors data using "sensors" every other
second would put 15% of load on the system, while I expected it
to be unnoticeable. I'm pretty certain there is room for optimization
almost all the way down from the chip to the output of "sensors". Some
hardware monitoring drivers can be made faster/lighter. Most SMBus
controller drivers could be converted to be interrupt-driven rather than
poll-based. libsensors could be way faster (Mark M. Hoffman is working
on this) and smaller. "sensors" should be way smaller as well, if
libsensors had been designed differently.

-- 
Jean Delvare

