From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 27 Jan 2009 08:48:43 +0000
Subject: Re: [lm-sensors] Branches in lm-sensors repository
Message-Id: <20090127094843.1e255bf7@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090119222636.0380a479@hyperion.delvare>
In-Reply-To: <20090119222636.0380a479@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 26 Jan 2009 19:48:23 +0200, Axel Thimm wrote:
> Hi,
> 
> On Mon, Jan 26, 2009 at 06:36:46PM +0100, Jean Delvare wrote:
> > > It leaves the question of where the snapshots go to now. Previously
> > > the 3.x snapshots went under /lm-sensors-3/snapshots/, I guess they
> > > would now better show up under /lm-sensors/snapshots/?
> > 
> > Yes. But I don't think you need to do anything special for this:
> > snapshots of trunk already went into /lm-sensors/snapshots/, and the
> > development branch is now trunk again. So the old command should
> > already do the right thing.
> 
> True, so it just needed removing the cron job for lm-sensors-3. Well
> planned when you set this up ;)
> 
> > > Should we remove /lm-sensors-3/ altogether?
> > 
> > Yes, please.
> 
> OK, done. Should all work as you said, but maybe we should check the
> contents of the next snapshot tomorrow (runs at 6:10 CET) just to make
> sure.

Looks OK to me. Thanks!

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
