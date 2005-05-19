From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: PATCH: lm92: port for 2.6 kernel
Message-Id: <20050228201329.7cfa6125.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <422318E5.4000201@katalix.com>
In-Reply-To: <422318E5.4000201@katalix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi James,

> > It is known to be broken, in particular setting limits doesn't work.
> > I have fixed almost everything yesterday. I'll finish the job this
> > evening, then I'll publish the new version, and would be very happy
> > if you could test it.
> 
> Sure I'll test it. I'll wait until you post the new version.

Here it is:
http://jdelvare.net1.nerim.net/sensors/linux-2.6.11-rc5-i2c-lm92-rc1.diff

Tested to work using i2c-stub (I have no LM92/MAX6635 chip myself). Note
that you'll need lm_sensors CVS for proper libsensors support and sample
sensors.conf section.

Waiting for your feedback :)

Thanks,
-- 
Jean Delvare
