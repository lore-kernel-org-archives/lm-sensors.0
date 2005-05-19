From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: ADM1027 not detected on Tyan S5112
Message-Id: <200406171514.i5HFEdqc000645@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.44.0406171051020.30199-100000@mail.internal.brightstareng.com>
In-Reply-To: <Pine.LNX.4.44.0406171051020.30199-100000@mail.internal.brightstareng.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Ross,

>Probing for PCI bus adapters...
>Sorry, no PCI bus adapters found.

OK, sensors-detect misses the ADM1027 because it first misses the bus the
ADM1027 chip is supposedly on.

Please provide the output of "lspci -v" and "lspci -n".

Khali
