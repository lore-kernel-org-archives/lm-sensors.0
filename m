From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 27 Jan 2012 21:48:52 +0000
Subject: Re: [lm-sensors] sensors-detect bug ?
Message-Id: <20120127224852.794a9172@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4F22E64F.8060204@GNAServicesInc.com>
In-Reply-To: <4F22E64F.8060204@GNAServicesInc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 27 Jan 2012 15:26:17 -0500, Andrew Smith wrote:
> 3.2.2
> 
> ls -l /sys/bus/i2c/devices/i2c-*/
> /sys/bus/i2c/devices/i2c-0/:
> ls: cannot access /sys/bus/i2c/devices/i2c-0/LNXSYSTM:00: No such file
> or directory
> ls: cannot access /sys/bus/i2c/devices/i2c-0/cpu: No such file or directory
> ls: cannot access /sys/bus/i2c/devices/i2c-0/breakpoint: No such file or
> directory
> total 0
> drwxr-xr-x 18 root root 0 2012-01-27 12:18
> d?????????  ? ?    ?    ?                ? breakpoint
> d?????????  ? ?    ?    ?                ? cpu
> drwxr-xr-x  4 root root 0 2012-01-27 12:18 i2c-1
> drwxr-xr-x  4 root root 0 2012-01-27 12:18 i2c-2
> drwxr-xr-x  4 root root 0 2012-01-27 12:18 i2c-3
> drwxr-xr-x  4 root root 0 2012-01-27 12:18 i2c-4
> drwxr-xr-x  3 root root 0 2012-01-27 12:18 ibs
> d?????????  ? ?    ?    ?                ? LNXSYSTM:00
> drwxr-xr-x 18 root root 0 2012-01-27 12:18 pci0000:00
> drwxr-xr-x 10 root root 0 2012-01-27 12:18 platform
> drwxr-xr-x 18 root root 0 2012-01-27 12:18 pnp0
> drwxr-xr-x  3 root root 0 2012-01-27 15:06 rapidio
> drwxr-xr-x  3 root root 0 2012-01-27 12:18 software
> drwxr-xr-x  8 root root 0 2012-01-27 12:20 system
> drwxr-xr-x 19 root root 0 2012-01-27 12:18 virtual

Looks like sysfs / driver tree corruption. i2c-0/ contains entries
which normally live in /sys/devices, and some don't even have file
attributes.

Please check if older kernels have the same problem and check that you
use reliable memory.

If you can reproduce the problem, please check the kernel logs for
any relevant message. A kernel with some debugging options enabled
might be good too.

Anyone, that's not a sensors-detect issue.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
