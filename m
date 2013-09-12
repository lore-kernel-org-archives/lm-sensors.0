From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 12 Sep 2013 09:05:03 +0000
Subject: Re: [lm-sensors] Cannot compile w83627ehf standalone driver
Message-Id: <20130912110503.4fa7a103@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4gtj299ua16tgbppavpscp3ljolbrs8o8r@4ax.com>
In-Reply-To: <4gtj299ua16tgbppavpscp3ljolbrs8o8r@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 12 Sep 2013 01:56:30 -0700, singumal wrote:
> Trying it under CentOS 5.9, it still doesn't work:
> 
> [root@x59 ~]# cp /media/MULTIBOOT/Work/kmod-w83627ehf-0.0-8.el5.elrepo.x86_64.rpm .
> [root@x59 ~]# rpm -Uvh kmod-w83627ehf-0.0-8.el5.elrepo.x86_64.rpm
> warning: kmod-w83627ehf-0.0-8.el5.elrepo.x86_64.rpm: Header V3 DSA signature: NOKEY, key ID baadae52
> Preparing...                ########################################### [100%]
>    1:kmod-w83627ehf         ########################################### [100%]
> Working. This may take some time ...
> Done.
> [root@x59 ~]# modprobe w83627ehf
> FATAL: Error inserting w83627ehf (/lib/modules/2.6.18-348.el5/weak-updates/w83627ehf/w83627ehf.ko): No such device
> [root@x59 ~]# uname -a
> Linux x59 2.6.18-348.el5 #1 SMP Tue Jan 8 17:53:53 EST 2013 x86_64 x86_64 x86_64 GNU/Linux

Please check the kernel log after that, there may be a hint of why the
probe failed. For example ACPI resource conflict... sensors-detect
doesn't know about these.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
