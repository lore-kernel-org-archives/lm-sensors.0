From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:48 +0000
Subject: double file name in "/proc/sys/dev/sensors/"
Message-Id: <20030226162105.79e90993.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E5CA690.5060608@mytrix.ru>
In-Reply-To: <3E5CA690.5060608@mytrix.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I am use "linux-2.4.20-suse1/2" from Hubert Mante. (SuSE).

It is Mantel, isn't it?

> Has detected something strange:
> 
> an:/proc/sys/dev/sensors# ls -la
>   total 0
>   dr-xr-xr-x    5 root     root            0 2003-02-20 19:35 .
>   dr-xr-xr-x    7 root     root            0 2003-02-20 19:35 ..
>   -rw-r--r--    1 root     root            0 2003-02-20 19:36 chips
>   -rw-r--r--    1 root     root            0 2003-02-20 19:36 chips
>   dr-xr-xr-x    2 root     root            0 2003-02-20 19:36 
> eeprom-i2c-1-51
>   dr-xr-xr-x    2 root     root            0 2003-02-20 19:36 
> eeprom-i2c-1-52
>   dr-xr-xr-x    2 root     root            0 2003-02-20 19:36 
> w83782d-i2c-1-2d
> 
> 
> ls -Q
> "chips"  "chips"  "eeprom-i2c-1-51"  "w83782d-i2c-1-2d"
> 
> How can be two files with the identical name?

This can happen because the /proc filesystem is virtual. It shouldn't
happen though. Could you please check you don't have two different
versions of libsensors installed in two different places (usually
/usr/lib and /usr/local/lib)?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
