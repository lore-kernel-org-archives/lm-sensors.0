From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 21 Aug 2006 09:15:34 +0000
Subject: [lm-sensors] [patch 0/3] pc87360 - fix unchecked
Message-Id: <20060821111534.a7919409.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44E72DE7.10907@gmail.com>
In-Reply-To: <44E72DE7.10907@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jim,

> FWIW -
> The patchset survived this stress-test:
>      for i in `seq 1000`; do { rmmod pc87360;  modprobe pc87360;  
> sensors -s; sensors; }  done
> It takes about 3.5 secs to re-mod, and about 0.3 sec to reset and query 
> sensors.

Given that we aren't suspecting a race condition, this type of test
isn't really helpful. More interesting would be a comparison of the
contents of /sys/class/hwmon/hwmon0/device before and after the
patches. If the contents differ, something's wrong, else everything
should be OK - or at least there is no regression.

Thanks,
-- 
Jean Delvare

