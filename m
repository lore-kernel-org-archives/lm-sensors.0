From: steffen.grunewald@aei.mpg.de (steffen.grunewald@aei.mpg.de)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: rounding issues (ticket 1326)
Message-Id: <20030815132821.GY5259@sg.aei.mpg.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030729175704.2f7fbee6.khali@linux-fr.org>
In-Reply-To: <20030729175704.2f7fbee6.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hii Jean,

On Tue, Jul 29, 2003 at 05:57:04PM +0200, Jean Delvare wrote:
> 
> Some times ago, you contacted us about a rounding issue in our w83781d
> driver. I commited a fix to CVS and send it to you too, asking you to
> test it and tell us how it works.

Yes, I got it. 
 
> We never heard you back though. I'd really like you to test it. There

I just returned from some weeks of holidays off-net, so I'll give it
a try RSN. But since lots of other work have piled up on my desk I won't
promise anything.

At least the patch looked very fine to me...

> are still seven other drivers that probably would require the same kind
> of fix, and I don't want to change them before having some feedback from
> you.

That's bad :-( 

Apologizing for the delay this may have caused (and will continue to cause),

 Steffen
-- 
I apologize for the delay in mail delivery, all mail written today
had to be re-processed by hand due to a configuration error :-(
-- 
Steffen Grunewald * * * Merlin cluster admin (http://pandora.aei.mpg.de)
         MPI f?r Gravitationsphysik (Albert-Einstein-Institut)
      Am M?hlenberg 1, 14476 Golm, Germany (http://www.aei.mpg.de)
e-mail: steffen.grunewald(*)aei.mpg.de * +49-331-567-{fon:7233,fax:7298}
