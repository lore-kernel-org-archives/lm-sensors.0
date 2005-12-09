From: hmh@debian.org (Henrique de Moraes Holschuh)
Date: Fri, 09 Dec 2005 02:10:38 +0000
Subject: [lm-sensors] Kernel hangs with i2c-i801 driver?
Message-Id: <20051209021038.GA10978@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051123100021.GA29473@oden.homeip.net>
In-Reply-To: <20051123100021.GA29473@oden.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 08 Dec 2005, Ymu at Winbond.com.tw wrote:
> Do you think it's should be the faulty of the man made BIOS?

Actually, no.  It's just that we have to make sure nobody else is bothering
the chip while we are.

Of course, if the hardware only had atomic operations, that would be even
better ;-)  (not that this is always possible with i2c, but still...)

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

