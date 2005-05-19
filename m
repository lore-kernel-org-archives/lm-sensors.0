From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: Ticket #1936
Message-Id: <QiCQgCSk.1111077532.4810130.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <4239AC59.8050804@q-leap.de>
In-Reply-To: <4239AC59.8050804@q-leap.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Sascha,

> Probing for `Winbond W83627HF Super IO Sensors'
>   Success... found at address 0x0290

Looks all OK to me, your board has a W83627HF Super-I/O chip with
integrated sensors. Just load the i2c-isa and w83627hf drivers, and you
should get proper sensors readings!

--
Jean Delvare
