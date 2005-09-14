From: grant_lkml@dodo.com.au (Grant Coady)
Date: Wed, 14 Sep 2005 00:48:53 +0000
Subject: [lm-sensors] [PATCH 0/3] hwmon: adm9240 updates
Message-Id: <b6lei150dlsi9sq9lvko2jen2pscaps5l3@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

This patch series updates the adm9240 driver with some cleanups and 
conversion to dynamic sysfs.

hwmon: adm9240 update 1/3: whitespace  >>> Resend, for complete set <<<

hwmon: adm9240 update 2/3: cleanups

make SCALE function return zero for zero input,
remove i2c read/write wrapper interface,
change kmalloc + memset to kzalloc

hwmon: adm9240 update 3/3: convert to dynamic sysfs accessors

This patch converts adm9240 to use Yani Ioannou's dynamic sysfs callbacks,
reducing driver memory footprint from 16312 to 14104 bytes on 2.6.14-rc1,
removing the old driver macro mess.

Run tested on Intel SE440BX-2 mobo.

Thanks,
Grant.

