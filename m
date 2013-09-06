From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 06 Sep 2013 20:22:04 +0000
Subject: Re: [lm-sensors] Cannot compile w83627ehf standalone driver
Message-Id: <20130906222204.74f11202@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4gtj299ua16tgbppavpscp3ljolbrs8o8r@4ax.com>
In-Reply-To: <4gtj299ua16tgbppavpscp3ljolbrs8o8r@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 06 Sep 2013 08:37:43 -0700, singumal wrote:
> I have an ASRock IMB-170 Mini-ITX board; 3.3.4's sensors-detect shows:
> 
>   Found `Winbond W83627UHG/NCT6627UD Super IO Sensors'        Success!
>       (address 0x290, driver `w83627ehf')
> 
> I'm on an older kernel, and I can't seem to compile the driver
> from:
> 
>    http://khali.linux-fr.org/devel/lm-sensors/drivers/w83627ehf/
> 
> 
> [root@plain1 driver]# uname -a
> Linux plain1 2.6.18-274.el5 #1 SMP Fri Jul 22 04:43:29 EDT 2011 x86_64 x86_64 x86_64 GNU/Linux
> [root@plain1 driver]# make
>   CC [M]  /root/driver/w83627ehf.o
> /root/driver/w83627ehf.c: In function `in_from_reg':
> /root/driver/w83627ehf.c:416: error: implicit declaration of function `DIV_ROUND_CLOSEST'
> ... [many more errors and warnings]

This driver was never tested for kernels older than 2.6.32. More
compatibility work would be needed to get it to build and work on
kernel 2.6.18.

I'm wondering if maybe Redhat can provide a backported version as a
separate package? You're probably not the only one asking for this, as
this is a popular driver.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
