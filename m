From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 27 Oct 2005 22:39:40 +0000
Subject: [lm-sensors] Re: [patch 5/9] I2C: remove i2c_driver's .owner and
Message-Id: <20051027224032.2191a2b4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051024212541.892926000@antares.localdomain>
In-Reply-To: <20051024212541.892926000@antares.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mauro,

Please don't forget to explicitely list Laurent in To: or CC:.

> We've included several new I2C drivers on V4L CVS tree, and I'm about
> to send the newer patchset series to -mm. If you want to see it, these
> are early available at:
>   http://linuxtv.org/download/video4linux/patches/2.6.14-rc5

About this, I've noticed two issues with these patches:

v4l_635_add_bttv_card_137_conceptronic_ctvfmi_v2.patch
Creates a bttv-cards.c.orig file.

v4l_801_whitespaces_cleanups.patch
Creates a tvaudio.c.orig file.

I would also suggest that you limit the length of the patch file names. v4l_716_from_markus_rechberger_mrechberger_gmail_com_ludovico_cavedon_cavedon_sssup_it_mauro_carvalho_chehab_mchehab_brturbo_com_br_.patch is a bit too long IMHO ;)

> Basically, your patches should be go after the V4L patchsets, and
> should also include some newer boards, like:
> 	em2820-i2c.c
> 	cs53l32a.c
> 	wm8775.c
> 	saa711x.c
> 	tvp5150.c

No, it doesn't work that way. i2c patches are applied before the v4l
patches in -mm, and I doubt Andrew is going to reorder patchsets every
now and then. There simply are too many dependencies to deal with.

So, just send your v4l patches to Andrew when they're ready. I'll send
my i2c patches (including Laurent's) when they are ready, with a note
to Andrew on how to fix drivers which might break, and he'll deal with
that just fine.

You shouldn't underestimate Andrew's ability to deal with conflicts of
all sorts. He's damn good at it.

When either the i2c or v4l patches finally get merged into Linus' tree,
the other one of us will have to update his patchset. That shouldn't be
difficult either.

Thanks,
-- 
Jean Delvare
