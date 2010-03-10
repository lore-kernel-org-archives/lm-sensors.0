From: lmsensorslist@nodivisions.com
Date: Wed, 10 Mar 2010 16:41:52 +0000
Subject: Re: [lm-sensors] Wrong temperatures reported for Core2Duo CPU in
Message-Id: <21cfbc4d1bbb6fac38b52d5b60f33bbc.squirrel@webmail.nodivisions.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <781687b2e6d2a27726f35a316f5bf821.squirrel@webmail.nodivisions.com>
In-Reply-To: <781687b2e6d2a27726f35a316f5bf821.squirrel@webmail.nodivisions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Thanks for your reply.

On 03/10/2010 10:07 AM, Jean Delvare wrote:
>
> The value is reported by the CPU itself. The coretemp kernel driver is
> just passing it through. While the value is reported relative to the
> critical limit, and we have had this critical limit wrong for some
> models in the past, this is irrelevant here: the fact is that your CPU

Can you explain this a bit more?  You say coretemp is just passing it
through, which to me implies no calculation nor conversion of any kind. 
But that's not really the case, is it?  The CPU doesn't literally say "79"
to mean "79 degress Celsius" right?

> runs over its high limit when loaded. I've never seen any Intel Core2
> CPU reaching such a high temperature. This can mean only 2 things:
> * You happen to have a CPU with defective thermal sensors. The fact
>   that both cores agree makes me skeptical, but then again, as I have
>   no idea how the internal sensors could go wrong, it might as well
>   happen to both sensors at once.
> * Your heatsink and fan are not doing their job properly. This is my
>   favorite theory at this point.

It's certainly possible that I've messed that up somehow.  However, I've
installed many dozens of CPUs and heatsinks as a system builder over the
years, including 2 different ones in this particular system -- and,
there's basically nothing to it with Socket 775: you just sit the heatsink
on the CPU and push down the 4 pins.  I'm using the pre-applied thermal
compound on the Rosewill heatsink, but with the Intel heatsink that I was
originally using, I used Arctic Silver.  In both cases these high
temperatures were present.

> I would not be surprised that the CPU survives 3.5 years at these
> temperatures. You are still below the critical limit.

So regularly running in the 80-90 degree Celsius range won't necessarily
damage the chip?  I see what you mean that it's below the critical limit
of 100C, but it still seems like 80-90C might hurt it too.

> Hard disk drive temperature is a totally different thing. Assuming
> there is some space between the CPU and the HDD (and there always is on
> a desktop board) there is no reason for these temperature to match.

I know they are totally separate sensors, I just wanted to point out that
for example it's not the case that the whole PC is running hot, or just in
a really hot room, etc.  It's just these numbers for the CPU cores that
are high.

> The QST SDK might let us provide support for motherboard sensors, but
> this will not change the values reported by the coretemp driver. Best
> you can hope is extra temperature sensors for comparison purpose.

I'm hoping for that along with maybe fan RPM readouts, and ideally being
able to control the fan RPMs.

> What you can do is check the temperatures reported by the BIOS. It's
> difficult to know where the BIOS gets the values from, though...

OK, I just tested this, by running the "stress" command for a few minutes,
until the coretemp values were 91C and 92C.  I then immediately shut down
and went into the BIOS.  Here's the BIOS numbers:

68C CPU Die/Package Temperature
54C Motherboard Temperature
44C Motherboard Temperature
82C ICH Temperature
58C MCH Temperature

And here's the same BIOS numbers after sitting there in the BIOS for 10
minutes:

63C CPU Die/Package Temperature
50C Motherboard Temperature
44C Motherboard Temperature
83C ICH Temperature
54C MCH Temperature

I guess the die temp is the one that corresponds to the CPU?  But why
wouldn't it just show the 2 core temps?

Do you think it's possible that it really dissipated 20+ degrees during
the ~1 minute it took me to shut down and get into the BIOS?

> Fan control is not possible with only the coretemp driver, sorry. You
> might look in the BIOS options for an automatic fan speed control
> option, but given how hot your CPU already is, I wouldn't dare enabling
> it.

It's already set that way.  The CPU fan is silent when I first boot the
PC, and the idle core temp is ~75C.  But as soon as I do anything, the fan
kicks on quietly; then after 10-20 minutes of uptime and regular work,
it's running at or near full throttle.

Thanks,

--
Anthony DiSante
http://nodivisions.com/



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
