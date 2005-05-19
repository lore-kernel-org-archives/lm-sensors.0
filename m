From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: [PATCH] Restore compatibility with 2.4 kernels
Message-Id: <20050308211216.7aca955e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050308142854.GA31643@bode.aurel32.net>
In-Reply-To: <20050308142854.GA31643@bode.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi James,

> In particular I was still seeing panics when unloading sensors
> drivers.   It seems to fix this.

I thought 2.9.0 had fixed the problem?

I'm a bit surprised that Aurelien's patch would help with sensors.
Supposedly the problem is the lack of binary compatibility between i2c
2.9.0 and in-kernel i2c. If you use lm_sensors 2.9.0 then you must use
i2c 2.9.0 as well, so what Aurelien's patch would address are problems
with in-kernel, non-sensors i2c stuff such as media/video drivers.

-- 
Jean Delvare
