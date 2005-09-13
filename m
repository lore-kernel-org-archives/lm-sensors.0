From: grant_lkml@dodo.com.au (Grant Coady)
Date: Tue, 13 Sep 2005 04:01:29 +0000
Subject: [lm-sensors] Query: should I split adm9240 patch?
Message-Id: <vccci15r771u8go9tvrn50mo9e9tss5otl@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Is this too much for one patch?

adm9240 changlog:
remove half-bit offset from scaled zero value
remove i2c read/write debug wrappers
change kmalloc + memset to kzalloc
convert temperature accessors to Yani Ioannou's dynamic sysfs callbacks
convert voltage accessors to Yani Ioannou's dynamic sysfs callbacks
(perhaps some more cleanups)

Started on updating adm9240 today, best to know early if the patch 
should be split -- perhaps cleanups then dynamic sysfs?

Thanks,
Grant.

