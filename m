From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: sensor readings using kernel 2.5.x/2.6.0-test1
Message-Id: <20030717091035.31d4df69.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F14E4B0.6080006@warder.ath.cx>
In-Reply-To: <3F14E4B0.6080006@warder.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Ok, I wrote a quick sensors prog that works with the 2.6.0-test1 (and 
> possibly recent 2.5.x) kernel (kernel I2C stuff compiled) with my mobo
> (via686 chipset). I'm not sure if it's gonna work `properly' with
> other chipsets (don't have more HW to test on) but if it doesn't, the
> readings may be adjusted with a .conf file or something (using the
> lm_sensors confs might work perfectly). I'm also not sure if the
> temperature readings change to C or F depending on the locale (someone
> might want to check that). Hope this will help at least a bit.

Well, great you could produce some working code, but it would be really
better if you (or someone else, but you seem to know how to do it) could
modifiy libsensors to support linux 2.5/2.6. That way, all devices would
me automatically supported, and the config file also. I did not do so
yet because I am not running such a kernel, which makes testing very
difficult. If you can help, you are very welcome. 

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
