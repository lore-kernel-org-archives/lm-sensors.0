From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: lm_sensors2/prog/detect sensors-detect
Message-Id: <20030807111940.0b071e11.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021107235845.0037e195.khali@linux-fr.org>
In-Reply-To: <20021107235845.0037e195.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Modified Files:
> 	sensors-detect 
> Log Message:
> (Khali) Detect which of modules.conf or conf.modules should be used.
>         Detect which of /dev/i2c-*, /dev/i2c/* or /dev/i2c*  should be
>         used.
>         Stop if no i2c device files exist.

I agree that one could run sensors-detect for the ISA and Super I/O
chips only. However, I think that forcing the user to create the devices
if they do not exist will be helpful in 99.99% of the cases. If someone
ever complains about that, we'll change it.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
