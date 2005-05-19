From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: I have information on Winbond W83627EHF Chip
Message-Id: <sz29PYWM.1107939234.2507990.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050208060234.44864.qmail@web50702.mail.yahoo.com>
In-Reply-To: <20050208060234.44864.qmail@web50702.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi David,

> Oops, I forgot to get you some of the other information you asked for:
>
> Output from lspci:
> 00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Interface
> Bridge (rev 02)
> 00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) IDE
> Controller (rev 02)
> 00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER
> (ICH5/ICH5R) AC'97 Audio Controller (rev 02)

OK, 00:1f.3 is missing, I guess that the SMBus was disabled by the BIOS.
This explains why sensors-detect missed it.

If we were absolutely wanting to access something on the SMBus we could
try and reenable it, but since we supposedly have a different, faster
way (ISA) to access the hardware monitoring chip, it's just not worth
it.

Thanks,
--
Jean Delvare
