From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: asb100
Message-Id: <20031208230030.0d8faa0b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

The sensors-detect script wasn't updated to support your asb100 driver
yet, nor has been the sensors.conf.eg file. Don't you thing this should
be done before we release 2.8.2? Failing to do that, you are unlikely to
see many users try your driver.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
