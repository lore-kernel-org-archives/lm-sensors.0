From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: asus tusl2-c
Message-Id: <20050330221854.6986815b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050228204516.5c4dd1b9.khaqq@free.fr>
In-Reply-To: <20050228204516.5c4dd1b9.khaqq@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi khaqq,

> After updating from linux 2.6.9 to 2.6.11 (new i2c ?) I have had
> to change the temp2 formulae again. The CUSL2 one was reporting
> temps near 60C (PIII/1200 with large cooler) while the BIOS
> said 40C. I think the correct formulae is *now* the same as the
> A7M266 but it's weird. Can you confirm something changed in the I2C
> code ?

Absolutely. The w83781d driver used to report half the temperature for
the AS99127F chip, and the error was compensated by libsensors. Now the
w83781d driver reports the correct value so the formula has to be
changed to:

compute temp2 (@*30/43)+25, (@-25)*43/30

-- 
Jean Delvare
