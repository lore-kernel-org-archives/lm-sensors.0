From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 26 Jul 2011 13:10:55 +0000
Subject: Re: [lm-sensors] Where are all the sensors?
Message-Id: <20110726151055.39658d80@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4E0B52A6.1070402@yahoo.co.uk>
In-Reply-To: <4E0B52A6.1070402@yahoo.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Luca,

Sorry for the late reply.

On Wed, 6 Jul 2011 13:19:26 +0200, Luca Tettamanti wrote:
> n Wed, Jul 6, 2011 at 11:04 AM, Jean Delvare <khali@linux-fr.org> wrote:
> >> It was an ugly hack :) I modified the driver to access the hwmon chip
> >> using the methods exposed by the firmware instead of letting the
> >> driver touch the chip directly. Unfortunately the hack is very board
> >> specific...
> >
> > I still have to test this approach on a Jetway board of mine with a
> > Fintek F71805F chip.
> >
> > Why do you say this is ugly?
> 
> As it is it's poorly engineered. Ideally there should be an
> independent IO layer (that uses the IO ports, the Jetway methods, the
> MSI methods, etc) shared by all the drivers. At the very least the
> fintek driver should be modified to support the differrent IO methods.

Yes, I agree. But nothing prevents us from starting small, improvements
can happen over time.

> > Of course it is vendor specific (or even
> > board specific) but so is the asus_atk0110 driver. Wouldn't it be a
> > proper way to deal with the ACPI resource conflict at least on the
> > Jetway boards, and maybe others?
> 
> Two problems: 16 bits access are still not atomic (i.e. the two ACPI
> calls may be interleaved with something else touching the chip), so
> it's not 100% race free.

D'oh, yes you're right, I had totally forgotten about
this :( Thankfully 16-bit access is relatively rare, and when we're
only reading values it should be mostly correct. Maybe we can read
twice to make sure.

> The second one is deciding when to use the ACPI methods: I don't see a
> well defined interface with a proper HID like ATK0110, what I see are
> utility method used by the rest of the code. It wouldn't be possible
> to auto-detect such boards, we would need to resort to a DMI
> whitelist.

My own guess was a per-vendor approach, using DMI strings. For example
it seems that Jetway implemented the same utility methods on many
boards, so whenever direct I/O is impossible on a Jetway board, we
could look for these methods and use them if available.

> That said, since Dave has a different board with different ACPI
> methods for the same Fintek chip I'll try to code something to
> accommodate this situation soon(ish).

This would be great, yes. I wanted to do it too but could never find
the time.

I would consider that the current situation is bad enough that any
improvement would be great to have. Even if it works on only some
boards, even if some features are missing (e.g. read-only access and/or
without 16-bit access) and even if the user has to pass a module
parameter to enable the alternative way to reach the chip for the time
being.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
