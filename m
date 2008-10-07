From: Frank Myhr <fmyhr@fhmtech.com>
Date: Tue, 07 Oct 2008 13:55:29 +0000
Subject: Re: [lm-sensors] [PATCH] Allow it87.c to handle IT8720
Message-Id: <48EB6A51.2040101@fhmtech.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <79c9d4530810061031v77c2b2afo983cdef4ca6bc71e@mail.gmail.com>
In-Reply-To: <79c9d4530810061031v77c2b2afo983cdef4ca6bc71e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean-Marc,

Your patch looks good to me with a few niggles:


> To:
> LKML <linux-kernel@vger.kernel.org>, "LM Sensors"
> <lm-sensors@lm-sensors.org>

I don't know if it's necessary/recommended to submit directly to LKML in
addition to the lm-sensors list. (Maybe somebody else can comment on that.)


> The goal of this patch is to allow it87.c to handle IT8720 chipset
> like IT8718 in order to retreive voltage, temperatures and fans speed
> from sensors tools.
> 
> JMS
> 
> Patch also attached.

Good description but the "Patch also attached" is superfluous; your
[PATCH] subject line already says that. I believe these comments are
copied verbatim into the kernel git changelog, so it's important to keep
them succinct.

More importantly, you need to sign your patch with:

Signed-off-by: [your real name] [your email address]
---


> --- linux-2.6.27-rc8/drivers/hwmon/it87.c.orig  2008-10-02
> 09:04:44.000000000 -0400
> +++ linux-2.6.27-rc8/drivers/hwmon/it87.c       2008-10-06
> 13:27:08.000000000 -0400

Please make sure your mailer is not wrapping lines, it looks here like
it is.


Regards,
-Frank

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
