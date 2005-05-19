From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: smart HDD
Message-Id: <20030721154832.43dd6564.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi all,

On our new drivers page, there is an entry for SMART HDD temperature,
that read:
A program could be written to present the temperature using i2c-proc and
'sensors'.

I'm interested in that, since I think one of my hdd would support it.
What's the idea however? The sensor is not found on an I2C bus AFAIK,
there are specialized tools to retrive SMART data
(http://www.linux-ide.org/smart.html). So what's the link with our
project?


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
