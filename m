From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: [PATCH 2.6] Prevent i2c-dev oops with debug
Message-Id: <1078907222.404ed1564e3c6@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040302224909.444663af.khali@linux-fr.org>
In-Reply-To: <20040302224909.444663af.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Greg KH <greg@kroah.com>:

> > I agree that we need to calm down a bit ;) but there are a
> > several oops preventing patches in my list (i2c-core, i2c-i801,
> > i2c-sis5595, i2c-ali1535 and now i2c-dev). Shouldn't these simple
> > but important fixes be sent to Linus?
> 
> They only happen when people enable debugging, right?  That's a
> pretty simple fix :)

This is correct for i2c-core and i2c-dev (that said, you wouldn't figure
how many people actually enable these options...), but the issue with
the three bus drivers is different. The oops occur when unloading the
modules if the corresponding hardware has not been detected. I agree
that this is a not-so-common case, but it still can occur, and isn't
related to debugging.

(BTW, why do these modules accept to load if no hardware matches? Just
in case the hardware is hot-plugged later?)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
