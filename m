From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Wed, 13 Feb 2008 12:55:58 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm92) Add individual alarm files
Message-Id: <20080213125558.GA1154@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080106152552.3ce76bba@hyperion.delvare>
In-Reply-To: <20080106152552.3ce76bba@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

Thank you Juerg for the reviews, they are much appreciated.

* Juerg Haefliger <juergh@gmail.com> [2008-02-09 22:16:14 -0800]:
> Looks good and compiles cleanly.
> 
> Acked-by: Juerg Haefliger <juergh at gmail.com>
> 
> 
> > The new libsensors needs these individual alarm files.
> >
> > Signed-off-by: Jean Delvare <khali at linux-fr.org>
> > ---
> > James, would you have the opportunity to test this patch?
> >
> >   drivers/hwmon/lm92.c |   16 +++++++++++++++-
> >   1 file changed, 15 insertions(+), 1 deletion(-)
> >

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
