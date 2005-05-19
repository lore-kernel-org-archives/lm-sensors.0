From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:18 +0000
Subject: use of iconv() in main.c
Message-Id: <20041003141831.77a21a51.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200408160857.i7G8vTrs027501@localhost.localdomain>
In-Reply-To: <200408160857.i7G8vTrs027501@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Robert,

> > OK. Care to test the attached patch? It should skip iconv completely
> > when uclibc is used.
> > 
> > If it works OK I'll commit it to our repository.
> 
> shortly after you sent this mail the hard disk on which my OS resode
> died.  I will try to test your patch in the next few days and get
> back to you.

Any news? I need your confirmation that it works OK for you before I can
apply the patch to our CVS repository.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
