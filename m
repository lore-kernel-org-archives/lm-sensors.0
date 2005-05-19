From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: support for p4s8x motherboard
Message-Id: <20030627214546.1b98bf2a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EFA15C6.5020503@cadesis.com>
In-Reply-To: <3EFA15C6.5020503@cadesis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > Maybe some value is (supposedly) out of limits and you have beeping
> > enabled. Does "sensors -s" (as root) end the noise? What does
> > "sensors" output then? Does unloading the w83781d module stop the
> > beeps?
> > 
> 
> "sensors -s" does not end the noise and gives no information.

It is perfectly normal that it doesn't give any information.

> Unloading the module does not help too.
> Only a reboot stop the beep sequence.

And what about "sensors" (without "-s")? Does it actually show something
is over limit?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
