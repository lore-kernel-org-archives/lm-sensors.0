From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:11 +0000
Subject: [BK PATCH] More i2c driver fixes for 2.6.0-test2
Message-Id: <20030809093811.0a7f7d1b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030808235501.GA2795@kroah.com>
In-Reply-To: <20030808235501.GA2795@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Here are some more i2c driver fixes for 2.6.0-test2.  They include a
> fix for the driver model code (no release function, so easy oopses
> could happen by users), and removing usage of the struct device.name
> field as that is about to go away.
> 
> Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.5

Do any of these apply to our CVS tree?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
