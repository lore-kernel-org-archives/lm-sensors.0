From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Wed, 13 Feb 2008 12:57:08 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (via686a) Add individual alarm	files
Message-Id: <20080213125708.GD1154@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080106154204.6abccc25@hyperion.delvare>
In-Reply-To: <20080106154204.6abccc25@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

* Juerg Haefliger <juergh@gmail.com> [2008-02-09 22:56:35 -0800]:
> Looks good - assuming the bit positions are correct, which I can't
> verify without a datasheet - and compiles cleanly.
> 
> Acked-by: Juerg Haefliger <juergh at gmail.com>
> 
> 
> > The new libsensors needs these individual alarm files.
> >
> > Signed-off-by: Jean Delvare <khali at linux-fr.org>
> > ---
> > Ian, would you have the opportunity to test this patch?
> >
> >   drivers/hwmon/via686a.c |   28 ++++++++++++++++++++++++++++
> >   1 file changed, 28 insertions(+)
> >

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
