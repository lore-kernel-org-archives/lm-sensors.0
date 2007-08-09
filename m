From: Joerg Sommrey <jo@sommrey.de>
Date: Thu, 09 Aug 2007 16:41:52 +0000
Subject: Re: [lm-sensors] [PATCH] bad temperature values from w83781d in
Message-Id: <20070809164152.GA28404@sommrey.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070805183219.0d54802b.akpm@linux-foundation.org> <20070808010316.GB3584@jupiter.solarsys.private> <20070808151716.GA6053@sommrey.de> <20070809035642.GE3584@jupiter.solarsys.private> <20070809070915.GA24252@sommrey.de> <20070809122619.GF3584@jupiter.solarsys.private>
In-Reply-To: <20070809122619.GF3584@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: LKML <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

Hi Mark,

On Thu, Aug 09, 2007 at 08:26:19AM -0400, Mark M. Hoffman wrote:
> Hi Joerg:
> 
> > On Wed, Aug 08, 2007 at 11:56:42PM -0400, Mark M. Hoffman wrote:
> > > Thanks for sending all that.  I see one bug clearly, and I'm pretty close to
> > > seeing the other one.  But for tonight, I need sleep.
> 
> There's just one bug after all.  The second was a figment of my sleep-deprived
> imagination.
> 
[...]
> 
> My bad, there's a second i2cset command that would have done it.  Please try
> this patch against v2.6.22.
> 

Great, problem fixed.  Thanks a lot for your prompt solution!

-jo

-- 
-rw-r--r-- 1 jo users 62 2007-08-09 08:46 /home/jo/.signature

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
