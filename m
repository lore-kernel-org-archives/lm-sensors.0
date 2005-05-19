From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: possible typo in eeprom doc
Message-Id: <20021118191527.4fde7d44.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi,

I think I found a typo in doc/chips/eeprom but I'd prefer a confirmation
before correcting it:

* Support for really large devices (24C32, 24C64, 24C128, 24C256,
24C5412).
These devices require two-byte address fields and are not supported.

Should I replace 24C5412 with 24C512?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
