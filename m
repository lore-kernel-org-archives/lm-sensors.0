From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: bmc and fan speed control
Message-Id: <0YfO81pG.1115723185.4224130.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <427FF313.7070202@mds.gotdns.com>
In-Reply-To: <427FF313.7070202@mds.gotdns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Al,

> Intel SHG2 motherboard which I believe uses a Sahalee BMC. It also
> employs an ADM1021 which I think does the fan control. (...)

Not a chance, as the ADM1021 is a two-temperature chip. It doesn't deal
with fans at all.

The SHG2 manual mentions an ADM1026 instead, which is a full-featured
hardware monitoring chip, and has some fan speed control capabilities.

--
Jean Delvare
