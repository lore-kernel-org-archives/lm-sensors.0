From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: [tzseller@geomant.com: ICH5 sensor]
Message-Id: <20031105221634.05a38d11.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031105194958.GA1871@frodo.local>
In-Reply-To: <20031105194958.GA1871@frodo.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I installed the sensorsd package on my debian box with an intel 865
> motherboard.
> 
> it says:
> nicNG:/etc# lspci
> (...)
> 00:1f.3 SMBus: Intel Corp. 82801EB SMBus Controller (rev 02)
> (...)
> 82801EB SMBus... that's not supported by your software.

You must be kidding.

> nicNG:/usr/share/doc/lm-sensors/doc/busses# sensors -v
> sensors version 2.6.5

Oh, so you meant "not supported by a 13 month-old version of our
software". That's different.

> can you tell me, how is the support for this SMBus device?

It's supported since June 2003, so releases 2.8.0 and later support it.

> thanks alot

You're welcome.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
