From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 07 Oct 2010 14:42:31 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: (lm90) Add support for
Message-Id: <20101007144231.GD20342@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1286400191-30824-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1286400191-30824-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Oct 07, 2010 at 10:25:48AM -0400, Jean Delvare wrote:
> On Thu, 7 Oct 2010 07:14:08 -0700, Guenter Roeck wrote:
> > Hi Jean,
> > 
> > On Thu, Oct 07, 2010 at 05:28:03AM -0400, Jean Delvare wrote:
> > 
> > [ ... ]
> > 
> > > This is smart :) I like it a lot. Just not sure why you limited the
> > > shift to 2 bits, shifting by say 6 bits would guarantee that future
> > > devices supporting greater values for the conversion rate register
> > > (up tp 13) would be supported out of the box.
> > > 
> > I ran test code for all supported values, and found that shift by 2 
> > was sufficient. It can always be changed if someone ever comes up with
> > a sensor supporting even higher resolution. Call me minimalist ...
> 
> My point was that shifting by 6 doesn't cost more than shifting by 2.
> 
You are right. Sometimes I am too much of a minimalist.

> > > Also note that you may want to use DIV_ROUND_CLOSEST() to make the code
> > > slightly easier to read.
> > > 
> > Yes, that would be cleaner for the final interval calculation.
> > Want me to change it and send out another revision ?
> 
> As you wish, I am fine either way.
> 
Let me send you another rev, with shifting by 6 and using DIV_ROUND_CLOSEST.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
