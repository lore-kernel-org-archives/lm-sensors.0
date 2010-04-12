From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 12 Apr 2010 14:29:12 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Switch applesmc maintainer
Message-Id: <20100412162912.74515ddd@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1271078868-3699-1-git-send-email-rydberg@euromail.se>
	<4BC32050.7080806@boichat.ch>
In-Reply-To: <4BC32050.7080806@boichat.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicolas Boichat <nicolas@boichat.ch>
Cc: Henrik Rydberg <rydberg@euromail.se>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Mon, 12 Apr 2010 21:29:52 +0800, Nicolas Boichat wrote:
> On 04/12/2010 09:27 PM, Henrik Rydberg wrote:
> > Nicolas has expressed a wish to be relieved from the maintenance
> > of applesmc, so we simply switch maintainer with this patch.
> 
> Thank you.
> 
> > Signed-off-by: Henrik Rydberg<rydberg@euromail.se>
> 
> Signed-off-by: Nicolas Boichat <nicolas@boichat.ch>
> 
> > ---
> >   MAINTAINERS |    4 ++--
> >   1 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 7a9ccda..13c5688 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -485,8 +485,8 @@ S:	Maintained
> >   F:	drivers/input/mouse/bcm5974.c
> >
> >   APPLE SMC DRIVER
> > -M:	Nicolas Boichat<nicolas@boichat.ch>
> > -L:	mactel-linux-devel@lists.sourceforge.net
> > +M:	Henrik Rydberg<rydberg@euromail.se>
> > +L:	lm-sensors@lm-sensors.org
> >   S:	Maintained
> >   F:	drivers/hwmon/applesmc.c
> >

Patch applied, thanks Henrik for stepping in!

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
