From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 01 Apr 2008 08:22:28 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] Define sysfs interfaces for ibmaem
Message-Id: <20080401102228.712acbb5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080328213646.GC7191@tree.beaverton.ibm.com>
	<20080329145603.7e47418f@hyperion.delvare>
	<20080331210135.GC7183@tree.beaverton.ibm.com>
In-Reply-To: <20080331210135.GC7183@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

On Mon, 31 Mar 2008 14:01:35 -0700, Darrick J. Wong wrote:
> On Sat, Mar 29, 2008 at 02:56:03PM +0100, Jean Delvare wrote:
> > > +energy[1-*]_input		Instantaneous energy use
> > 
> > This doesn't make sense to me. Energy is a quantity, it exists
> > independently of time. An "instantaneous energy use" only makes sense
> > if you tell in what (presumably very small) amount of time the energy
> > was used... and then what you are measuring is not an energy but a
> > power, for which we already have an interface. Please clarify.
> 
> Wes Felter suggested "Cumulative energy use", and I'll go with that.

OK. Another question that comes to my mind now is the unit... Do the
chips express the value in Joules internally? I would have expected
Watt-hours. Of course we can convert as needed, but if all known chips
use the same unit then I think we should that unit too, to minimize the
required conversions.

> > > +power[1-*]_interval		Power use averaging interval
> > 
> > Wouldn't power[1-*]_average_interval be clearer?
> 
> Given that power is energy used over a period of time, I wonder if it
> might be more accurate to remove powerX_input and leave this name alone.

It really depends on what the chips report. Typically the drivers
should report the values from the chip without too much tinkering
(other than conversion to standard units). If some chips can report
both "instantaneous" and "average" power uses, it makes sense to have
both sets of filenames in the standard interface. If not then I am fine
getting rid of one set.

> That said, it does seem to be the case that interval names take the
> format "${sensorfile}_interval", so I suppose it makes more sense the
> way that you suggest.

I don't think there is any precedent yet. I suggested this for
unambiguity rather than consistency.

> > > +				Unit: milliseconds
> > 
> > Nitpicking for consistency: millisecond (no trailing s).
> > 
> > What values do you expect for this entry? I am wondering if it's safe
> > to use millisecond as a unit. Is it unlikely that a future chip will
> > support averaging intervals below the millisecond?
> 
> It's possible that a future chip could do this, though today we only
> support intervals in the hundreds of milliseconds.  The default for the
> ibmaem driver is currently 1s.

Oh well, I guess that anything shorter than 1 ms can be considered
"instantaneous power use", so we can go with millisecond.

Out of curiosity, what are the values supported by the ibmaem chip?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
