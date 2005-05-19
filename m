From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:42 +0000
Subject: 2.7.0 testings
Message-Id: <20021127213903.5b84866d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


(starting a new thread, the previous one's too old)

I just tested the CVS version of i2c and lm_sensors2, works perfectly on
my laptop (kernel 2.4.20-rc1 + ACPI).
Just don't forget to change the version and date in lm_senors2/version.h
(same for i2c/kernel/i2c.h).

I'll test with a 2.2 series kernel on another machine early tomorrow.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
