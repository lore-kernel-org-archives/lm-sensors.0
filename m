From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:44 +0000
Subject: sensord 2.8.2 on 2.6.0/ASUS chip - subclient problem
Message-Id: <20040229115757.060b7993.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200401111319.18817.arvidjaar@mail.ru>
In-Reply-To: <200401111319.18817.arvidjaar@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andrey,

> > I think you misunderstood me.
> > Checking for "subclient" should provide this information.
> > And checking only for a space may work now but could break later.
> > So please look for a "subclient" substring.
> 
> ok, attached

Sorry for the delay. I committed a similar change to our CVS repository
this morning. It's not exactly what you proposed (I didn't much like the
idea of using 120 more bytes of the stack) but should work equaly well.
Tested on my as99127f.

Please check it out and confirm that it works for you too.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
