From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:11 +0000
Subject: New LM83 driver
Message-Id: <20030809231304.74f73999.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


High Magnus,

I commited my changes to the lm83 driver to CVS. It adds support for
T_CRIT (Critical temperature, common to all four temperature sensors)
and gives access to the two status registers (alarm flags and diode
fault detection). Could you please give it a try? I'd like to know if it
works as intended.

Note that you'll need i2c-CVS in order to use lm_sensors2-CVS.

Thanks!

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
