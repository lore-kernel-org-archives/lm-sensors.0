From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:36 +0000
Subject: More flash eeprom fun on a Thinkpad
Message-Id: <20020722205951.7476a9bc.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020721144141.C11600@Stimpy.netroedge.com>
In-Reply-To: <20020721144141.C11600@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Could we simply blacklist the 0x54-0x57 area unless the user 
> explicitly 'forces' regular usage of that area?

Just for information, it seems that recent Sony Vaio laptops (at least
mine) have an information eeprom at 0x57.

-- 
Jean "Khali" Delvare
http://www.ensicaen.ismra.fr/~delvare/
