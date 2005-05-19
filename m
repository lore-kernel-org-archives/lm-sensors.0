From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:03 +0000
Subject: LM83 sensor
Message-Id: <20030702113808.6421ddc3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <43612812.20030701105509@matrixc.ru>
In-Reply-To: <43612812.20030701105509@matrixc.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> 1. What parameters exist? What they should accept values?

See the complete doc here:
  http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/chips/it87
(or in your local doc/chips directory)

> 2. I use i2c and lm_sensors 2.7.0

Would you mind switching to CVS to test the new driver once I'll written
it? I have no LM83 so I won't be able to test it myself, and I'll need
you to do so ;)

> 3. sensors-detect offers to load adm1021

Interesting. You should try loading it. Since the LM84 is a "light"
version of the LM83, your LM83 should really behave like a LM84 with the
adm1021 driver, and you should get 2 temperatures reported (instead of
the 4 supported by the LM83).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
