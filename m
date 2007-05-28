From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 28 May 2007 16:40:00 +0000
Subject: Re: [lm-sensors] THMC50 review
Message-Id: <20070528184000.6ba15745@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <web-67221254@hhs.nl>
In-Reply-To: <web-67221254@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

On Sun, 27 May 2007 14:14:53 -0400, Mark M. Hoffman wrote:
> Hi all:
> 
> * Goede, J.W.R. de <j.w.r.degoede@hhs.nl> [2007-05-21 21:49:26 +0200]:
> > On Mon, 21 May 2007 11:29:42 -0700
> >  "Juerg Haefliger" <juergh@gmail.com> wrote:
> > > I'm about ready to do some reviewing but I need to check
> > > with Mark
> > > Hofmann to figure out who comes next.  Don't know where
> > > your driver is
> > > in the queue.
> > > 
> > 
> > Actually keeping a queue that can be used with people which
> > have time to review sounds like a plan. I think we should
> > create a page for this at the trac wiki. Mark AFAIK you've
> > been collecting reviews, can you create such a page. (I can
> > do it myself but I don't have a list of everything that
> > needs reviewing).
> 
> Given the later messages in this thread, it seems the consensus is to update
> the existing Devices page in the wiki to track this info.  I've updated the
> lm93 entry as an example.
> 
> Maybe this does warrant adding a column to the table: "Reviewer".  Thoughts?

I don't think this is a good idea. That column would be only used for a
very small number of entries, so it would essentially waste space on the
page. This page is already difficult to see when viewed in 1024x768
resolution, this would only make it worse.

So I'd rather simply mention the reviewer in the comments column. If
you think it's not visible enough, then we can move the information
somewhere else: either a dedicated page on the wiki, or in the ticket
system (one ticket per new driver) as was done for the dme1737 driver.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
