From: Guenter Roeck <guenter@roeck-us.net>
Date: Thu, 08 Mar 2012 07:53:11 +0000
Subject: Re: [lm-sensors] [PATCH] sensors: Fix power interval output
Message-Id: <6.2.5.6.2.20120307235220.0275c470@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326472342-3345-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1326472342-3345-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

At 11:50 PM 3/7/2012, Jean Delvare wrote:
>On Wed, 7 Mar 2012 08:18:58 -0800, Guenter Roeck wrote:
> > On Sun, 2012-03-04 at 08:11 -0500, Jean Delvare wrote:
> > > I recall testing it with a fake driver and it was working. But I don't
> > > like it much. It's sad to have defined data structures to abstract
> > > things as much as possible and then end up with a hack like this one. I
> > > would prefer a more generic solution if we can come up with one. OTOH
> > > delaying lm-sensors 3.3.2 further just for this makes little sense. So,
> > > if you don't hear from me in the next 2 days, please just commit this
> > > fix and I'll release 3.3.2.
> >
> > More than two days, and I didn't hear anything, so I went ahead and
> > committed it.
>
>Thanks. This means we're about ready to release lm-sensors 3.3.2. If
>you have more pending patches, please commit them today. Tomorrow the
>repository will be considered frozen and we start the testing phase.
>Let's schedule the release for Monday, March 12th if this is OK with
>you.

Hi Jean,

I am all done with commits, and March 12 is definitely ok with me.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
