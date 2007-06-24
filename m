From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 24 Jun 2007 16:05:18 +0000
Subject: Re: [lm-sensors] Fw: [PATCH] applesmc - switch to using
Message-Id: <20070624160518.GC26335@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <467CF0DA.9070309@boichat.ch>
In-Reply-To: <467CF0DA.9070309@boichat.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Dmitry:

* Nicolas Boichat <nicolas@boichat.ch> [2007-06-23 12:07:22 +0200]:
> I finally got a chance to test it, and it works.
> 
> > Dmitry
> >
> > HWMON: applesmc - convert to use input-polldev.
> >
> > Switch to using input-polldev skeleton instead of implementing
> > polling loop by itself. This also fixes problem with trylock
> > on a mutex in atomic context.
> >
> > Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> Signed-off-by: Nicolas Boichat <nicolas@boichat.ch>

I was about to pick this patch, but I couldn't determine the base version.
Can you respin it against 2.6.22-rc5 please?

Thanks & regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
