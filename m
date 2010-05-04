From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 04 May 2010 11:32:00 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: applesmc: Add temperature sensor
Message-Id: <20100504133200.34413e2b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1272966929-14501-1-git-send-email-rydberg@euromail.se>
	<20100504120638.70244e8e@hyperion.delvare>
	<4BE001E7.9030605@euromail.se>
In-Reply-To: <4BE001E7.9030605@euromail.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrik Rydberg <rydberg@euromail.se>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Alex Murray <murray.alex@gmail.com>

On Tue, 04 May 2010 13:15:51 +0200, Henrik Rydberg wrote:
> Jean Delvare wrote:
> [...]
> >> @@ -1578,6 +1717,8 @@ static int __init applesmc_init(void)
> >>  		}
> >>  		ret = sysfs_create_file(&pdev->dev.kobj,
> >>  						temperature_attributes[i]);
> > 
> > Missing error handling.
> > 
> >> +		ret = sysfs_create_file(&pdev->dev.kobj,
> >> +						label_attributes[i]);
> >>  		if (ret)
> >>  			goto out_temperature;
> >>  	}
> >
> 
> Shoot, my bad review. Will send a new patch. While at it, the same function
> seems to leak fan attribute groups. Want me to correct such issues (in another
> patch)?

Yes please. As a bugfix, that would even be a candidate for 2.6.34. I
have another patch (for asc7621) pending already.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
