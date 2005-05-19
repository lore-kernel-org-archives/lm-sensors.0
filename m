From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: lm_sensors 2.8.1 test - LM75
Message-Id: <20031007221943.7fb37987.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200310071335.53958.lamar@synque.com>
In-Reply-To: <200310071335.53958.lamar@synque.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I also seem to have a useless LM75:
> 
> lm75-i2c-1-4e
> Adapter: SMBus AMD75x adapter at 06e0
> Algorithm: Non-I2C SMBus adapter
> temp:       +0.0?C  (limit =  +0.0?C, hysteresis =  +0.0?C)

Most likely it isn't a LM75. That old chip is hard to detect, and
"empty" I2C devices (value 0 in all registers) will be detected as
LM75s, providing they are at an acceptable address. So I think you can
safely ignore it.

If you are curious, you can try dumping the chips content using the
following command: "i2cdump 1 0x4e", and try again later to see if
something has changed. However, I'd expect it to be full of 0s forever.

I could change our detection code in sensors-detect to lower confidence
to minimum in that case. BTW, which confidence level did sensors-detect
claimed for you?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
