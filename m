From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: Need assistance with enabling the SMBus on an Intel 855PM
Message-Id: <20050415191125.4e3c604c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <e294b46e05041407152efe4f8b@mail.gmail.com>
In-Reply-To: <e294b46e05041407152efe4f8b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Bradley,

> Unfortunately, the only thing sensors-detect found was an SPD EEPROM,
> telling me that I have 512MB of memory installed :-((((
> 
> Either there is nothing attached to my SMBus or it wasn't detected by
> sensors-detect.

You may try using i2cdetect (after loading the i2c-dev kernel module) on
that bus. If there are responsive addresses other than 0x08, 0x44,
0x50-0x57 and 0x69, this might be a hardware monitoring chip, in which
case you can send the output of i2cdump for it and we'll investigate.

-- 
Jean Delvare
