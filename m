From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: RFC [PATCH 2.6] I2C: w83627ehf: add fan_div no-op store method
Message-Id: <ZdowSWp7.1115978663.1398280.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <bgt881pvivku9pn8t1bfki4hi8f243n72p@4ax.com>
In-Reply-To: <bgt881pvivku9pn8t1bfki4hi8f243n72p@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Grant,

> This small patch adds no-op fan_div store method to silence warning
> from 'sensors -s'.  Compile tested.

No, sorry.

For one thing I do not want 2.6 drivers to be crippled with compatibility
tricks when we can easily move the tricks to user-space, as I explained
earlier.

For another... The w83627ehf driver does not exist before Linux 2.6. The
official version which will be included in 2.6.13 is the only one we
have to support, and it has the auto fan div functionality. So there is
absolutely no reason why a user would ever try to set the clock divider
manually. The fanN_div features are clearly tagged read-only in
libsensors, and the default configuration file doesn't attempt to set
them, so everything is consistent already. So what exactly were you
trying to fix in the first place please?

--
Jean Delvare
