From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Wed, 13 Feb 2008 12:57:59 +0000
Subject: Re: [lm-sensors] hwmon: (vt8231) Add individual alarm files
Message-Id: <20080213125759.GE1154@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080106154602.3f81ae40@hyperion.delvare>
In-Reply-To: <20080106154602.3f81ae40@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

* Juerg Haefliger <juergh@gmail.com> [2008-02-09 23:06:56 -0800]:
> Looks good - assuming the bit positions are correct, which I can't
> verify without a datasheet - and compiles cleanly.
> 
> Acked-by: Juerg Haefliger <juergh at gmail.com>
> 
> 
> > The new libsensors needs these individual alarm files.
> >
> > Signed-off-by: Jean Delvare <khali at linux-fr.org>
> > Cc: Roger Lucas <roger at planbit.co.uk>
> > ---
> > Roger, can you please test and/or review this patch?
> >
> >   drivers/hwmon/vt8231.c |   40 ++++++++++++++++++++++++++++++++++++++--
> >   1 file changed, 38 insertions(+), 2 deletions(-)

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
