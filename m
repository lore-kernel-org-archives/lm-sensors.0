From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: No sensors found
Message-Id: <20040502194849.5d48ce3f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <000801c43068$c801a6e0$0100000a@volcano>
In-Reply-To: <000801c43068$c801a6e0$0100000a@volcano>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Just a problem now..
> 
> I don't have the dir "/proc/sys/dev/sensors/" on my running linux.
> 
> Neither some dir with the name sensors on /proc ou /sys

As root:
mkdir /sys
mount none /sys -t sysfs

If you want that done automatically, make sure that to have the
following line in /etc/fstab:
none     /sys     sysfs    defaults                        0 0

Hope that helps.

-- 
Jean Delvare
http://khali.linux-fr.org/
