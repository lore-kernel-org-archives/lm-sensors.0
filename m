From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: lm_sensors && Asus ASB100
Message-Id: <20030718143505.7f78efb9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.44.0307161343280.790-100000@anubis.univ-lemans.fr>
In-Reply-To: <Pine.LNX.4.44.0307161343280.790-100000@anubis.univ-lemans.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > Why not. The first step IMHO would be to have a separated prefix for
> > the asb100. It is currently handled as an as99127f. Then we could
> > see what can be done to support the asb100 better.
> 
> The total of our support for ASB100 right now is to pretend that it's
> an as99127f.  If we're going to do more than that, my vote is to put
> it into a different file altogether.  Rationale...

Agreed. And as99127f support could even go into the new driver.

> > One of our users, Bryan Almeda,  already made some work in this
> > direction. His work is avilable there:
> >   http://tynian.net/asb100/
> > Please test his patch and tell us how it works for you.
> 
> .. it breaks as99127f, as he mentioned.  Also, w83781d doesn't really
> want to support yet another unique sensor chip.  
> 
> (BTW, I haven't looked at the patch yet.)

I never intended to apply the patch to our sources. I just wanted to
know how it was working on the ASB100.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
