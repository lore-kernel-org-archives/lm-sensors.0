From: Axel.Thimm@physik.fu-berlin.de (Axel Thimm)
Date: Thu, 19 May 2005 06:24:11 +0000
Subject: i2c & lm_sensors for RH
Message-Id: <20030811123158.GB1097@pua.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030802172008.GA10034@puariko.nirvana>
In-Reply-To: <20030802172008.GA10034@puariko.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Aug 11, 2003 at 11:27:24AM +0200, Jean Delvare wrote:
> > I have uploaded
> > 
> > o latest RH kernel with i2c/lm_sensors 2.8.0 patched in
> > o lm_sensors 2.8.0 userland
> > o bttv with i2c 2.8.0 patches
> > o ivtv with i2c 2.8.0 patches
> > o saa7134 with i2c 2.8.0 patches
> > 
> > for the current three RH releases (9, 8.0 and 7.3)
> > at http://atrpms.physik.fu-berlin.de/
> 
> I linked to it from our news page and our download page.

Thanks! :)

I forgot to mention: The 2.8.0 enabled kernel and drivers have a tag
like 2.4.20-19.23.rhxxx.at, while the non-enabled RH proper stuff has
the usual 2.4.20-19.x tag.

> > There is another i2c application that break with the i2c changes:
> > lirc. At least the current CVS code bails out. Could you provide a
> > patch for the CVS bits (non-CVS is far to old)? :)
> 
> I am currently unable to check the CVS tree out, due to a stale read
> lock it seems. I'll try again later and let you know when a patch is
> ready.

OK, thanks.
I will be on vacation this week, and lirc is quite a nasty beast to
package (all different builds have the same name), so I won't be
really looking into it until the end of August, I guess.

BTW the 2.8.0 patched drivers, do they compile against < 2.8.0? I
assumed not, so I have built in a 2.8.0 kernel detection in the rpm
specfiles, so the patches are only applied if the kernel has 2.8.0 i2c
embedded (currently the match checking is exact, so it needs to be
reworked for 2.8.1 or 2.9.0).
-- 
Axel.Thimm@physik.fu-berlin.de
