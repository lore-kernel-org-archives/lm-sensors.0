From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 23 Aug 2011 18:05:55 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (i5k_amb) Replace BUG with WARN
Message-Id: <20110823200555.2735e807@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1313689771-31221-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1313689771-31221-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 23 Aug 2011 10:14:41 -0700, Guenter Roeck wrote:
> On Tue, 2011-08-23 at 12:55 -0400, Darrick J. Wong wrote:
> > On Mon, Aug 22, 2011 at 09:01:07PM -0700, Guenter Roeck wrote:
> > > As I don't see a consensus for my proposed patch, I'll drop it.
> > 
> > Sorry, I'm just slow at testing things sometimes. :(
> > 
> > In general I like the idea of replacing BUG with WARN when possible,
> > particularly with hardware detection.  Your patch seems to load ok on all the
> > systems I can still claw together, so,
> > 
> > Acked-by: Darrick J. Wong <djwong@us.ibm.com>
> 
> Hi Darrick,
> 
> thanks for the feedback.
> 
> Problem is that Jean disagreed with my solution and proposed a different
> patch. I don't think my proposed patch is important enough to ignore or
> override Jean's disagreement, so I decided to drop it.

Darrick, any chance you could test my alternative patch? I posted it to
the list, see:

http://marc.info/?l=lm-sensors&m1378870513822&w=2

I thought I had Cc'd you but I'm not sure if you received that copy.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
