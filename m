From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:03 +0000
Subject: Trouble with i2c and bttv
Message-Id: <20030704232622.0075b823.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307042024.55272.tim.boneko@web.de>
In-Reply-To: <200307042024.55272.tim.boneko@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> i2c-2.8.0 isn't compatible with existing i2c drivers in the kernel due
> to struct changes.

BTW I'd like to work on this problem. I have a DC10+ board (zoran
driver) that suffers from the struct changes, and I really want to be
able to use bleeding edge sensors *and* occasionally watch TV. The
problem is that I just don't know how to fix the driver. Is there a
document somewhere explaining how to convert a driver from old structs
to new ones?

(If I succeed for my own board, I'll fix all the kernel drivers the same
way, providing someone can provide the first half of the patch, that is,
I2C itself.)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
