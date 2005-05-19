From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: i2c and lm_sensors: 2.8.1
Message-Id: <20031017180526.4e606ebc.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Law12-F59zJUMWO2gcC00006992@hotmail.com>
In-Reply-To: <Law12-F59zJUMWO2gcC00006992@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I got errors compiling the new i2c and lm_sensors, so I went to your
> site and the installation guide is only for the 2.8.0 version.

I missed time to update the guide so far, but it is for 2.8.1 as well.

> I have been told that kernel 2.4.22 does not need i2c and
> lm_sensors - is this correct?

This is wrong, our changes haven't made it into Linux 2.4 yet. I suggest
you use the 2.8.0 installation guide and get the i2c patch for kernel
2.4.22 here. This patch is based on CVS some weeks before we released
2.8.1, so you'll be able to compile lm_sensors 2.8.1 on top of it.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
