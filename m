From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Thu, 09 Oct 2008 21:25:23 +0000
Subject: Re: [lm-sensors] [PATCH 05/12] adt7470: Add documentation
Message-Id: <20081009212522.GJ7726@tree.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081007011849.12701.53492.stgit@elm3a70.beaverton.ibm.com>
In-Reply-To: <20081007011849.12701.53492.stgit@elm3a70.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Oct 09, 2008 at 12:31:17PM +0200, Jean Delvare wrote:

> Should we implement a kernel thread / tasklet / whatever it is called
> these days that would actively read the needed temperature values (and
> only these) every 5 seconds as soon as automatic fan speed control is
> enabled? The current implementation seems dangerous to me, as
> illustrated by the report you quoted above.

That would work, though it'll cause wakeups even if nobody's reading the
sensor.  However, since one would generally have to run sensors-detect
to know that it's there in the first place, I suppose anyone actually
loading the module is doing so with the intent to monitor anyway.
> 
> Maybe this driver should be integrated with the generic thermal zone
> framework that was added to the kernel a few months ago? I this this
> framework already handles polling of the chips (to be confirmed.)

Hmm, I'll look into this when I get some more free time.  (ha ha...)

> 0 doesn't seem like a terribly realistic temperature. So, maybe we can
> have a heuristic that disables all sensors that report 0 when the
> driver is loaded? To be totally safe, we can then provide a way for the
> user to forcibly enable temperature sensors (either a module parameter
> or a sysfs file.)

That sounds reasonable.

> I know we usually don't do that, but OTOH this is the first hardware
> monitoring chip which daisy-chains external thermal sensors like that.

--D

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
