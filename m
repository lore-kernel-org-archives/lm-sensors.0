From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 05 Sep 2012 13:42:34 +0000
Subject: Re: [lm-sensors] [PATCH 2/4] hwmon: (w83793) Remove legacy chassis intrusion detection attributes
Message-Id: <20120905134234.GA26996@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1346810610-26352-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1346810610-26352-3-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Sep 05, 2012 at 10:53:31AM +0200, Jean Delvare wrote:
> On Wed, 5 Sep 2012 10:52:14 +0200, Jean Delvare wrote:
> > On Tue,  4 Sep 2012 19:03:28 -0700, Guenter Roeck wrote:
> > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > ---
> > >  drivers/hwmon/w83792d.c |   58 ++---------------------------------------------
> > >  1 file changed, 2 insertions(+), 56 deletions(-)
> > > 
> > > diff --git a/drivers/hwmon/w83792d.c b/drivers/hwmon/w83792d.c
> > > index 0ba5a2b..06d6f56 100644
> > > --- a/drivers/hwmon/w83792d.c
> > > +++ b/drivers/hwmon/w83792d.c
> > > (...)
> > 
> > Acked-by: Jean Delvare <khali@linux-fr.org>
> 
> ... but please fix the subject line before you commit, the driver name
> is wrong.
> 
Oops ... sure will do.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
