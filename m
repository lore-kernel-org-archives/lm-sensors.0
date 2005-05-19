From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: Problems with Tyan Thunder LE-T
Message-Id: <20031206084155.4b6550d8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.50.0312052212300.7299-100000@trottelkunde.amd.co.at>
In-Reply-To: <Pine.LNX.4.50.0312052212300.7299-100000@trottelkunde.amd.co.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I was trying to get I2C/lm_sensors running on one of our "refurbished"
> servers, but ran into freezes while loading the i2c-piix driver.

This known bug was introduced in 2.8.1 while trying to workaround a few
buggy piix4-compatible chipsets. The workaround, although tested, turned
out to confuse some others piix4-compatible chipsets (OSB4 and OSB5 if I
remember correctly), so it has been reversed. (Well it is still present
but not enabled by default.)

Get an updated lm_sensors2 from CVS and it should work OK. Sorry for the
trouble.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
