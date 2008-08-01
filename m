From: Brice Figureau <brice+lm@daysofwonder.com>
Date: Fri, 01 Aug 2008 08:07:13 +0000
Subject: Re: [lm-sensors] ipmisensors current status?
Message-Id: <1217578033.27951.5.camel@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2008-07-31 at 13:40 +0100, Paul Sherwin wrote:
> Please excuse my emailing the developer list but I'm having a lot of 
> trouble finding good info on this.
> 
> Does anybody know when the ipmisensors module will be added to mainline?
> 
> Is there a kernel patch in existence for a 2.6.24 kernel?

I asked the exact same question a couple of weeks ago but got no answers
about the project life:
http://article.gmane.org/gmane.linux.drivers.sensors/17379/match=brice

I also reported several bugs. So I tend to think the project is either
dead or orphaned.

If I get enough spare time in the next weeks, I'll try to at least fix
the bugs I reported, but no promise.

It is rather easy to adapt the current patch to 2.6.24 (if I remember
correctly you just have to strip the last argument of
kmem_cache_create), but be prepared for some issues.

Hope that helps,
-- 
Brice Figureau <brice+lm@daysofwonder.com>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
