From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 16 May 2006 21:23:31 +0000
Subject: [lm-sensors] user prog sensors seg faults
Message-Id: <20060516232331.5028280c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <445F4C46.8000800@telus.net>
In-Reply-To: <445F4C46.8000800@telus.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi lloyd,

> lloyd at wsiopt64:~> sensors -c /dev/null
> Segmentation fault
> lloyd at wsiopt64:~> /sbin/lsmod | grep hwmon
> hwmon                  19848  1 smsc47b397
> lloyd at wsiopt64:~> cat /sys/class/hwmon/hwmon*/device/name
> smsc47b397
> lloyd at wsiopt64:~> 
> 
> I havnt seen any docs mentioning this chip, Is it even supported at all?

We try to support every drivers we have. However this one was written
without the benefit of an official datasheet. It is probably
incomplete, although we had success reports already.

Please go to /sys/class/hwmon/hwmon0/device, list what you see there
and try to read the values of all files. If it works, I'd say that the
driver works OK and libsysfs and/or libsensors is the problem.

Which version of the libsysfs package are you using?

I'm sorry to insist, but at this point the most reasonable thing to do
is upgrade to Suse 10.1 final and try again. Having problems on an old
beta version is not that surprising.

-- 
Jean Delvare

