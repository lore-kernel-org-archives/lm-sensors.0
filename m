From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sat, 19 Aug 2006 10:18:15 +0000
Subject: [lm-sensors] Using ... SMSC EMC6W201
Message-Id: <44E6E567.2080407@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060613202602.560.qmail@web81611.mail.mud.yahoo.com>
In-Reply-To: <20060613202602.560.qmail@web81611.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

> Thanks for the email update. :)
> Just to let you know, I have subscribed and should be easier to reach
> once you return from holiday.  Hope it was great, relaxing FUN!
> 
> As mentioned the dme1737 does not look too similar unless it could be a
> subset somehow.  The EMC6W201 is capable of much more, even though some
> functions are not implemented on the GBT GA-2cewh mobo.

Marcin was fastest and created the driver for

SMSC SCH311x.

http://www.nuhorizons.com/products/NewProducts/Nexus/SMSC/311xdb.pdf
http://www.nuhorizons.com/products/NewProducts/Nexus/SMSC/311x.pdf

Please check lm-sensors archive for the patch, which is not yet reviewed because
I just returned from holiday.

Patch is here:
http://lists.lm-sensors.org/pipermail/lm-sensors/2006-July/016961.html

This makes me wonder if this is not similar to DME1737 or  EMC6W201. Please can
someone check it? (Ric, Alex?)

Regards
Rudolf

