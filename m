From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 20 Sep 2006 18:40:04 +0000
Subject: [lm-sensors] Call for 2.10.1
Message-Id: <20060920204004.220fc645.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060819105454.c6c438ed.khali@linux-fr.org>
In-Reply-To: <20060819105454.c6c438ed.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Juerg,

> > Will you have the time to provide a patch "fixing" the 2.4 driver by
> > the end of the week?
> 
> I believe so yes, but it won't be well tested (other than running
> sensors and making sure the output under 2.6 and 2.4 match).

Should be good enough. At least it can't be worse than shipping a
version of libsensors/sensors with alarm bits which don't match the 2.6
driver channels - that could really confuse the users.

Thanks,
-- 
Jean Delvare

