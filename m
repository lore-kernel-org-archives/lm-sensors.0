From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 17 May 2011 07:36:00 +0000
Subject: Re: [lm-sensors] FAULT status of sensors
Message-Id: <20110517093600.7a27e215@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <201105162023.54718.waja@cyconet.org>
In-Reply-To: <201105162023.54718.waja@cyconet.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 16 May 2011 19:32:52 -0700, Guenter Roeck wrote:
> On Mon, May 16, 2011 at 02:23:44PM -0400, Jan Wagner wrote:
> > Hi there,
> > 
> > we got a bugreport[1] against our nagios-plugins package. Unfortunately we are 
> > unsure about what "FAULT" means.
> > In case this is a hardware problem of a sensor in form of it got damaged, we 
> > would report "CRITICAL", as a problem occured.
> > If this means there is a problem detecting the sensor or something software 
> > like problem, we would report "UNKNOWN" as this not means a hardware problem 
> > happened.
> > 
> 
> It is supposed to indicate a HW problem. Here is the text describing the sysfs attribute:
> 
> "Each input channel may have an associated fault file. This can be used
>  to notify open diodes, unconnected fans etc. where the hardware
>  supports it. When this boolean has value 1, the measurement for that
>  channel should not be trusted."
> 
> Note that "critical" in the hwmon ABI means that a critical limit has been reached.
> You would get a "critical" alarm in this case. You might have a terminology problem 
> if you use "critical" for a hardware failure.
> 
> An undetected sensor should not show up in the first place.

In fact, FAULT can happen in two different cases. First case (most
common) is unused channel by the manufacturer and the channel should
indeed be ignored. Second case is thermal diode dying or fan stalling,
and reporting this makes sense. So I would:
* Ignore sensor channels which report FAULT when you start monitoring.
* Report FAULT as an actual problem if it happens later during
  monitoring, for a channel which reported real values before. The
  terminology is up to you.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
