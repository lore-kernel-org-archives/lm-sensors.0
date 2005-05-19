From: donj@asaca.com (Don Jessup)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: Makefile problems
Message-Id: <20040115194239.87230.qmail@web14525.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040115164753.98479.qmail@web14522.mail.yahoo.com>
In-Reply-To: <20040115164753.98479.qmail@web14522.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


 Yes,  it is from CVS.

  
  The date is the problem thank you.

  don
 
--- Jean Delvare <khali@linux-fr.org> wrote:
> > I having a problem with lm_sensors2 Makefile.  I run make all or
> > make install It seems to just go into a loop and ends up doing
> > nothing.  I have sent a log of what Makefile outputs.   Please let
> > me know what I'm doing wrong or missing.
> 
> Is it from CVS?
> 
> Most probably your time is wrong (or you use CVS which is known to have
> a bad time) and this confuses make. Make sure that no file in the source
> tree has a date and time that belongs to the future ('find . -type f
> -exec touch "{}" \;' may help). I'd expect everything to go fine after
> that.
> 
> -- 
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
> 
> 
> 
> 


==Don Jessup
Asaca/Shibasoku Corp. of America
400 Corporate Circle, Unit G
Golden, CO  80401
303-278-1111 X232
donj@asaca.com
http://www.asaca.com
