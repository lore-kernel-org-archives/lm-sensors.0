From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 20 Nov 2013 18:15:29 +0000
Subject: Re: [lm-sensors] Ticket #2382
Message-Id: <20131120181529.GA30952@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <528A62DC.9030107@baymicrosystems.com>
In-Reply-To: <528A62DC.9030107@baymicrosystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Nov 20, 2013 at 07:06:41PM +0100, Jean Delvare wrote:
> On Wed, 20 Nov 2013 09:29:44 -0800, Guenter Roeck wrote:
> > Mike's graph is quite interesting - it shows that the temperature reading error
> > is linear, at least for his CPU. Unfortunately, I don't think we can use
> > that knowledge to "fix" the reading automatically, as the error is very likely
> > different for other CPUs. We might consider adding an ideality factor module
> > parameter, though. What do you think about that ?
> 
> Everyone can compute the formula and use libsensors to apply it. If the
> user has to provide the value manually for each CPU sample then it
> might as well be that way, no need to add a module parameter. A single
> module parameter would additionally become a problem for multi-socket
> systems, you'd need an array and a reliable way to map each entry to
> the logical CPUs of a given socket (assuming the ideality factor is per
> package... which may not always be true.)
> 
Good point.

> > Another question is what temperature to use as tjmin. If we add an ideality
> > factor module parameter, it could be quite low, such as 20 degrees C.
> > We could even calculate tjmin based on the ideality factor if specified.
> >     tjmin = tjmax - (tjmax * ideality_factor / 100); /* ideality_factor in % */
> > 
> > Otherwise I would prefer something higher, at least 30 degrees C.
> 
> Personally I'd just do the minimum to avoid returning an error. In
> other words I'd be fine returning values down to 6 degrees (for the
> Atom D510 at least). We know the value is wrong but it can be corrected
> in user-space, while if we clamp higher, it can no longer be corrected.
> 
Seems to me it would be much simpler to just return 0 if the valid bit is 0,
and not bother returning -EAGAIN in that case. After all, that is what
it boils down to, isn't it ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
