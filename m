From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:56 +0000
Subject: Testing ASUS PU-DLS
Message-Id: <20030513152654.1f5bd94c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1052831030.613.28.camel@zrr>
In-Reply-To: <1052831030.613.28.camel@zrr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I got 'I20', 'I20 PCI' and 'I20 /proc support' compiled into my
> kernel.
> 
> I did not compile 'I20 Block/LAN/SCSI OSM' into the kernel.

What you need is I2C, not I2O.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
