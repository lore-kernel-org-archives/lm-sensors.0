From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: linux-2.6.1, ECS K7S5A / SiS735
Message-Id: <20040120055122.GH10681@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040113004723.5892cfb2.Dexter.Filmore@gmx.de>
In-Reply-To: <20040113004723.5892cfb2.Dexter.Filmore@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Dexter Filmore <Dexter.Filmore@gmx.de> [2004-01-15 20:47:41 +0100]:
> On Thu, 15 Jan 2004 18:18:09 +0100
> Jean Delvare <khali@linux-fr.org> wrote:
> 
> > > here seems to be the problem: i2c-core is statically, i2c-dev and
> > > i2c-sis96x are loaded as modules. after that I did i2cdump.
> > > it doesn't find any buses. i2cdetect 0 tells me there is no such
> > > device. strange, i did mkdev.sh and the files are in dev.
> > > 
> > > ideas? do have to hack more than i2cdetect to make sis96x work on my
> > > sis735 board?

No, i2cdetect should work on any i2c bus that works.  It sounds like the
i2c-sis96x driver isn't recognizing your setup.

> > I'm rather clueless. I'm not even sure wether this is related to the
> > sis96x driver or not. Maybe you want to see with Mark, our SiS busses
> > expert.
> 
> I suspect this to be a kernel .config issue, but I never did sensors stuff
> before. I'll write to said Mark.

Not if I write you first. ;)

> Besides - is there still a mailing list? Didn't find subscription infos.

Yes; you can post without subscribing.  You've been doing this already.

Could you send the results of 'lspci -v' and 'lspci -n' on your system
while running 2.6.x?  Does the i2c-sis645 driver work for you with
kernel 2.4.x?  If so, please send both 'lspci' results while running
that also.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
