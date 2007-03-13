From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 13 Mar 2007 06:43:27 +0000
Subject: [lm-sensors] [PATCH] w83627hf: Convert to a platform driver
Message-Id: <20070313074327.40c438c6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070311100154.89c57cb0.khali@linux-fr.org>
In-Reply-To: <20070311100154.89c57cb0.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guillaume,

On Mon, 12 Mar 2007 16:16:19 +0100, Guillaume Millet wrote:
> Jean Delvare a ?crit :
> > Convert the w83627hf driver from the nonsensical i2c-isa hack to a
> > regular platform driver.
> 
> About this driver, w83627hf, Carlos Olalla proposed a patch in order to 
> adds support for pwm clock selection and pwm clock scaling, but this one 
> was not accepted : 
> http://article.gmane.org/gmane.linux.drivers.sensors/10841.

That patch wasn't acceptable because it did now follow our standard
sysfs interface. File naming was wrong, and more importantly, the
values were raw register values instead of frequencies expressed in Hz.

> Since, I haven't seen a patch for pwm clock scaling. Is someone working 
> on this feature ?

I don't think so, I did not see any post or patch about this for months.

-- 
Jean Delvare

