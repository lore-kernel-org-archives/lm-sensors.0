From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 24 Jul 2007 12:24:25 +0000
Subject: Re: [lm-sensors] [PATCH] THMC50 support for 2.6 (4th revision)
Message-Id: <20070724122425.GB3796@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070708224300.4507035b.krzysztof.h1@wp.pl>
In-Reply-To: <20070708224300.4507035b.krzysztof.h1@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Krzysztof:

> On Sun, 8 Jul 2007 22:43:00 +0200, Krzysztof Helt wrote:
> > I deliberately left the adm1022 always with 3 temperatures. It can be
> > changed later if the 3 temperatures should be available only in 3
> > temperatures mode. It is simpler to ignore unused one with config file at
> > the moment.

* Jean Delvare <khali@linux-fr.org> [2007-07-09 20:03:06 +0200]:
> I already expressed my disagreement. I really believe that the files
> for the 3rd temperature should only be created in 3 temperature mode.

I've applied this patch to testing... hopefully Linus will take it prior to
v2.6.23-rc2.  I would appreciate if you send an incremental patch which follows
Jean's advice about temp3.

Thanks & regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
