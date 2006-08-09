From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 09 Aug 2006 13:06:19 +0000
Subject: [lm-sensors] Sensors are not working :(
Message-Id: <20060809150619.e3adf8a6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060809112359.285100@gmx.net>
In-Reply-To: <20060809112359.285100@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

> I got here installed Gentoo Linux with Kernel 2.6.18-rc4.
> I got this mini pc: 
> http://www.dtresearch.com/prod_webDT168.html
> There seems to be the LM82 Sensors but i just can't get this working.        ?        
> sensors-detect don't find any sensors :(
> I enabled Geode Access Bus, lm83 modules (its supports lm82), and
> the i2c modules...

I suspect that your i2c bus doesn't work properly, or you have only one
bus recognized (you should have two) and the LM82 chip is connected to
the other one. Please provide the output of:

cat /proc/ioports

lspci -n

i2cdetect -l

i2cdetect 0

i2cdetect 1

-- 
Jean Delvare

