From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 22 Jul 2005 20:50:07 +0000
Subject: [lm-sensors] [patch]  KERNELVERSION=2.6.12-something make
Message-Id: <20050722204953.4b77e1a7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

> FWIW:  I just tried to stuff this into Makefile, to automate the
> clue-stick you poked me with:
> 
> ifneq (,$(findstring 2.6 , $(KERNELVERSION)))
>     ifneq (,$(findstring 'user', $(MAKECMDGOALS)))
>         $(error 'only user* targets needed/supported for 2.6 builds')
>     endif
> endif
> 
> obviously, it didnt work, or Id have sent a patch.
> Can you fit it in the proper place, or advize where it belongs ?

The following, derived from yours, works for me:

ifeq (,$(findstring /2.4., $(MODPREF)))
    ifeq (, $(MAKECMDGOALS))
        $(error For 2.6 kernels and later, use "make user")
    endif
    ifeq (install, $(MAKECMDGOALS))
        $(error For 2.6 kernels and later, use "make user_install")
    endif
endif

I've added it right after the line which computes $(MODPREF). Please
give it a try and tell me what you think. I might commit it to CVS if
nobody objects. I might also add something similar to the i2c package.

BTW, Jim, I'd like to add that I very much enjoy your attitude of
sending patches to help us fix things rather that just complaining that
things don't work. Even if the patches end up not being needed or
correct, don't stop! :) This is always a good base to start with.

-- 
Jean Delvare
