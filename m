From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 29 May 2005 10:46:45 +0000
Subject: [lm-sensors] RFC PATCH lm_sensors2: w83781d: remove non-i2c
Message-Id: <20050529104656.7a96a5b4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <0cci9197ou579v4v9drecriedotimshe6i@4ax.com>
In-Reply-To: <0cci9197ou579v4v9drecriedotimshe6i@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant,

> This patch against today's CVS removes non-i2c w83697hf SuperIO
> sensor  chip support from w83781d driver.  Compile tested with
> 2.4.30-hf2 kernel.

Patch looks all OK to me. However, additional changes to
doc/chips/SUMMARY and doc/chips/w83781d would be needed.

Thanks,
-- 
Jean Delvare
