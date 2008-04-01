From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 01 Apr 2008 08:46:54 +0000
Subject: Re: [lm-sensors] [PATCH] Rough draft of power/energy sensor support
Message-Id: <20080401104654.5aba82e0@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080313013724.GH5529@tree.beaverton.ibm.com>
In-Reply-To: <20080313013724.GH5529@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Darrick,

On Mon, 31 Mar 2008 16:39:20 -0700, Darrick J. Wong wrote:
> On Sun, Mar 30, 2008 at 08:24:46PM +0200, Jean Delvare wrote:
> > On Fri, 28 Mar 2008 14:01:08 -0700, Darrick J. Wong wrote:
> > > [Resend due to IBM mail server problems; apparently it can take a week
> > > to deliver the "can't send for past week" message???]
> > 
> > FWIW, your post was properly received by the list on March 13th:
> > http://lists.lm-sensors.org/pipermail/lm-sensors/2008-March/022710.html
> 
> Sorry for the spam.  Sometimes the mail service around here is strange.

It's totally OK. I had forgotten about this post while I really should
have commented on it, so blame me if anything.

> > > (...)
> > > +	SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL,
> > 
> > power[1-*]_average_interval is not expressed in Watts, so it should be:
> > 
> > 	SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL = (SENSORS_FEATURE_POWER << 8) | 0x80,
> > 
> > Otherwise "compute" statements meant for the power value itself would
> > also apply to the interval, which doesn't make sense.
> 
> Ok.  Is it documented anywhere that the 0x80 means "don't apply compute
> statements" ?

Shame on me, no it's not. I guess we could define NO_COMPUTE as 0x80
and use that, but OTOH I don't really want to make this part of the
API. We split the subfeatures that way because it allows for
optimizations inside libsensors, but I don't want to guarantee that we
will always do that in the future, and anyway this isn't something user
applications should have to know or care about.

> > What about the power[1-*]_input, power[1-*]_input_highest and
> > power[1-*]_input_lowest files which are already described in
> > Documentation/hwmon/sysfs-interface? It seems odd to add support for
> > the average values without also adding support for the instantaneous
> > values.
> 
> I don't currently have any drivers that support energyX_input* so that I
> cannot test this.  While it would probably work, is it better to have
> untested code that might work, or make it obvious by not having any
> support at all?

It's not rocket science, if we pay attention I'm certain we can
implement it properly without testing it ourselves. And at least it
will be there for others to test.

We probably want to come to a conclusion in the other discussion thread
about the final API first though. There's no point in implementing
support for interface files if we remove them from the API next week.

> > > (...)
> > > +		printf("%4.0f W", get_value(name, sf));
> > 
> > This would print the value with a resolution of 1 Watt, while your
> > interface proposal suggested to use the microWatt as a unit. This
> > doesn't seem very consistent. Wouldn't "%6.2f W" make more sense?
> 
> Hmm... are you asking why I'm converting uW -> W, or are you asking why
> the code rounds the values to a whole number instead of displaying
> decimal points?  I converted the values simply because W seems more
> familiar than uW; as for %6.2f vs %4.0f, you're probably right on
> that point.

The latter, sorry for being unclear. Converting from uW to W is OK, we
do that for all units. But we always display 2 decimal places then.

> > Note that if you expect a wide range of possible power or energy values
> > across devices, we could adjust the unit depending on the value, for
> > example mW if the value is less than 1 Watt, and W otherwise. This was
> > never needed for other measurement types so far, so we didn't implement
> > it, but that can be added if needed.
> 
> I think it's going to be necessary--our servers seem to consume hundreds
> of Watts even when idle, which means that the microWatt/Joule resolution
> is not necessary.  Cell phones and embedded devices hopefully aren't so
> hungry and will need that kind of precision.
> 
> Thanks for the code reviews, Jean!  Updated patches will follow.

You're welcome, and sorry for the late review. I should be able to
review the updated patches much faster.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
