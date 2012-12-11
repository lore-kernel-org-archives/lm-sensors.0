From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 11 Dec 2012 09:33:33 +0000
Subject: Re: [lm-sensors] Fwd:  Driver for Bulldozer
Message-Id: <20121211103333.3d8d9ea1@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAMcsHH3ou4U_v5oFGivFPKMKKWKG7guueS=byF5pTqB8Q9VuDQ@mail.gmail.com>
In-Reply-To: <CAMcsHH3ou4U_v5oFGivFPKMKKWKG7guueS=byF5pTqB8Q9VuDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 11 Dec 2012 04:20:22 -0500, Vahid Keykhaey wrote:
> Dear Mr Delvare,
> Hi,
> Thank you for the installation instructions, but it did not work. There was
> a problem. At line "make install", I got these:
> root@user-desktop:~/Desktop# make install
> test -d /lib/modules/3.2.0-23-generic/kernel/drivers/hwmon || mkdir
> /lib/modules/3.2.0-23-generic/kernel/drivers/hwmon
> cp k10temp.ko /lib/modules/3.2.0-23-generic/kernel/drivers/hwmon
> depmod -a -F /lib/modules/3.2.0-23-generic/build/System.map 3.2.0-23-generic
> FATAL: Could not open '/lib/modules/3.2.0-23-generic/build/System.map': No
> such file or directory
> make: *** [modules_install] Error 1

Your distribution puts the System.map file at a different location.
I've updated the Makefile, please download it again and it should work
now.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
