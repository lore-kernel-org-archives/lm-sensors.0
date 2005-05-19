From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: Patch for i2c-tsunami.c
Message-Id: <20031229202407.6ea2a70f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FEB9352.3080401@oden.homeip.net>
In-Reply-To: <3FEB9352.3080401@oden.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> So I changed the Makefiles for both i2c and lm-sensors from this:
> 
> ifeq ($(MACHINE),alpha)
> MODCFLAGS += -ffixed-8
> endif
> 
> to this:
> 
> ifeq ($(MACHINE),alpha)
> MODCFLAGS += -ffixed-8 -mno-fp-regs -mcpu=ev56
> endif
> 
> and that solves all the compile issues. The only thing I'm not sure 
> about is what would happen if someone tried to execute the code on EV4
> EV4 processors for example, and I have no way to test that either.
> EV56 are pretty old processors as well, so going with the above flags
> per default is probably safe.

OK, done that. Thanks for the feedback.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
