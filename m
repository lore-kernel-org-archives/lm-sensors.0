From: akpm@osdl.org (Andrew Morton)
Date: Fri, 04 Aug 2006 22:19:52 +0000
Subject: [lm-sensors] [PATCH] Apple Motion Sensor driver
Message-Id: <20060804151952.93519f05.akpm@osdl.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060802191520.GA2260@hansmi.ch>
In-Reply-To: <20060802191520.GA2260@hansmi.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 4 Aug 2006 23:49:24 +0200
Michael Hanselmann <linux-kernel at hansmi.ch> wrote:

> On Fri, Aug 04, 2006 at 05:39:32PM -0300, Aristeu Sergio Rozanski Filho wrote:
> > > This guarantees a minimum wait time of 5msec after writing the value.
> > > Looking at the specs[1], this should be done. Your code doesn't do that:
> 
> > I doubt that if it's possible to retrying after a fail the hardware will
> > bother if we try to do the first read in less than 5ms... but here it
> > goes. two versions, feel free to choose.
> 
> The specs are written based on the Mac OS X driver, and I think Apple
> knows their hardware.
> 
> After discussing both variants, Ren? Nussbaumer and myself prefer the
> first one.
> 
> Acked-by: Michael Hanselmann <linux-kernel at hansmi.ch>
> Acked-by: Ren? Nussbaumer <linux-kernel at killerfox.forkbomb.ch>
> 

Sorry, I've lost track of what's going on here.

Could I please be sent a new copy of the whole patch, with the appropriate
acked-bys, signed-off-bys, etc?

Thanks.


