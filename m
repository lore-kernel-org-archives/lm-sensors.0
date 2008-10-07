From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 07 Oct 2008 17:39:17 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: w83781d: use new style driver
Message-Id: <20081007193917.7d090e6c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <48CB7FFA.10202@grandegger.com>
In-Reply-To: <48CB7FFA.10202@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Wolfgang,

On Tue, 07 Oct 2008 10:13:40 +0200, Wolfgang Grandegger wrote:
> Jean Delvare wrote:
> > Please let me know how you want to proceed from here. Do you want to
> > rework this patch and post an update (one or more patches)? Or do you
> > prefer that I make all the updates myself, and then you test and review
> > the patch?
> 
> If you have time, please go ahead. You will do a better job anyhow. I
> will not have time to catch up this and maybe the next week as well, sorry.

OK, I have reworked your patch and I have something which works fine on
my test system now.

> > My current set of patches for the w83781d driver is here:
> > http://jdelvare.pck.nerim.net/sensors/w83781d/
> > 
> > Any patch update you send should apply on top of that. Also, the first
> > 3 patches need to be tested, reviewed and acked before I can push them
> > upstream. Can you please help me with this? Ideally I would like to get
> > all the w83781d patches sorted out quickly so that they can spend some
> > time in linux-next and then be sent to Linus during the 2.6.28 merge
> > window.
> 
> OK, I will re-gain access to the embedded hardware end of this week.

I will send an updated patch set to the lm-sensors list now. This patch
set is also available at:
  http://jdelvare.pck.nerim.net/sensors/w83781d/
Please test these patches as your time permits. If possible, it would
be great if you could review them and give me your ack on them, before
I push them upstream.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
