From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 11 Sep 2007 11:10:11 +0000
Subject: Re: [lm-sensors] kernel TODO 20070909
Message-Id: <20070911111011.GB31999@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070909162146.GA31999@jupiter.solarsys.private>
In-Reply-To: <20070909162146.GA31999@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans:

* Hans de Goede <j.w.r.degoede@hhs.nl> [2007-09-09 19:11:40 +0200]:
> Mark M. Hoffman wrote:
> >PATCH:  hwmon-fscher-individual-alarm-files-v3.patch
> >http://lists.lm-sensors.org/pipermail/lm-sensors/2007-July/020301.html
> >status: wants reviewer
> >
> Drop this one from your queue / list please, I'm working on a new merged 
> driver
> for all FSC chips including 3 new models, which will feature individual 
> alarms
> (of course).
> 
> >PATCH: hwmon-fscher-support-fscpos.patch
> >http://lists.lm-sensors.org/pipermail/lm-sensors/2007-July/020386.html
> >status: reviewed, wants updated(?)
> >reviewer: Jean Delvare
> >
> 
> Drop this one from your queue / list please, also obsoleted by the new 
> merged
> driver.

OK, thanks for letting me know.

> p.s.
> 
> The new driver is almost done, I need to add fan_fault attr, and then its
> finished. Testing on various models has found a fan not present fan status
> register bit (we need to reverse engineer some stuff as the info Siemens is
> willing to provide is incomplete).

You may want to submit this driver for review ASAP.  Then you can add the other
(reverse engineered) features later.  Otherwise you might miss the merge window
which looks to be approaching pretty soon.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
