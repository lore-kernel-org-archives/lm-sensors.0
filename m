From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 26 Nov 2013 19:36:34 +0000
Subject: Re: [lm-sensors] [PATCH v2] Input: ads7846: Convert to hwmon_device_register_with_groups
Message-Id: <20131126203634.05c7baa1@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1385440744-6607-1-git-send-email-linux@roeck-us.net>
	<20131126185846.GB22242@core.coreip.homeip.net>
In-Reply-To: <20131126185846.GB22242@core.coreip.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Dmitry,

On Tue, 26 Nov 2013 10:58:46 -0800, Dmitry Torokhov wrote:
> On Mon, Nov 25, 2013 at 08:39:04PM -0800, Guenter Roeck wrote:
> > Simplify the code and create mandatory 'name' attribute by using
> > new hwmon API.
> 
> So this moves hwmon attributes from the parent i2c device to the hwmon
> device, right? Would not that break userspace which expects to find the
> attributes where they were?

libsensors supports that just fine since version 3.0.3 which was
released in September 2008, over 5 years ago.

Applications bypassing libsensors are on their own, and always have
been. But several other drivers have had their attributes in the hwmon
device forever so even these applications are likely to be happy with
other drivers moving in that direction.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
