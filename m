From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 30 Aug 2012 21:09:59 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: add Maxim MAX197 support
Message-Id: <20120830210959.GA11153@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1346351995-9038-1-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1346351995-9038-1-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: lm-sensors@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org

On Thu, Aug 30, 2012 at 02:39:55PM -0400, Vivien Didelot wrote:
> The MAX197 is an A/D converter, made by Maxim. This driver currently
> supports the MAX197, and MAX199. They are both 8-Channel, Multi-Range,
> 5V, 12-Bit DAS with 8+4 Bus Interface and Fault Protection.
> 
> The available ranges for the MAX197 are {0,-5V} to 5V, and {0,-10V} to
> 10V, while they are {0,-2V} to 2V, and {0,-4V} to 4V on the MAX199.
> 
> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>

Hi Vivien,

I have the solution for the platform driver.

enum chips { max197, max199 };

[ ... ]

static struct platform_device_id max197_driver_ids[] = {
        {
		.name = "max197",
		.driver_data = max197,
	}, {
		.name = "max199",
		.driver_data = max199,
	}
};
MODULE_DEVICE_TABLE(platform, max197_driver_ids);

In the probe function:

	enum chips chip = platform_get_device_id(pdev)->driver_data;

This way you only need a single platform driver, no module alias, and you don't
need strcmp() in the probe function to detect the chip type.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
