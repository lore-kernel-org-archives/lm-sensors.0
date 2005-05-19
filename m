From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: sensors-detect enhancement needed for sysfs
Message-Id: <20031118212251.1558691d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FB839E3.6C7D5CCD@paradyne.com>
In-Reply-To: <3FB839E3.6C7D5CCD@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I've enhanced i2cdetect, i2cdump, and i2cset using the new common
> function in i2cbusses.c to list all the i2c busses, whether in 2.4 or
> 2.6 kernels. In 2.6 it's essentially 'cat
> /sys/class/i2c-adapter/*/device/name' but see i2cbusses for details
> like finding the sysfs mount point.
> 
> We need a perl volunteer to make a similar enhancement at two places
> in sensors-detect where it scans /proc/bus/i2c.
> 
> Note that the adapter name, but not the algorithm, is available in
> sysfs. I've hacked around that in libsensors and in the programs
> above. Guess it's not really necessary.
> 
> Anybody like to tackle sensors-detect?

I'm on it, providing you tell me what exactly I'm supposed to do there.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
