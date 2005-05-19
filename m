From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:44 +0000
Subject: i2c-amd756 and dual opteron sensors not foun
Message-Id: <20040229231402.739991fc.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <E039AC86-6597-11D8-8D31-000A958E5EF8@defenderhosting.com>
In-Reply-To: <E039AC86-6597-11D8-8D31-000A958E5EF8@defenderhosting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Charles,

The Super-I/O chip on your board seems to be a PC87366 by National
Semiconductor. At least the device ID matches. That said, it still looks
like a disabled chip (at least the hardware monitoring part of it).

Please confirm this information if you can (docs, manufacturer,
visual... whatever).

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
