From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Mon, 31 Mar 2008 23:39:20 +0000
Subject: Re: [lm-sensors] [PATCH] Rough draft of power/energy sensor support
Message-Id: <20080331233920.GD7183@tree.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080313013724.GH5529@tree.beaverton.ibm.com>
In-Reply-To: <20080313013724.GH5529@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Mar 30, 2008 at 08:24:46PM +0200, Jean Delvare wrote:
> Hi Darrick,
> 
> On Fri, 28 Mar 2008 14:01:08 -0700, Darrick J. Wong wrote:
> > [Resend due to IBM mail server problems; apparently it can take a week
> > to deliver the "can't send for past week" message???]
> 
> FWIW, your post was properly received by the list on March 13th:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2008-March/022710.html

Sorry for the spam.  Sometimes the mail service around here is strange.

> No, we don't want to expose MAX_SENSOR_TYPES as part of the API, nor
<snip>
> limitation in what libsensors can pass to them.

Ok.

> You could split the prog/sensors part, that's easy and that way we can
> merge the libsensors part quickly even if there are more discussions
> about the prog/sensors part.

Ok.

> > +	SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL,
> 
> power[1-*]_average_interval is not expressed in Watts, so it should be:
> 
> 	SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL = (SENSORS_FEATURE_POWER << 8) | 0x80,
> 
> Otherwise "compute" statements meant for the power value itself would
> also apply to the interval, which doesn't make sense.

Ok.  Is it documented anywhere that the 0x80 means "don't apply compute
statements" ?

> What about the power[1-*]_input, power[1-*]_input_highest and
> power[1-*]_input_lowest files which are already described in
> Documentation/hwmon/sysfs-interface? It seems odd to add support for
> the average values without also adding support for the instantaneous
> values.

I don't currently have any drivers that support energyX_input* so that I
cannot test this.  While it would probably work, is it better to have
untested code that might work, or make it obvious by not having any
support at all?

> This comment should be updated to mention the two new types.

Oops.

> You'll have to add another case to handle
> SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL once it is treated as an
> "unscaled" subfeature.

Ok.

> > +		printf("%4.0f W", get_value(name, sf));
> 
> This would print the value with a resolution of 1 Watt, while your
> interface proposal suggested to use the microWatt as a unit. This
> doesn't seem very consistent. Wouldn't "%6.2f W" make more sense?

Hmm... are you asking why I'm converting uW -> W, or are you asking why
the code rounds the values to a whole number instead of displaying
decimal points?  I converted the values simply because W seems more
familiar than uW; as for %6.2f vs %4.0f, you're probably right on
that point.

> I can't see the rationale for using %4.0f for the min and %1.0f for the
> max. Can you please explain?

Numeric keypad typo, sorry.

> > +		printf("%4.0f J", get_value(name, sf));
> 
> This would print the value with a resolution of 1 Joule, while your
> interface proposal suggested to use the microJoule as a unit. This
> doesn't seem very consistent.

Same response as above.

> Note that if you expect a wide range of possible power or energy values
> across devices, we could adjust the unit depending on the value, for
> example mW if the value is less than 1 Watt, and W otherwise. This was
> never needed for other measurement types so far, so we didn't implement
> it, but that can be added if needed.

I think it's going to be necessary--our servers seem to consume hundreds
of Watts even when idle, which means that the microWatt/Joule resolution
is not necessary.  Cell phones and embedded devices hopefully aren't so
hungry and will need that kind of precision.

Thanks for the code reviews, Jean!  Updated patches will follow.

--D

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
