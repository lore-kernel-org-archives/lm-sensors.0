From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: [lm-sensors] [PATCH 2.6] I2C: driver adm1026: remove die_code
Message-Id: <136j81devb8mhap9muu2adh3o2t09jehg3@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch removes die_code from adm1021 as nothing within 
the driver uses it.  Compile tested

--Grant.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
