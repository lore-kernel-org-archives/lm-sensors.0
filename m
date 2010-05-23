From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Sun, 23 May 2010 10:28:29 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (adm1031) allow setting update
Message-Id: <4BF9034D.2050302@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1270671720-1575-3-git-send-email-iws@ovro.caltech.edu>
In-Reply-To: <1270671720-1575-3-git-send-email-iws@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

...
> @@ -75,6 +79,7 @@ struct adm1031_data {
>  	int chip_type;
>  	char valid;		/* !=0 if following fields are valid */
>  	unsigned long last_updated;	/* In jiffies */
> +	unsigned int update_rate;	/* In milliseconds */
Hi,

Just a quick comment.  Aren't the unit of a rate typically things per time period?
(i.e. same as frequency)  If you want to go with milli seconds, then surely
it should be called update_period.

Jonathan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
