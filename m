From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Wed, 13 Feb 2008 12:56:49 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (smsc47m1) Add individual
Message-Id: <20080213125649.GC1154@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

* Juerg Haefliger <juergh@gmail.com> [2008-02-09 22:51:01 -0800]:
> Looks good - assuming the bit positions are correct, which I can't
> fully verify without a datasheet - and compiles cleanly.
> 
> Acked-by: Juerg Haefliger <juergh at gmail.com>
> 
> 
> > The new libsensors needs these individual alarm files.
> >
> > Signed-off-by: Jean Delvare <khali at linux-fr.org>
> > ---
> > Anyone with an SMSC LPC47M1xx-compatible chip that could test this
> > patch? Hartmut maybe?
> >
> >   drivers/hwmon/smsc47m1.c |   25 ++++++++++++++++++++++---
> >   1 file changed, 22 insertions(+), 3 deletions(-)

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
