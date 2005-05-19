From: ac9410@attbi.com (Albert Cranford)
Date: Thu, 19 May 2005 06:23:52 +0000
Subject: [PATCH] More i2c driver changes for 2.5.66
Message-Id: <3E8C3A5A.80804@attbi.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1048295086481@kroah.com>
In-Reply-To: <1048295086481@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Linux kenel mail list removed on purpose.
Whoa!  I just saw the patches submitted to linux kernel
and not to sensors list.  Come on Greg this is not proper.

Whats this config item CONFIG_SENSOR ?
This is the wrong way to register sensors to sysfs.
New sensors can never be tested before included in the kernel
with this philosophy.
Whats wrong with the opposite philosophy of creating
a sysfs interface and in the sensor driver just make
the sysfs call?

Albert
