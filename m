From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: New driver for MAX663x temperature sensor.
Message-Id: <20040412164830.5f3ea23b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1081775028.11592.294.camel@uganda>
In-Reply-To: <1081775028.11592.294.camel@uganda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Answering to myself:

> You better name your driver max6633.c (or max6634.c, since that's the
> chip I suspect you are actually working with) then.

Actually max6635 would probably be better, since the max6635 is
obviously a lm76-clone, and the 6634 and 6633 are cut-down versions of
these.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
