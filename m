From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 25 Sep 2010 10:56:44 +0000
Subject: Re: [lm-sensors] [GIT PULL] hwmon fixes for 2.6.36
Message-Id: <20100925125644.13f6ab91@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1285378081-7902-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1285378081-7902-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Fri, 24 Sep 2010 18:28:01 -0700, Guenter Roeck wrote:
> Hi Linus,
> 
> Please pull hwmon subsystem fixes for Linux 2.6.36 from:
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/groeck/staging.git hwmon-for-linus
> 
> Thanks,
> Guenter Roeck
> 
> ------
> 
> Guenter Roeck (1):
>       MAINTAINERS: Update hwmon entry
> 
> Jan Beulich (7):
>       x86/hwmon: fix module init for hotplug-but-no-device-found case
>       x86/hwmon: avoid deadlock on CPU removal in pkgtemp
>       x86/hwmon: don't leak device attribute file from pkgtemp_probe() and pkgtemp_remove()
>       x86/hwmon: fix initialization of coretemp
>       x86/hwmon: fix initialization of pkgtemp
>       x86/hwmon: register alternate sibling upon CPU removal
>       x86/hwmon: pkgtemp has no dependency on PCI
> 
> Takashi Iwai (1):
>       hwmon: (lis3) Fix Oops with NULL platform data

Thanks a lot for all the review work, Guenter, I appreciate it a lot! I
didn't quite expect you to get up to speed so fast!

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
