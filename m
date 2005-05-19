From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:33 +0000
Subject: [PATCH] 1/4 WIP I2C kernel patches-config
Message-Id: <3CEC0E8D.B1CFCEFE@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3CE20AD5.5554A03@bellsouth.net>
In-Reply-To: <3CE20AD5.5554A03@bellsouth.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

If it doesn't work in 2.5 we shouldn't include it in a 2.5 patch.

Tom Rini wrote:
> 
> On Wed, May 15, 2002 at 08:14:31PM -0400, Mark D. Studebaker wrote:
> 
> > - Don't submit patches for anything not patched by mkpatch,
> >   that is, anything not in mkpatch/FILES. This includes *8xx* and
> >   *405*. The 405 stuff, I have a monster patch I got a month and
> >   a half ago, the only reason I haven't put it in yet is that it
> >   renames all the files. But anyway, if it isn't in mkpatch/FILES
> >   there's some reason. i2c-pcf-epp is really new. 8xx status unclear.
> 
> While the 4xx stuff is out of date, in the next round of patches, feel
> free to include the 8xx driver.  It hasn't been tested in a bit, but
> 8xx doesn't currently work in 2.5 right now anyways.   I'll attempt to
> test it out on 2.4 soon.
> 
> --
> Tom Rini (TR1265)
> http://gate.crashing.org/~trini/
