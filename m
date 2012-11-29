From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 29 Nov 2012 11:48:07 +0000
Subject: Re: [lm-sensors] ITE it8603e
Message-Id: <20121129124807.1b251ef1@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAC-0Eqii0d94mPbn=8MoOn9UMP_srC3s5Dt3q45G+GTdo2kptw@mail.gmail.com>
In-Reply-To: <CAC-0Eqii0d94mPbn=8MoOn9UMP_srC3s5Dt3q45G+GTdo2kptw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 29 Nov 2012 03:09:01 -0700, David Hubbard wrote:
> +             * at all, not sure about the IT8728F or IT8603E
> +             * (IT8603E - "hwmon_vid: Unknown VRM version of your x86 CPU"
> +             * and cpu0_vid reads as 0)

This has nothing to do with the IT8603E but only with your CPU. Which
kernel version are you running, and can we see (one entry in)
your /proc/cpuinfo?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
