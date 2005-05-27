From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 27 May 2005 22:47:33 +0000
Subject: [lm-sensors] RFC PATCH I2C: w83781d: remove redundant w83697hf,
Message-Id: <20050527224715.344d6c42.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <eq4d91hhldf7u9jjp8s03hc7qrv0e9jo1k@4ax.com>
In-Reply-To: <eq4d91hhldf7u9jjp8s03hc7qrv0e9jo1k@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant,

> This patch replaces previous one posted this day, removing redundant 
> drivers w83697hf, w83627hf, w83627thf from w83781d as they are
> handled by the w83627hf driver.  Compile tested.

Please do not remove the w83627hf support for now. The W83627HF chip has
an I2C/SMBus interface, which the w83627hf driver doesn't support (and
we don't want to add I2C/SMBus support to the w83627hf driver).

We may decide to drop support later if we are certain that all systems
using the I2C interface of their W83627HF whip can be switched to use the ISA
access instead. I'm not certain, so we better be prudent. We may want to
first add warning messages to the w83781d driver when this feature is
used, and only remove support after some time.

Thanks,
-- 
Jean Delvare
