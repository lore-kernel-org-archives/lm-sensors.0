From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:34 +0000
Subject: One Wire
Message-Id: <DWytqiXd.1107187866.1006170.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <41FE57FB.9080608@aeroflex.com>
In-Reply-To: <41FE57FB.9080608@aeroflex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Frank,

> I am now looking at the one-wire drivers and see some issues coming up
> already. Our one-wire devices (DS2401s and DS18B20s) are connected
> through a CPLD at ISA port 0x304. I am looking at the matrox driver
> since it has a port to access through. Under the linux documentation
> (Linux 2.6.9) I can't find anything on one-wire devices. Is there some
> docs somewhere that discusses how to use these w1 modules. I believe I
> need w1 and w1_therm to start with but I don't see how everything needs
> to tie together.

I as said, Evgeniy Polyakov (CC'd) is the right person for that kind of
questions. My personal knowledge about one-wire is void.

--
Jean Delvare
