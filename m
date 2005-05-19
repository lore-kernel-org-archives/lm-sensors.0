From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: sis5595
Message-Id: <20030716150446.18550542.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307161427.08403.linux@1g6.biz>
In-Reply-To: <200307161427.08403.linux@1g6.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I am using 2.6.0-test1,
> and I launched "sensors-detect",
> it told me I have an sis5595.
> So I began to port the 2.4.21 sis5595 driver to 2.6 kernel.
> Here are the beginning of my work, but I am stuck here :
> i2c_detect doesn't call sis5595_detect.

There are many, many SiS chipsets that are misdetected as SiS5595. I
suggest you begin with trying lm_sensors on a 2.4 kernel, so you'll see
if it works on your system. What's more, libsensors and most userspace
tools do not exist

> I don't know if it is because I haven't the good hardware or
> if I made a mistake. I seems I have something at adress 8008, but I
> don't have enougth experience in developping kernel drivers so I gived
> up, and I send you my work.

Your porting is wrong. In 2.5/2.6, sensor modules export their values
using sysfs, not procfs. And I guess you started with an old version of
sis5595.c, because many things I see in "your" code has been removed
from our times ago. If you really want to port the driver, please see
with Greg how to do this correctly.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
