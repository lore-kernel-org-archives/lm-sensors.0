From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:03 +0000
Subject: lm_sensors with kernel 2.5.72
Message-Id: <20030705165156.4a7b525e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> my question is about setting up lm_sensors with kernel 2.5.72.
> my lsmod looks like this:
> (...)
> but sensors ( executed as root ) says:
> 
> Can't access /proc file
> /proc/sys/dev/sensors/chips or /proc/bus/i2c unreadable;
> Make sure you have done 'modprobe i2c-proc'
> 
> i'm using sensors version 2.7.0

It's a known problem. Our libsensors library isn't compatible with the
sensors modules found in kernel 2.5. We will be working on a solution,
but had no time to do it yet. With the 2.5 kernel modules, you need to
read the value from the sysfs filesystem directly, which isn't very
convenient. If you want to use the library and utilities that make use
of it such as the "sensors" program, you have to stick to a 2.4 series
kernel, sorry.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
