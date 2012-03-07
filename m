From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 07 Mar 2012 16:18:58 +0000
Subject: Re: [lm-sensors] [PATCH] sensors: Fix power interval output
Message-Id: <1331137138.23014.352.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326472342-3345-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1326472342-3345-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Sun, 2012-03-04 at 08:11 -0500, Jean Delvare wrote:
> Hi Guenter,
> 
> Sorry for the very late reply. D'oh, I can't believe it has been 7
> weeks already :(
> 
> On Fri, 13 Jan 2012 08:32:22 -0800, Guenter Roeck wrote:
> > Power interval is measured in seconds, not Watt.
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > Untested. Maybe a bit kludgy but should work.
> 
> I recall testing it with a fake driver and it was working. But I don't
> like it much. It's sad to have defined data structures to abstract
> things as much as possible and then end up with a hack like this one. I
> would prefer a more generic solution if we can come up with one. OTOH
> delaying lm-sensors 3.3.2 further just for this makes little sense. So,
> if you don't hear from me in the next 2 days, please just commit this
> fix and I'll release 3.3.2.
> 
More than two days, and I didn't hear anything, so I went ahead and
committed it.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
