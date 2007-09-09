From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 09 Sep 2007 17:11:40 +0000
Subject: Re: [lm-sensors] kernel TODO 20070909
Message-Id: <46E4294C.103@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070909162146.GA31999@jupiter.solarsys.private>
In-Reply-To: <20070909162146.GA31999@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark M. Hoffman wrote:
> PATCH:  hwmon-fscher-individual-alarm-files-v3.patch
> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-July/020301.html
> status: wants reviewer
> 
Drop this one from your queue / list please, I'm working on a new merged driver
for all FSC chips including 3 new models, which will feature individual alarms
(of course).

> PATCH: hwmon-fscher-support-fscpos.patch
> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-July/020386.html
> status: reviewed, wants updated(?)
> reviewer: Jean Delvare
> 

Drop this one from your queue / list please, also obsoleted by the new merged
driver.

p.s.

The new driver is almost done, I need to add fan_fault attr, and then its
finished. Testing on various models has found a fan not present fan status
register bit (we need to reverse engineer some stuff as the info Siemens is
willing to provide is incomplete).

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
