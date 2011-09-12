From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 12 Sep 2011 18:44:03 +0000
Subject: Re: [lm-sensors] [PATCHv4 1/1] Hwmon: Add core/pkg Threshold
Message-Id: <20110912204403.54eaf5e2@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 12 Sep 2011 10:13:29 -0700, Guenter Roeck wrote:
> On Mon, 2011-09-12 at 12:18 -0400, Jean Delvare wrote:
> > Hi Guenter, Durgadoss,
> > 
> > Sorry for the very late comment.
> > 
> > On Wed, 13 Jul 2011 13:48:11 -0700, Guenter Roeck wrote:
> > > Looks like it is working now, so I applied the patch to -next.
> > 
> > Working, really? That's not how it looks like from here.
> > 
> Frankly, I don't remember how I tested it - though I remember that I
> did. I re-tested it on a Xeon C5528 and got the same results :(. Maybe I
> was mentally unstable at the time or something. Sorry for that - should
> not happen.
> 
> Question is what to do - back it out ? I don't have time to look into it
> more right now.

I'll send a patch for the most obvious bug. For the rest, I'd like to
hear Durgadoss before we decide what do to. Certainly he had a good
reason for posting the patch in the first place, let's avoid a bold
revert if possible.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
