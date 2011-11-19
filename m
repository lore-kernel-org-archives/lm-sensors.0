From: Phil Pokorny <ppokorny@penguincomputing.com>
Date: Sat, 19 Nov 2011 04:26:25 +0000
Subject: Re: [lm-sensors] wrong output with fam15h_power
Message-Id: <CAAek22GL+zLev=nOezQc6hu5byrAE_gW=BA5BUwq71NxmycM5A@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1321642023.1644.12.camel@tellur>
In-Reply-To: <1321642023.1644.12.camel@tellur>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello,

On Fri, Nov 18, 2011 at 11:46 AM, Lucas Stach <dev@lynxeye.de> wrote:
> Hi Phil,
>
> Am Freitag, den 18.11.2011, 11:11 -0800 schrieb Phil Pokorny:
>> On Fri, Nov 18, 2011 at 10:47 AM, Lucas Stach <dev@lynxeye.de> wrote:
>> > Hi,
>> >
>> > I'm trying to use the fam15h_power driver to measure my processors pow=
er
>> > consumption, but it gives me clearly wrong values. With a completely
>> > idle system the processor claims to be using 125261718=B5W, which would
>> > mean the processor operates at it's TDP limit. With all cores 100%
>> > loaded it claims to be using 130675781=B5W which I can't believe as th=
is
>> > would mean the processor violates it's own spec.
>>
>> You have to read the vendor documentation carefully...
>>
>> TDP numbers are *not* necessarily the maximum power draw. =A0They are
>> the *design* point for a thermal solution.
>
> I appreciate your answer but his is *not* the point here. The point is
> the fam15h_power driver is claiming the processor is useing a totally
> unbelievable 125W while idle, while physical measurements have shown
> that fam15h processors do not use more than a few (below 10) Watts in
> this state.

Do you have the ability to measure the power on the 12V power
connector to the CPU VRM?  Will you be able to compare the fam15_power
reported value to a physical measurement from the same system at the
same time?

Do you have All Core Boost enabled in the BIOS?

Is PowerNow enabled in the BIOS?

Is the "cpuspeed" daemon running?

If you've already verified all those things, my apologies, but I find
that it helps to ask basic questions to make sure that the simple
things have been addressed and that everyone is testing the same
configuration.

In my experience with Interlagos CPU's, idle power (with those power
saving features enabled) somewhat higher than previous Magny Cours
CPU's.

Regardless, I tested the fam15_power driver on some Interlagos CPU's
and I agree there is something wrong about the math.

The power1_crit value reported is 114.8W.

At idle, the raw register value is at just shy of it's maximum
"positive" value of "0x1ffffe" with a "range" of "0xe".  The reported
power1_input is 89.9W

When I start power sucking jobs on the cores, the raw values don't
change at all until I start to load both integer cores on a single
bulldozer module.  Then the raw values start to decrease to less than
0x4000.  I never saw the "range" change from "0xe".  Once in a while,
the raw value is a negative value. (0x3ffxxx).  I know that power draw
is increasing, because I see the temperatures rising (via k10temp
hacked to read fam15h temps).

But with that change from "maximum" to "minimum" the reported
power1_input values change very little.  Only rising as high as 97W
and it falls *back* to 96.5W after I load up all the integer cores.

> Also the processor itself claims to have an upper TDP limit of 124.77W
> (as shown by fam15h_power), so no measurement should ever exceed this.

I did see negative values reported by the raw register and according
to the math in the driver they would result in reported values higher
than TDP.  And I have been told that processors _can_ draw more than
TDP for "short" periods of time.


But this driver is clearly not reporting something that could be
considered "instantaneous power draw"  It might be better to change
the driver to report the TDP and come up with some other name for the
"running avg" number directly because it appears to be a "head room"
or margin and *not* an instant power measurement.  But it can also
have big swings in value without corresponding changes in the power
draw, so I'm not sure what we should call it.

Phil P.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
