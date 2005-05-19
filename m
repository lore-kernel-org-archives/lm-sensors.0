From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: Controll CPU Cooler on MSI-NEO 2 Board
Message-Id: <PsqnPneQ.1115202664.7537580.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <42772B44.8090204@jonasstein.de>
In-Reply-To: <42772B44.8090204@jonasstein.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Jonas,

> Driver `to-be-written' (should be inserted but causes problems):
>   Detects correctly:
>   * Bus `SMBus stub driver'
>     Busdriver `UNKNOWN', I2C address 0x09
>     Chip `Smart Battery Charger' (confidence: 5)
> (...)

I would suggest that you do not load the i2c-stub driver. It is really
meant for i2c chip driver development and debugging purposes, and will
be of no use to you, but is confusing sensors-detect as hell, as you
must have noticed.

--
Jean Delvare
