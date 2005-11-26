From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 26 Nov 2005 12:58:48 +0000
Subject: [lm-sensors] Analogue Devices ADT7476ARQZ chip status
Message-Id: <20051126125944.6044c55e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4387E587.20302@reub.net>
In-Reply-To: <4387E587.20302@reub.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Reuben,

> > Please provide a dump of the Analog Devices chip:
> > i2cdump 0 0x2e b
> 
> [root@typhoon ~]# i2cdump 0 0x2e b
> (...)
>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 20: 77 6c c3 c5 be 36 29 27 62 0c 57 0d 46 36 ff ff    wl???6)'b?W?F6..
> 30: 33 4c 4c 00 00 00 00 00 ff ff ff 00 00 76 41 69    3LL..........vAi

This matches what the ADT7476 datasheet says. I've added support in
sensors-detect (in CVS). Please test if possible.

I've also added an entry in our "New Drivers" page.

My first impression is that the ADT7476 is partly compatible with the
ADT7467/ADT7468, which is itself partly compatible with the ADT7463,
which is an improved version of the ADM1027, which is itself mostly
compatible with the National Semiconductor LM85. We have a driver
(lm85) which covers the LM85, ADM1027 and ADT7463. If we want to
support the ADT7467/ADT7468 and ADT7476, I think we should start a new
driver. The lm85 driver already supports many chips, let's not add to
the mess.

-- 
Jean Delvare
