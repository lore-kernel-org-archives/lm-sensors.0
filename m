From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 14 Aug 2010 17:44:33 +0000
Subject: Re: [lm-sensors] [PATCH 3/42] drivers/hwmon: Adjust confusing if
Message-Id: <20100814194433.2e9b7aef@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.64.1008052217240.31692@ask.diku.dk>
	<AANLkTikGYhWCVW1HqdhwqRHaph54S9U4eKi7nNLHktMV@mail.gmail.com>
In-Reply-To: <AANLkTikGYhWCVW1HqdhwqRHaph54S9U4eKi7nNLHktMV@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Charles Logan <cybercorecentre@gmail.com>
Cc: Julia Lawall <julia@diku.dk>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Julia, Charles,

On Fri, 6 Aug 2010 11:04:20 +0200, Charles Logan wrote:
> Corrected:
> 
> > // <smpl>
> > @r disable braces5@
> > position p1,p2;
> > statement S1,S2;
> > @@
> >
> > (
> > if (...) { ... }
> > |
> > if (...) S1@p1 S2@p2
> > )
> >
> > @script:python@
> > p1 << r.p1;
> > p2 << r.p2;
> > @@
> >
> > if (p1[0].column = p2[0].column):
> >  cocci.print_main("branch",p4)
> >  cocci.print_secs("after",p5)
> > // </smpl>
> 
> 
> 
> On Thu, Aug 5, 2010 at 10:17 PM, Julia Lawall <julia@diku.dk> wrote:
> > From: Julia Lawall <julia@diku.dk>
> >
> > Move the if(err) statement after the if into the if branch indicated by its
> > indentation.  The preceding if(err) test implies that err cannot be nonzero
> > unless the if branch is taken.
> >
> > The semantic match that finds this problem is as follows:
> > (http://coccinelle.lip6.fr/)
> >
> > // <smpl>
> > @r disable braces4@
> > position p1,p2;
> > statement S1,S2;
> > @@
> >
> > (
> > if (...) { ... }
> > |
> > if (...) S1@p1 S2@p2
> > )
> >
> > @script:python@
> > p1 << r.p1;
> > p2 << r.p2;
> > @@
> >
> > if (p1[0].column = p2[0].column):
> >  cocci.print_main("branch",p1)
> >  cocci.print_secs("after",p2)
> > // </smpl>
> >
> > Signed-off-by: Julia Lawall <julia@diku.dk>
> >
> > ---
> >  drivers/hwmon/k8temp.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/hwmon/k8temp.c b/drivers/hwmon/k8temp.c
> > index 8bdf80d..b9bb3e0 100644
> > --- a/drivers/hwmon/k8temp.c
> > +++ b/drivers/hwmon/k8temp.c
> > @@ -252,12 +252,13 @@ static int __devinit k8temp_probe(struct pci_dev *pdev,
> >                                   &sensor_dev_attr_temp3_input.dev_attr);
> >                if (err)
> >                        goto exit_remove;
> > -               if (data->sensorsp & SEL_PLACE)
> > +               if (data->sensorsp & SEL_PLACE) {
> >                        err = device_create_file(&pdev->dev,
> >                                           &sensor_dev_attr_temp4_input.
> >                                           dev_attr);
> >                        if (err)
> >                                goto exit_remove;
> > +               }
> >        }
> >
> >        err = device_create_file(&pdev->dev, &dev_attr_name);
> >

Applied, thanks. Fortunately the bug is harmless, as noted in the patch
comment.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
