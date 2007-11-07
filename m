From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 07 Nov 2007 17:14:20 +0000
Subject: Re: [lm-sensors] dme1737 error messages
Message-Id: <20071107181420.5efff4de@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0710011151j4fe81ban7a61db5e60a5d3d1@mail.gmail.com>
In-Reply-To: <191fb4ca0710011151j4fe81ban7a61db5e60a5d3d1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

On Tue, 6 Nov 2007 13:20:22 -0800, Juerg Haefliger wrote:
> On 11/6/07, Jean Delvare wrote:
> > On Tue, 6 Nov 2007 10:31:22 -0800, Juerg Haefliger wrote:
> > > I recompiled the DSDT that you sent me and it's definitely broken. You
> > > can try to fix it but again I don't know what you can expect from that
> > > exercise. I also took a closer look at the DSDT and there's code that
> > > accesses the dme1737 all over the place. It mocks around with temp
> > > limits and PWM duty cycles and more. It's definitely *not* safe to use
> > > the dme1737 driver, it's interfering with ACPI regulating the fans
> > > based on the measured temps. Now why ACPI is controlling the fans
> > > instead of letting the dme1737 chip take care of it is beyond me...
> > > You'd have to ask the smart designers at ASUS :-)
> >
> > There's nothing fundamentally wrong with this, if the ACPI
> > implementation is correct. Why require an OS driver if they can do the
> > same in ACPI and it works on all OSes without user interaction?
> 
> What I meant by my comment is that I don't understand why they don't
> make use of the automatic fan control feature of the dme1737 chip.
> That would be much simpler (setting up a couple of registers) and
> wouldn't require implementing a closed-loop control algorithm SW. It's
> an ASUS board and they do it for other motherboards, so why not on
> this one? Maybe it's an HP requirement, I don't know...

Sorry, I had misunderstood your question. I had not realized that the
ACPI code was implementing software fan control. I agree with you that
it's silly to do in software something that can be done much more
efficiently and reliably by the hardware. I have no clue why they did
that, but that's unfortunately not the first time I see this.

> (...)
> > What we will do next, I'm not sure. In some cases it might be possible
> > to synchronize the hwmon driver accesses with the ACPI accesses, then
> > we can get both to cooperate.
> 
> How can we achieve cooperation between the two?

There's a mutex protecting the execution of AML code. If the hwmon
driver takes it when accessing the chip, at least we know that there
won't be conflicting I/O accesses. But this doesn't solve the possible
functional conflict if ACPI is doing really weird things. Maybe we'll
want to turn the hwmon driver read-only in some cases.

> > In other cases it probably won't be
> > possible and we'll have blacklist the hwmon driver, I fear.
> 
> Uh-huh... Based on the motherboard/system type? How does that work?

That would be based on DMI data, I think. That's the last resort, I
hope that we can avoid blacklisting in most cases.

But it's really only ideas at this point, I did not start writing code
and many things can still be discussed on a case-by-case basis. I'll
try to fix my own system first, when I get time, and once this is done,
depending on the result, I'll see what I can do for other systems.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
