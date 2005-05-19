From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: Vaio eeprom security issue
Message-Id: <20030816114234.7a1ce45d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030806233617.5a83d0b6.khali@linux-fr.org>
In-Reply-To: <20030806233617.5a83d0b6.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > if (!capable(CAP_SYS_ADMIN)) {
> > 	/* show the real data */
> > } else {
> > 	/* show zeroes only */
> > }
> > 
> > Is that it?
> 
> Looks good to me, as long as you have done the check for Vaio previous
> to this.

What header should I include? It worked without any additional header,
but I'd like to make it clean. I searched the kernel sources, seems that
capable is defined in linux/sched.h, but some files are using capable()
without including it. Including linux/capability.h would sound good, but
actually this header doesn't define capable() and does not include
linux/sched.h either.


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
