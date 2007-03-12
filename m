From: gmillet@crans.org (Guillaume Millet)
Date: Mon, 12 Mar 2007 15:16:19 +0000
Subject: [lm-sensors] [PATCH] w83627hf: Convert to a platform driver
Message-Id: <et3qnn$mns$1@sea.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070311100154.89c57cb0.khali@linux-fr.org>
In-Reply-To: <20070311100154.89c57cb0.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare a ?crit :
> Convert the w83627hf driver from the nonsensical i2c-isa hack to a
> regular platform driver.

About this driver, w83627hf, Carlos Olalla proposed a patch in order to 
adds support for pwm clock selection and pwm clock scaling, but this one 
was not accepted : 
http://article.gmane.org/gmane.linux.drivers.sensors/10841.

Since, I haven't seen a patch for pwm clock scaling. Is someone working 
on this feature ?

-- 
Guillaume Millet


