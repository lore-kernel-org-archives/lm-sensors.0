From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:03 +0000
Subject: LM83 driver
Message-Id: <20030703194558.60bc8955.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Zoleg,

I finished writting the driver you requested. Note that I don't own a
LM83 myself, so it is *completely untested*. It compiles, but I can't
promise much more. This is my first driver, so expect to encounter some
problems before it works.

You'd be welcome to checkout i2c (lk2-4 branch) and lm_sensors2 CVS and
give my driver a try :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
