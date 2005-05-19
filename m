From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: Additional Support: Ticket 1548
Message-Id: <1075456628.401a2a7422356@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040128025905.42866.qmail@web20902.mail.yahoo.com>
In-Reply-To: <20040128025905.42866.qmail@web20902.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Ga Tech Swagger <georgia_tech_swagger@yahoo.com>:

> Looking at results on GKrellM, is it true that the
> sensors interpreter only does integral degree celsius
> readings?  I notice I normally sit at 91.4 F ... but I
> occasionally jump to 89.6 F -- probably a diff of one
> degree celsius.

Depends on the chip, but yes, all chips are measuring temperatures in
degrees C internally, not F. Depending on the chip and channel, the
resolution varies from 1 full degree to 0.5 or 0.125 degree C.

> Also, my fan randomly drops to 0 every 15 secs or so. 
> No biggie - just kinda weird.

Try increasing the fan div (say from 2 to 4). If your fan isn't too
fast, you might be reaching the limit of range that can be measured
with the fan div you use.

Glad you could finally get it to work.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
