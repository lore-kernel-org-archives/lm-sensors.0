From: Andreas Herrmann <andreas.herrmann3@amd.com>
Date: Tue, 18 Nov 2008 11:18:45 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] k8temp warn about errata
Message-Id: <20081118111845.GL12095@alberich.amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <48E3F505.40401@assembler.cz>
In-Reply-To: <48E3F505.40401@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Nov 18, 2008 at 11:40:52AM +0100, Jean Delvare wrote:
> On Tue, 18 Nov 2008 10:25:01 +0100, Andreas Herrmann wrote:
> > I am just curious how you'd like to determine the accuracy of the
> > thermal sensor ... As an example, if the sensor reports 70 degC when
> > the true temperature is 65 degC -- is it worth to blacklist it?
> 
> If we are 100% certain that this is the case then yes, I would
> blacklist it.
> 
> The whole point of hardware monitoring is to report accurate values.
>
> Additional software can be used to take actions based on temperature
> values, for example fan speed regulation or CPU frequency changes. If
> you can't trust the temperature readings then these operations become
> dangerous.

Then we need to blacklist it. The suggested workaround for this erratum is
to use "temperature measurements from an analog thermal diode" for thermal
control ...
If the system should be designed not to rely on the thermal sensor
(due to accuracy issue) the OS shouldn't use it either.

> That being said, I guess that the example above is essentially
> theoretical? Most cases we've seen so far were not off by 5 degrees.
> They were plain wrong, with reported temperatures being in the -20 to
> +15 degrees C.

Was this observed with k8temp or other sensor chips?

> > Jordan, do you know more details about the deviation of the reported
> > temparature sensor values from the real ones?
> > 
> > I'd prefer not to blacklist but to keep the warning about potential
> > inaccurate temperature values as introduced by Rudolf. I use k8temp on
> > my private machines -- Athlon X2 and a Turion X2 (both are revF CPUs
> > and thus affected by erratum 141). I admit, this is more or less a
> > gimmick but I would miss it (if blacklisted).
> 
> Whatever we end up with, we will add a module parameter to let the user
> force the driver binding, exactly for advanced users like you.

Ok, a module parameter should do it.

> My point with the blacklist is that we should not report knowingly
> incorrect values to the user _by default_, especially given that the
> k8temp driver loads automatically. I think it is better to not
> report anything by default rather than potentially wrong values. But
> I also agree that we must provide a way to bypass the tests, if
> nothing else, because our blacklist or heuristic may be incorrect.


Regards,

Andreas



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
