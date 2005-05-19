From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: New max6626.c driver for linux 2.6
Message-Id: <20041120140849.7033ede4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <NHBBLBCCGMJFJIKAMKLHMEHECCAA.ralf.roesch@rw-gmbh.de>
In-Reply-To: <NHBBLBCCGMJFJIKAMKLHMEHECCAA.ralf.roesch@rw-gmbh.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> this is my i2cdump output:
> 
> [root@CANTastic:/qs]# ./i2cdump 1 0x48
> No size specified (using byte-data access)
> WARNING! This program can confuse your I2C bus, cause data loss and
> worse! I will probe file /dev/i2c/1, address 0x48, mode byte
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f   
>      0123456789abcdef
> 00: 1f 00 c9 c9 1f 00 c9 c9 1f 00 c9 c9 1f 00 c9 c9   

This confirms the over-4 address cycling (as opposed to over-8 for the
original LM75). Thus you will need to extend sensors-detect and the lm75
driver detection function to get the MAX6626 chip recognized.

-- 
Jean Delvare
http://khali.linux-fr.org/
