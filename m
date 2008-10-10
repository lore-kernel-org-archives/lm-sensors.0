From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 10 Oct 2008 08:25:54 +0000
Subject: Re: [lm-sensors] [PATCH 05/12] adt7470: Add documentation
Message-Id: <20081010102554.0548b24e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081007011849.12701.53492.stgit@elm3a70.beaverton.ibm.com>
In-Reply-To: <20081007011849.12701.53492.stgit@elm3a70.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Darrick,

On Thu, 9 Oct 2008 14:25:23 -0700, Darrick J. Wong wrote:
> On Thu, Oct 09, 2008 at 12:31:17PM +0200, Jean Delvare wrote:
> 
> > Should we implement a kernel thread / tasklet / whatever it is called
> > these days that would actively read the needed temperature values (and
> > only these) every 5 seconds as soon as automatic fan speed control is
> > enabled? The current implementation seems dangerous to me, as
> > illustrated by the report you quoted above.
> 
> That would work, though it'll cause wakeups even if nobody's reading the
> sensor.  However, since one would generally have to run sensors-detect
> to know that it's there in the first place, I suppose anyone actually
> loading the module is doing so with the intent to monitor anyway.

My proposal is to have such a kernel thread running only when automatic
fan speed is enabled. According to the datasheet, this isn't the
default, so loading the adt7470 driver alone wouldn't start the thread.
The thread would start running only once at least one fan has been
switched to automatic mode, and would stop as soon as all fans are
switched back to manual mode.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
