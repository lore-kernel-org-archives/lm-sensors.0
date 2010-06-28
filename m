From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 28 Jun 2010 06:17:47 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (coretemp) Properly label the
Message-Id: <20100628081747.6f79da46@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100627133601.3644b03a@hyperion.delvare>
In-Reply-To: <20100627133601.3644b03a@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Huaxu,

On Mon, 28 Jun 2010 13:56:25 +0800, Wan, Huaxu wrote:
> Good pathes. Thank you, Jean. 
> 
> Please feel free to add the line Acked-by: Huaxu Wan <huaxu.wan@intel.com>

Great, thanks for the review.

> BTW, I'm not sure whether I should forward these patches to Andrew
> Morton or you submit them again to LKML, because hwmon has no maintainer
> at present.

I have my own hwmon tree, so I'll push the patches to Linus myself.

> >-----Original Message-----
> >From: Jean Delvare [mailto:khali@linux-fr.org] 
> >Sent: Sunday, June 27, 2010 7:36 PM
> >To: LM Sensors
> >Cc: Wan, Huaxu
> >Subject: [PATCH 2/2] hwmon: (coretemp) Properly label the sensors
> >
> >Don't assume that CPU entry number and core ID always match. It
> >worked in the simple cases (single CPU, no HT) but fails on
> >multi-CPU systems.
> >
> >Signed-off-by: Jean Delvare <khali@linux-fr.org>
> >Cc: Huaxu Wan <huaxu.wan@intel.com>
> >---
> > drivers/hwmon/coretemp.c |    4 +++-
> > 1 file changed, 3 insertions(+), 1 deletion(-)
> >
> >--- linux-2.6.35-rc3.orig/drivers/hwmon/coretemp.c	
> >2010-06-27 10:14:51.000000000 +0200
> >+++ linux-2.6.35-rc3/drivers/hwmon/coretemp.c	2010-06-27 
> >10:19:19.000000000 +0200
> >@@ -53,6 +53,7 @@ struct coretemp_data {
> > 	struct mutex update_lock;
> > 	const char *name;
> > 	u32 id;
> >+	u16 core_id;
> > 	char valid;		/* zero until following fields 
> >are valid */
> > 	unsigned long last_updated;	/* in jiffies */
> > 	int temp;
> >@@ -75,7 +76,7 @@ static ssize_t show_name(struct device *
> > 	if (attr->index = SHOW_NAME)
> > 		ret = sprintf(buf, "%s\n", data->name);
> > 	else	/* show label */
> >-		ret = sprintf(buf, "Core %d\n", data->id);
> >+		ret = sprintf(buf, "Core %d\n", data->core_id);
> > 	return ret;
> > }
> > 
> >@@ -304,6 +305,7 @@ static int __devinit coretemp_probe(stru
> > 	}
> > 
> > 	data->id = pdev->id;
> >+	data->core_id = c->cpu_core_id;
> > 	data->name = "coretemp";
> > 	mutex_init(&data->update_lock);
> > 

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
