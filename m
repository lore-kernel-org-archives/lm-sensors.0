From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: lm_sensors on Itanium
Message-Id: <1078304966.4045a0c6057f4@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <9D8C1A43309BAD4A9B46071DAF911D9E4C89F0@exch01.paracel.com>
In-Reply-To: <9D8C1A43309BAD4A9B46071DAF911D9E4C89F0@exch01.paracel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Marc Rieffel <marc@paracel.com>:

> Probing for `SMSC 47B27x Super IO Fan Sensors'
>   Failed! (0x51)

Rahhhh. Stupid me, not even able to cut'n'past properly :/. Sorry. Line
1467 should read "devid => 0x51," (not 0x59). Please correct and try
again. I'll fix that in CVS this evening.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
