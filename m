From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 01 May 2006 16:01:38 +0000
Subject: [lm-sensors] Driver question
Message-Id: <20060501180138.19ef7062.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <347F0EE2DB29484092B27DF737737AC2040E12B9@idbexc01.americas.cpqcorp.net>
In-Reply-To: <347F0EE2DB29484092B27DF737737AC2040E12B9@idbexc01.americas.cpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Marc,

> Thanks for the reply.  Can you point me to a location for the driver?

From 2.6.11 to 2.6.12, drivers/i2c/chips/smsc47b397.c in the Linux
source tree. Since 2.6.13, drivers/hwmon/smsc47b397.c in the Linux
source tree.

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=drivers/hwmon/smsc47b397.c

-- 
Jean Delvare

