From: Adrian Bunk <bunk@kernel.org>
Date: Wed, 17 Oct 2007 19:50:36 +0000
Subject: Re: [lm-sensors] [2.6 patch] hwmon/ibmpex.c: fix NULL dereference
Message-Id: <20071017195036.GC3778@stusta.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071017192902.GB3778@stusta.de> <29495f1d0710171239i30776a2ci6db65c4f135b0754@mail.gmail.com>
In-Reply-To: <29495f1d0710171239i30776a2ci6db65c4f135b0754@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: "Darrick J. Wong" <djwong@us.ibm.com>, "Mark M. Hoffman" <mhoffman@lightlink.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Wed, Oct 17, 2007 at 12:39:59PM -0700, Nish Aravamudan wrote:
> On 10/17/07, Adrian Bunk <bunk@kernel.org> wrote:
> > Don't dereference "data" when we know for sure it's NULL.
> >
> > Spotted by the Coverity checker.
> >
> > Signed-off-by: Adrian Bunk <bunk@kernel.org>
> >
> > ---
> > 66bec2ef5c6d55fc30ef6ac5bb97fdfcfaf394f2
> > diff --git a/drivers/hwmon/ibmpex.c b/drivers/hwmon/ibmpex.c
> > index c462824..e14ce3d 100644
> > --- a/drivers/hwmon/ibmpex.c
> > +++ b/drivers/hwmon/ibmpex.c
> > @@ -457,7 +457,7 @@ static void ibmpex_register_bmc(int iface, struct device *dev)
> >         data = kzalloc(sizeof(*data), GFP_KERNEL);
> >         if (!data) {
> >                 printk(KERN_ERR DRVNAME ": Insufficient memory for BMC "
> > -                      "interface %d.\n", data->interface);
> > +                      "interface.\n");
> 
> Hrm but what data->interface would be is specified by the iface
> parameter? Just spit that out instead?

This is only a symptom of the problem that kzalloc() failed, and when 
you are getting into such a situation here you have bigger problems - 
and these are not related to this driver.

Feel free to send a different patch, but IMHO "Insufficient memory" 
alone is enough information in this case.

> Thanks,
> Nish

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
