From: Sergey Spiridonov <sena@hurd.homeunix.org>
Date: Thu, 25 Mar 2010 10:55:12 +0000
Subject: Re: [lm-sensors] Fujitsu D2778 sensors
Message-Id: <4BAB4110.5080309@hurd.homeunix.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <fphm77-hj.ln1@legba.gamic.com>
In-Reply-To: <fphm77-hj.ln1@legba.gamic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean

Jean Delvare wrote:

> You are running a relatively old version of the script. It doesn't know
> of the latest FSC chips (Hades and Syleus). Please try again with the
> latest version of the script:
> http://dl.lm-sensors.org/lm-sensors/files/sensors-detect

Thanks a lot, it works, but still there are problems. May be you can
help me to figure out, where should I look next.

I updated lm_sensors to 3.1.2. It helps, sensors-detect can sometimes
detect and load fschmd. But after rebooting it does not work anymore.

I experimented a bit and found out, that fschmd module works only if it
is loaded even times and does not work if it is loaded odd times!

Here is what happened:


Module fschmd is loaded at boot time by lm_sensors initialization
script, but is not working, sensors command does not show values and
/sys/class/hwmon does not contain entries. If I remove fschmd with
command "rmmod fschmd" and load it second time with "modprobe fschmd",
it starts working (sensors command shows temperatures, fans speed and so
on). If I remove it with rmmod and load 3rd time, it does not work. If I
remove it and load 4th time, it works and so on.

So, I did it several times with same effect: 1st, 3rd, 5th time it does
not work, 2nd, 4th, 6th time it works.

I assume this has to be something with initialization, timing or
something like this in kernel driver fschmd.

I will try to do BIOS upgrade, see if it helps...
-- 
Best regards, Sergey Spiridonov


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
