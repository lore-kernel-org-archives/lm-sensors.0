From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 26 Nov 2013 18:58:46 +0000
Subject: Re: [lm-sensors] [PATCH v2] Input: ads7846: Convert to hwmon_device_register_with_groups
Message-Id: <20131126185846.GB22242@core.coreip.homeip.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1385440744-6607-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1385440744-6607-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-input@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Hi Guenter,

On Mon, Nov 25, 2013 at 08:39:04PM -0800, Guenter Roeck wrote:
> Simplify the code and create mandatory 'name' attribute by using
> new hwmon API.

So this moves hwmon attributes from the parent i2c device to the hwmon
device, right? Would not that break userspace which expects to find the
attributes where they were?

Thanks.

-- 
Dmitry

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
