From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: lm_sensors2/prog/detect sensors-detect
Message-Id: <20031128194306.36c190c0.khali@linux-fr.org>
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
> (mds) add sysfs support to sensors-detect by using 'i2cdetect -l'
>       instead of 'cat /proc/bus/i2c'

Is this considered a definitive change, or am I still supposed to code
something there?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
