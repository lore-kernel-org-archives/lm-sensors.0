From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Tue, 23 Aug 2011 22:28:01 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (i5k_amb) Replace BUG with WARN
Message-Id: <20110823222801.GB20579@tux1.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1313689771-31221-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1313689771-31221-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Aug 23, 2011 at 08:05:55PM +0200, Jean Delvare wrote:
> On Tue, 23 Aug 2011 10:14:41 -0700, Guenter Roeck wrote:
> > On Tue, 2011-08-23 at 12:55 -0400, Darrick J. Wong wrote:
> > > On Mon, Aug 22, 2011 at 09:01:07PM -0700, Guenter Roeck wrote:
> > > > As I don't see a consensus for my proposed patch, I'll drop it.
> > > 
> > > Sorry, I'm just slow at testing things sometimes. :(
> > > 
> > > In general I like the idea of replacing BUG with WARN when possible,
> > > particularly with hardware detection.  Your patch seems to load ok on all the
> > > systems I can still claw together, so,
> > > 
> > > Acked-by: Darrick J. Wong <djwong@us.ibm.com>
> > 
> > Hi Darrick,
> > 
> > thanks for the feedback.
> > 
> > Problem is that Jean disagreed with my solution and proposed a different
> > patch. I don't think my proposed patch is important enough to ignore or
> > override Jean's disagreement, so I decided to drop it.
> 
> Darrick, any chance you could test my alternative patch? I posted it to
> the list, see:
> 
> http://marc.info/?l=lm-sensors&m1378870513822&w=2
> 
> I thought I had Cc'd you but I'm not sure if you received that copy.

Oops, I actually meant to ack Jean's new patch, not the old one; I think I
replied to the wrong thread.  Serves me right for writing email before coffee.
:/

--D
> 
> -- 
> Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
