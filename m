From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 05 Sep 2012 08:53:31 +0000
Subject: Re: [lm-sensors] [PATCH 2/4] hwmon: (w83793) Remove legacy chassis intrusion detection attributes
Message-Id: <20120905105331.5ff25e6e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1346810610-26352-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1346810610-26352-3-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 5 Sep 2012 10:52:14 +0200, Jean Delvare wrote:
> On Tue,  4 Sep 2012 19:03:28 -0700, Guenter Roeck wrote:
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/hwmon/w83792d.c |   58 ++---------------------------------------------
> >  1 file changed, 2 insertions(+), 56 deletions(-)
> > 
> > diff --git a/drivers/hwmon/w83792d.c b/drivers/hwmon/w83792d.c
> > index 0ba5a2b..06d6f56 100644
> > --- a/drivers/hwmon/w83792d.c
> > +++ b/drivers/hwmon/w83792d.c
> > (...)
> 
> Acked-by: Jean Delvare <khali@linux-fr.org>

... but please fix the subject line before you commit, the driver name
is wrong.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
