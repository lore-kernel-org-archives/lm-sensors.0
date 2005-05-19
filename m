From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: sensors bug?
Message-Id: <20040118170149.247e660e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0401181400350.32054@terminal.dnsalias.org>
In-Reply-To: <Pine.LNX.4.58.0401181400350.32054@terminal.dnsalias.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I think it's a bug:
> 
> +12V:     +12.10 V  (min =  +0.00 V, max =  +0.00 V)
> -12V:     -12.35 V  (min =  -0.00 V, max =  -0.11 V)
> -5V:       -5.01 V  (min =  -3.27 V, max =  -0.00 V)
> ERROR: Can't get TEMP1 data!
> ERROR: Can't get TEMP2 data!
> ERROR: Can't get TEMP3 data!
> vid:      +3.500 V
> 
> strace says:
> open("/sys/bus/i2c/devices/0-002d/temp_min1", O_RDONLY) = -1 ENOENT
> (No such file or directory)
> write(1, "ERROR: Can\'t get TEMP1 data!\n", 29ERROR: Can't get TEMP1
> data!) = 29
> (...)
> I'm using kernel 2.6.1 and lm_sensors 2.8.3
> sensors:
> w83781d-i2c-0-2d
> (...)
> With kernel 2.6.0 everything works fine.

I don't think that you are using lm_sensors 2.8.3. The behavior
described here is what I'd expect from lm_sensors 2.8.2 instead. What's
more, kernel 2.6.0 would *not* work with lm_sensors 2.8.3.

Please make sure that the version of libsensors you are using is 3.0.1
(check this with "ls -l /usr/local/lib/libsensors*") and that sensors
picks it correctly (running ldconfig may help).

If you confirm that you still have the problem with Linux 2.6.1 and
lm_sensors 2.8.3, I'll look into it. But I doubt it, to say the truth.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
