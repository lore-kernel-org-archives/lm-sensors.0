From: Kevin Lo <kevlo@kevlo.org>
Date: Mon, 26 Nov 2007 01:38:54 +0000
Subject: Re: [lm-sensors] [PATCH] Driver for Winbond W83L786NG/NR
Message-Id: <1196041135.6198.2.camel@monet>
List-Id: <lm-sensors.vger.kernel.org>
References: <1188522272.5885.8.camel@monet>
In-Reply-To: <1188522272.5885.8.camel@monet>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 2007-11-25 at 13:39 +0100, Jean Delvare wrote:
> On Fri, 23 Nov 2007 09:31:52 +0800, Kevin Lo wrote:
> > On Tue, 2007-11-20 at 17:26 +0800, Kevin Lo wrote:
> > > On Sun, 2007-11-18 at 13:35 -0500, Mark M. Hoffman wrote:
> > > > This review is long overdue, sorry.  If you no longer feel like working on
> > > > it, let me know and I'll take it over.
> > > 
> > > Thanks for taking the time to review my patch. I'll fix it this week :-)
> > 
> > Here is the revised patch which fixes the issues that you mentioned.
> > 
> > Signed-off-by: Kevin Lo <kevlo@kevlo.org>
> 
> Dave, can you please test this new iteration of Kevin's driver and
> confirm that it works fine for you?
> 
> The patch is here if you're not subscribed to the list:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-November/021975.html
> 
> Kevin, did you test your driver with lm-sensors 3.0.0?

No, but I tested my patch with lm-sensors 2.10.5, it worked fine. 

> Thanks,
> -- 
> Jean Delvare

Regards,
Kevin.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
