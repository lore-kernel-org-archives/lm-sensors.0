From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: Regarding standardized auto-fan control
Message-Id: <20040630235015.4d4a0b19.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040630024326.GH3064@jupiter.solarsys.private>
In-Reply-To: <20040630024326.GH3064@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> This latest round of discussion convinces me: I think that a standard
> interface (at the chip driver level) for automatic fan control just
> isn't feasible, for these reasons:
> 
> 1a) No two of these chips are alike, and
> 
> 1b) some of them are vastly different.
> 
> (And from the department of broken records...)
> 
> 2) A hardware driver should do and perform exactly as it is told. 
> I.e. we should not be afraid to expose an interface for each auto-fan
> capable chip which is suited to just that chip.

That same motto again... Don't mean a thing to me. What you really mean,
it seems, is more like "drivers should directly map to hardware
implementation" but then any interface is pointless. The only question
to be asked and answer is where we put the limit between what can
reasonably be (and thus has to be) done, and what cannot (reasonably)
be. As a trivial example, we decided that hysteresis temperatures would
be absolute, while some chips express them as a relative value. I
consider it a good think and I don't think anyone argues. Still it's one
step to have a common interface to chips doing things differently in
hardware. There are several other examples, such has critical limit
being shared in the LM83 (reminds me I have to put some order in the
driver) or a single hysteresis register for two channels on the
ADM1032/LM90. These steps were taken and everybody seems to agree it was
the right thing to do.

Now, I admit that the auto-fan control problematic is way more complex,
or we wouldn't still be discussing it. But we would better not give it
all up just before reading the datasheets reveals that the chips work
differently.

The only thing that looks really different to me is that some chips
associate trip points with fans (it87), while others associate them with
temperature channels (adm1031). The rest is about the same: each fan can
be associated to a number of temperature channels, and trip points
define a PWM vs temperature curve.

Which chip do we know of that doesn't fit into either model?

Again, I agree that trip point definition and count differ between
models. But in no way this can be seen as an unsolvable problem. I
estimate that these interfaces are way too complex and that most people
absolutely don't care. What people want is a computer which stays quiet
when idle, but doesn't overheat when used. They definitely don't want to
define a complex curve with half a dozen trip points.

So I would go with these two models, simplified as needed.

> OK seriously... if a standard interface is desirable for these
> controls then let's present one in userspace via libsensors.  I
> personally think that will be difficult, if not impossible... but then
> again not any harder than forcing it in the drivers themselves.

Doesn't make any sense to me. If a common interface is possible, then it
belongs to the drivers.

I agree that we could have done about everything in userspace (using the
i2c-dev driver), much like xmbmon does. But we did a different choice.
Not sure it was the correct one but this is not going to change now.

> One side-benefit of doing it in libsensors, is that we may be able to
> implement a "virtual" auto control in userspace for chips that have
> only manual PWM control.

Don't make sense to me either. libsensors is a library. The behavior you
describe is that of a daemon.

> In the meantime, we can upgrade the drivers to make use of these
> features instead of searching for an interface that might never exist.
> 
> Of course, it is still important to carefully design the interface for
> each driver.  I just don't think we can usefully nail them to a single
> design.

I agree that we need to do something quickly now, since users really
want that functionality to be implemented soon. And if there is no
common interface, better different interfaces than nothing. But...

You seem to have forgotten that the new libsensors will not have ANY
chip-specific code, EVER.

While lm_sensors was on off-kernel project, nobody really noticed how
the kernel code and the user-space were dependant, because most people
would install them off the same lm_sensors package each time. Now that
the drivers belong to the kernel and lm_sensors will become a user-space
only package, things are different. We just cannot continue to ask the
user to upgrade libsensors on any new chip driver out there. I cannot
think of any other project doing this, for a reason. This is ugly.

This is the reason why we have been working on a unified, extensible
sysfs interface to the driver in 2.6. And this is the reason why I would
like us to do the same for the auto-fan control, even if this means not
supporting each chip to 100% of its capabilities (which we have never
done so far anyway).

If such an interface is not going to exist in the kernel, it's not going
to exist in the new libsensors either. The new libsensors will be a
simple, chip-independant way to select channels, set limits and compute
formulas in a generic way. It should be quite straightforward to write
for someone having some knowledge of config file parsing (which I am
not, unfortunately) and, more importantly, it should be almost in its
definitive state at the moment it will be working.

If the new libsensors is not going to do that, then having a new
libsensors at all will be pointless IMHO.

As a summary, it will take one example of a chip that does fit in
neither the (channel selection + trip points on temp channels) nor the
(channel selection + trip points on fan channels) model to make me agree
that a common interface is not viable.

-- 
Jean Delvare
http://khali.linux-fr.org/
