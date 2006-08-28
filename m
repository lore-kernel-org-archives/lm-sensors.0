From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 28 Aug 2006 09:48:29 +0000
Subject: [lm-sensors] PATCH: hwmon-abituguru-suspend-resume.patch
Message-Id: <20060828114829.5bf4eb83.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44DB2470.3050507@hhs.nl>
In-Reply-To: <44DB2470.3050507@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hans,

> > Only include suspend/resume functions when CONFIG_PM is set.
> > 
> > Signed-off-by: Jean Delvare <khali at linux-fr.org>
> > ---
> >  drivers/hwmon/abituguru.c |    5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > --- linux-2.6.18-rc5.orig/drivers/hwmon/abituguru.c	2006-08-28 11:09:39.000000000 +0200
> > +++ linux-2.6.18-rc5/drivers/hwmon/abituguru.c	2006-08-28 11:31:26.000000000 +0200
> > @@ -1354,6 +1354,7 @@
> >  		return NULL;
> >  }
> >  
> > +#ifdef CONFIG_PM
> >  static int abituguru_suspend(struct platform_device *pdev, pm_message_t state)
> >  {
> >  	struct abituguru_data *data = platform_get_drvdata(pdev);
> > @@ -1372,6 +1373,10 @@
> >  	mutex_unlock(&data->update_lock);
> >  	return 0;
> >  }
> > +#else
> > +#define abituguru_suspend	NULL
> > +#define abituguru_resume	NULL
> > +#endif /* CONFIG_PM */
> >  
> >  static struct platform_driver abituguru_driver = {
> >  	.driver = {
> > 
> 
> Looks good, feel free to apply it I'll apply it locally too.

Can you add your Signed-off-by line? So that I can merge both and push
the change as a single patch.

Thanks,
-- 
Jean Delvare

