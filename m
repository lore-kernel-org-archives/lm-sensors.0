From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: #1385 (sensors segfault)
Message-Id: <20030827124154.181b030b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030824213041.GA6171@borneo.zolder.net>
In-Reply-To: <20030824213041.GA6171@borneo.zolder.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Regarding #1385:
> 
> ---
> It is completely different from ticket #1267.
> 
> Segfaults are often caused by old versions of libsensors being present
> on your system. Please look in both /usr/lib and /usr/local/lib for
> libsensor* and keep only the more recent version. Run "ldconfig" after
> that.
> 
> Another possibility is that you have different versions of i2c,
> lm_sensors modules and lm_sensors userspace tools mixed. Please check
> that too. How did you install the whole thing?
> 
> Follow up on the list (sensors@stimpy.netroedge.com), reference your
> ticket number.
> ---
> 
> There is only 1 version of libsensors around, this is 2.8.0, both i2c
> and lm_sensors where run from standard sources with ./configure; make;
> make install. Loaded modules right now are:
> 
> i2c-i801                4724   0  (unused)
> i2c-dev                 4772   0  (unused)
> i2c-proc                7312   1 
> i2c-core               13924   1  [i2c-i801 i2c-dev i2c-proc]
> 
> /proc/sys/dev/sensors is empty except for chips, which has no entries.

(Please note that I don't remember the original ticket and can't access
it right now.)

This directory being empty is normal since you don't have any chip
driver loaded. "i2c-i801" is your bus driver. It allows accessing the
chips but doesn't do anything from the user's point of view.

As for the segmentation fault, I know we already encountered the problem
and that it was caused by the modules and the library to be from
different versions. You say it's not the case here. I'd like you to
double check. "sensors -v" will give you the sensors version. "dmesg"
right after loading the i2c modules will give you the modules versions.
If they don't match, you know why sensors-detect crashes.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
