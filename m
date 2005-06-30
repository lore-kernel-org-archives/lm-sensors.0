From: BGardner@Wabtec.com (BGardner@Wabtec.com)
Date: Thu, 30 Jun 2005 17:01:54 +0000
Subject: [lm-sensors] [Patch 0/5] w1: sysfs, select-slave, ds2433
Message-Id: <F06EB2894F3F0D45AD9BEA7246DE9C90A452CA@WCSEXCMBS1.ad.wabtec.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200506300907.45063.bgardner@wabtec.com>
In-Reply-To: <200506300907.45063.bgardner@wabtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

> From the first view I do not have objection, thought not quite sure
why 
> do we need id/name sysfs file, since id without CRC already lives in 
> directory name?

I agree that the name entry isn't needed, since it matches the directory
name.
I would not object if it were removed.

The id is useful for two reasons:
 - smem uses it as the 64 bit id; w1-smem is not really needed anymore.
 - if I ever finish off w1-dev, it will be needed to do a MATCH ROM from
user space

Thanks,
Ben

