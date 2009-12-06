From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 06 Dec 2009 13:52:16 +0000
Subject: Re: [lm-sensors] Controlling fans using hddtemp?
Message-Id: <20091206145216.6c17db46@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <9871ee5f0912030839x10f4374cube5dce39085bb1d9@mail.gmail.com>
In-Reply-To: <9871ee5f0912030839x10f4374cube5dce39085bb1d9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Timothy,

On Thu, 3 Dec 2009 11:39:40 -0500, Timothy Normand Miller wrote:
> Two of my case fans point at my hard drives.  It would be cool if I
> could use what's reported by hddtemp to control those fans (using
> fancontrol).  Even better if I could set the fan speed based on the
> max of settings computed from CPU temperature and hdd temperature.  Is
> any of this possible?

Our fancontrol script doesn't support this at the moment. Only hwmon
kernel drivers can be used as thermal sources for the speed regulation.

There have been discussions in the past to either improve fancontrol to
accept arbitrary temperature sources [1] or to integrate hardware
temperature monitoring in libsensors [2]. However, neither happened
yet. The former is unlikely to happen ever, as fancontrol started as a
hack and isn't really meant to become more flexible than it is today.
The latter will probably happen but it may take long (several months if
not years.)

[1] http://lists.lm-sensors.org/pipermail/lm-sensors/2009-January/025185.html
[2] http://lists.lm-sensors.org/pipermail/lm-sensors/2009-November/027255.html

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
