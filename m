From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:52 +0000
Subject: [Fwd: Testing LM85 driver]
Message-Id: <20030402165845.032c7514.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> /proc/bus shows two entries of i2c and one entries of i2c-0. There
> is nothing in the two i2c entries. When I try to cat i2c-0, I get a 
> Segmentation Fault.

Please make sure you don't have an old version of libsensors lying
around. Usually, people have an old version in /usr/lib and a new one in
/usr/local/lib. Removing the old one usually fixes the segfault problem.

Hope it helps.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
