From: urban@UNIX-Beratung.de (Robert Urban)
Date: Thu, 19 May 2005 06:25:12 +0000
Subject: use of iconv() in main.c
Message-Id: <200408251500.i7PF0EnT004889@noisy.spielwiese.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200408160857.i7G8vTrs027501@localhost.localdomain>
In-Reply-To: <200408160857.i7G8vTrs027501@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Jean,

shortly after you sent this mail the hard disk on which my OS resode
died.  I will try to test your patch in the next few days and get
back to you.

cheers,

Rob Urban

You wrote:
> 
> > it looks like __UCLIBC__ is what you're looking for.
> 
> OK. Care to test the attached patch? It should skip iconv completely when
> uclibc is used.
> 
> If it works OK I'll commit it to our repository.
> 
> Thanks.
> 
> -- 
> Jean "Khali" Delvare
> http://khali.linux-fr.org/
> 
> 

