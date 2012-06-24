From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 24 Jun 2012 19:31:57 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (w83781d) Fix compile warning
Message-Id: <20120624213157.4fa5cc11@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1339620986-14314-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1339620986-14314-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Sat, 23 Jun 2012 09:02:36 -0700, Guenter Roeck wrote:
> On Mon, Jun 18, 2012 at 12:07:25PM +0200, Jean Delvare wrote:
> > Hi Guenter,
> > 
> > On Wed, 13 Jun 2012 13:56:26 -0700, Guenter Roeck wrote:
> > > The following compile warning may be seen if the driver is compiled with
> > > -Wuninitialized:
> > > 
> > > drivers/hwmon/w83781d.c: warning: 'sc_addr[1]' may be used uninitialized in this
> > > function [-Wuninitialized]
> > > 
> > > While this is a false positive, it is annoying in nightly builds, and may help
> > > to conceal real problems. The current code is quite tricky, and and it is easy
> > > to rearrage the code to make the problem disappear. So fix it.
> > 
> > I don't see this warning here (gcc 4.6.2.) While I see why it can be
> > reported, I don't really understand why your change makes it disappear,
> > as you still depend on the value of a local variable, which could have
> > changed between the moment you set sc_addr[1] and the moment you use
> > it. I'm curious why the compiler is able to keep track of the value in
> > one case and not in the other case.
> > 
> > Out of curiosity, have you tried defining kind as const? If it makes
> > the compiler equally happy, I think it would be a better way to solve
> > this warning.
> 
> did you have time to look into this some more ? Statistically, I see the warning
> in about one out of ten randconfig builds.

No I did not, and wont. My time is better spent on other tasks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
