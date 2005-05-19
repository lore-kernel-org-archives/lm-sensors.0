From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:24 +0000
Subject: lm_sensors & kernel
Message-Id: <20031110190054.5c8c683b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Any news on whether 2.4.23 will have the sufficient code to keep from 
> having to patch for i2c in order to get lm_sensors to correctly
> implement?

It probably won't, since it's a bit late to have such a big patch into
Linux 2.4.23 (so I was told). I should have been faster, my fault. I
expect only a few simple fixes to be accepted into 2.4.23, the rest of
the changes be left for 2.4.24. So I'll have to make a patch available
once more.

> Also, any news on the status of lm_sensors in 2.6 kernel?
> I didn't notice it in test9.

It is there! Take a look in drivers/i2c, you'll see almost all bus
drivers, plus several chip drivers. The main problem is that user-space
tools don't support Linux 2.6 yet (although I think someone is working
on it) so you'll have to read the raw values in /sysfs. Admittedly not
very comfortable.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
