From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: [TRIVIAL 2.6] drivers/i2c/busses/i2c-piix4.c: kill duplicate
Message-Id: <20040420210441.0f581dff.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040417230824.45f51061.khali@linux-fr.org>
In-Reply-To: <20040417230824.45f51061.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > 2* Most i2c bus drivers do not need to include it at all. Greg, I
> > guess this is a leftover from the old debugging scheme?
> 
> Probably.
> 
> > 3* Same goes for most (all?) i2c chip drivers, and core i2c drivers
> > too: they include config.h but don't seem to need it.
> > 
> > If would probably be better to solve all these problems at once. I
> > think we should get rid of all useless includes. Greg, can you
> > confirm?
> 
> Yes, but be careful of includes that are needed by other arches to
> build properly.  Sometimes it's hard to find those.

Sorry for the confusion, I was only refering to config.h, not just "all"
headers. Is it OK if I provide a patch that removes unneeded config.h
includes from all chip, bus and i2c core drivers?

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
