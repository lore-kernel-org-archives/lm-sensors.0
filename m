From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Mon, 31 Mar 2008 21:01:35 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] Define sysfs interfaces for ibmaem
Message-Id: <20080331210135.GC7183@tree.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080328213646.GC7191@tree.beaverton.ibm.com> <20080329145603.7e47418f@hyperion.delvare>
In-Reply-To: <20080329145603.7e47418f@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

On Sat, Mar 29, 2008 at 02:56:03PM +0100, Jean Delvare wrote:
> > +energy[1-*]_input		Instantaneous energy use
> 
> This doesn't make sense to me. Energy is a quantity, it exists
> independently of time. An "instantaneous energy use" only makes sense
> if you tell in what (presumably very small) amount of time the energy
> was used... and then what you are measuring is not an energy but a
> power, for which we already have an interface. Please clarify.

Wes Felter suggested "Cumulative energy use", and I'll go with that.

> > +power[1-*]_interval		Power use averaging interval
> 
> Wouldn't power[1-*]_average_interval be clearer?

Given that power is energy used over a period of time, I wonder if it
might be more accurate to remove powerX_input and leave this name alone.
That said, it does seem to be the case that interval names take the
format "${sensorfile}_interval", so I suppose it makes more sense the
way that you suggest.

> > +				Unit: milliseconds
> 
> Nitpicking for consistency: millisecond (no trailing s).
> 
> What values do you expect for this entry? I am wondering if it's safe
> to use millisecond as a unit. Is it unlikely that a future chip will
> support averaging intervals below the millisecond?

It's possible that a future chip could do this, though today we only
support intervals in the hundreds of milliseconds.  The default for the
ibmaem driver is currently 1s.

--D

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
