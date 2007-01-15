From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 15 Jan 2007 17:00:30 +0000
Subject: [lm-sensors] No smbus on asus w1n laptop in spite of quirk > no
Message-Id: <20070115180030.3b2120c5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701071107.50461.christophe.dr@free.fr>
In-Reply-To: <200701071107.50461.christophe.dr@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Christophe,

On Mon, 15 Jan 2007 08:37:16 +0100, Christophe de Rivi?re wrote:
> Le Dimanche 14 Janvier 2007 21:56, vous avez ?crit?:
> >[...]but both thermal and lm85
> > > modules are loaded and no crash detected.
> > > What is the risk ?
> > You may read completely wrong temperature, hang the bus, stop the fan,
> > force processor to throttle to prevent overheat. I think no real damage
> > will happen, but be careful.
> 
> OK, thanks a lot, i'll probably insert a modprobe -r thermmal 
> in /etc/rc.local .

You should be able to prevent it from being loaded at all, which would
be even better. Adding "blacklist thermal" to /etc/modprobe.conf or
whatever your distribution has, should do the trick.

-- 
Jean Delvare

