From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: it87 and lm85 tickets
Message-Id: <20050505115517.3f4257e5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <42374305.6030000@mds.gotdns.com>
In-Reply-To: <42374305.6030000@mds.gotdns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Philip,

> The one hichup I did find from going over the datasheet is that a 
> previously "reserved" bit in the "Zone Range/Fan Frequency" register
> is  now defined and affects the PWM frequency.  So we need to be
> careful to  clear that bit or we have to extend the frequency
> possibilities.
> 
> Does this patch need to be for both 2.6 and 2.4/lm_sensors2?

Yes, one for each please. They shouldn't be all that different.

-- 
Jean Delvare
