From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:36 +0000
Subject: lmsensors on Sony PCG-GRX416G - part 2
Message-Id: <20050206211708.5ab80901.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502060104.51022.lists@localguru.de>
In-Reply-To: <200502060104.51022.lists@localguru.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > I wrote and maintain that script, and am interested in how it works
> > for your laptop, so please let me know.
> 
> Yes, I can check that for you. Just send it so me.

It's part of lm_sensors! Look in prog/eeprom (or /usr/local/bin). You
just need to load i2c-i801, eeprom, and run the decode-vaio.pl script.

Thanks,
-- 
Jean Delvare
