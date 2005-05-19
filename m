From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: We will port w83792d.c to linux-2.6
Message-Id: <20050418215833.5d535a92.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Chunhao,

> When I develop the 792 driver for linux-2.6, I use the method you told
> me below, It works well. But I have one question here:
> Before the linux-2.6 kernel which contains 792 driver released, if
> someone wants to use 792 driver for linux-2.6, but he do NOT want to
> compile his 2.6 kernel, because he's not familiar with it.
> 
> Do you have some easier method for users? For example, user only need
> to compile the 792 module instead of the whole kernel, then load the
> bus driver and this 792 driver, the 792 can work. Just like the
> lm_sensors for linux-2.4

Really easy:

1* Create a Makefile where the w83792d.c file is, with one line:
obj-m := w83792d.o

2* Type: make -C /usr/src/linux SUBDIRS=$PWD modules
(replace /usr/src/linux with the path to the Linux sources tree)

And you're done :) You only need to copy w83792d.ko to
/lib/modules/`uname -a`/kernel/drivers/i2c/chips before you modprobe it.
Alternatively you can do insmod ./w83792d.ko without installing it, I
think it works.

-- 
Jean Delvare
