From: dtor@insightbb.com (Dmitry Torokhov)
Date: Mon, 03 Jul 2006 02:33:41 +0000
Subject: [lm-sensors] [RFC] Apple Motion Sensor driver
Message-Id: <200607022233.42055.dtor@insightbb.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060702222649.GA13411@hansmi.ch>
In-Reply-To: <20060702222649.GA13411@hansmi.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, khali@linux-fr.org, linux-kernel@killerfox.forkbomb.ch, benh@kernel.crashing.org, johannes@sipsolutions.net, stelian@popies.net, chainsaw@gentoo.org

Hi Michael,

On Sunday 02 July 2006 18:26, Michael Hanselmann wrote:
> 
> +
> +	if (x)
> +		*x = tmpx;
> +	if (y)
> +		*y = tmpy;
> +	if (z)
> +		*z = tmpz;


All callers of ams_sensors use all 3 arguments, why bother with temps?

> +
> +	ams.idev->name = "Apple Motion Sensor";
> +	ams.idev->id.bustype = BUS_I2C;

Should it be always BUS_I2C? Maybe it should be BUS_HOST in case of PMU?

> +	ams.idev->id.vendor = 0;

Please add:

	ams.idev->cdev.dev = &ams.of_dev->dev;

so that the input device has a proper parent in sysfs hierarchy.

-- 
Dmitry

