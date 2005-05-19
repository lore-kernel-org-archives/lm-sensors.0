From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:50 +0000
Subject: question (IBM i2c-piix4) - last question
Message-Id: <20050409184955.63548a03.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <000101c53d1b$cb824250$e500a8c0@KRTEK>
In-Reply-To: <000101c53d1b$cb824250$e500a8c0@KRTEK>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Tomas,

> And my last question is (I want to be sure):
> These files ("eeprom drivers") will not harm my PC, will they?
> 
> /usr/lib/perl5/5.8.0/i386-linux-thread-multi/linux/eeprom.ph
> /usr/include/linux/eeprom.h
> /usr/src/linux-2.4.29/include/linux/eeprom.h
> /usr/src/linux-2.4.29/include/asm-mips/lasat/eeprom.h
> /usr/src/linux-2.4.29/include/asm-parisc/eisa_eeprom.h
> /usr/src/linux-2.4.29/drivers/gsc/eisa_eeprom.c
> /usr/src/linux-2.4.29/drivers/net/e100/e100_eeprom.c
> /usr/src/linux-2.4.29/drivers/net/tulip/eeprom.c
> /usr/src/linux-2.4.29/arch/mips/pmc-sierra/yosemite/atmel_read_eeprom.c
> /usr/src/linux-2.4.29/arch/cris/drivers/eeprom.c

No, these are completely different stuff, which won't hurt you.

-- 
Jean Delvare
