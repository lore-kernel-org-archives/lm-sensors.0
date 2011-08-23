From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 23 Aug 2011 17:14:41 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (i5k_amb) Replace BUG with WARN
Message-Id: <1314119681.3235.113.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1313689771-31221-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1313689771-31221-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2011-08-23 at 12:55 -0400, Darrick J. Wong wrote:
> On Mon, Aug 22, 2011 at 09:01:07PM -0700, Guenter Roeck wrote:
> > On Fri, Aug 19, 2011 at 07:05:50PM -0400, Guenter Roeck wrote:
> > > Hi Jean,
> > > 
> > > On Fri, Aug 19, 2011 at 05:16:24PM -0400, Jean Delvare wrote:
> > > > Hi Guenter,
> > > > 
> > > > On Thu, 18 Aug 2011 10:49:31 -0700, Guenter Roeck wrote:
> > > > > Executing BUG as a result of an internal driver error seems to be a bit harsh.
> > > > 
> > > > Well, that's pretty much what BUG was designed for: internal errors
> > > > that aren't supposed to happen.
> > > > 
> > > Problem with BUG is that it can be undefined for some configurations,
> > > in which case it doesn't do anything. 
> > > 
> > > Also, while it may make sense to bring down the system if there is a severe bug 
> > > which makes it impossible to continue, that seems to be a bit excessive
> > > for a hwmon driver.
> > > 
> > > > > Replace it with WARN and return -ENODEV if the condition is seen.
> > > > 
> > > > I'm not sure what is the benefit of WARN over pr_warn() in this case.
> > > > 
> > > WARN generates a traceback, pr_warn doesn't. I think the scope is a bit different
> > > - one warns about a programming error, the other warns about a system consition.
> > > 
> > Hi all,
> > 
> > As I don't see a consensus for my proposed patch, I'll drop it.
> 
> Sorry, I'm just slow at testing things sometimes. :(
> 
> In general I like the idea of replacing BUG with WARN when possible,
> particularly with hardware detection.  Your patch seems to load ok on all the
> systems I can still claw together, so,
> 
> Acked-by: Darrick J. Wong <djwong@us.ibm.com>

Hi Darrick,

thanks for the feedback.

Problem is that Jean disagreed with my solution and proposed a different
patch. I don't think my proposed patch is important enough to ignore or
override Jean's disagreement, so I decided to drop it.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
