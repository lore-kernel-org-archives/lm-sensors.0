From: jumpyboy@infinito.it (Gianni)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: lm_sensors 2.8.3
Message-Id: <200401301037.12830.jumpyboy@infinito.it>
List-Id: <lm-sensors.vger.kernel.org>
References: <200401291139.58838.jumpyboy@infinito.it>
In-Reply-To: <200401291139.58838.jumpyboy@infinito.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Alle 13:31, gioved? 29 gennaio 2004, Jean Delvare ha scritto:
> Quoting Gianni <jumpyboy@infinito.it>:
> > > I've got Slackware 9.1. How can it possible I cannot compile
> > > lm_sensors? I tryed with a lot of version but it's very
> > > complicated.
> >
> > I resolved: "make user" not "make users".
>
> AKA "very complicated" ;)
>
> > Sorry to disturb you.
>
> No problem.
I see that in lm_sensors 2.8.2 my VIA VT8327 chipset is supported so I think 
also in 2.8.3 that I installed, but when I rus sensor-detects on linux 2.6.1 
at the end lm_sensors doesn't say of loading i2c-viapro. Maybe linux 2.6.1 
has not got yet VIA VT8237 chipset? I tryed linux 2.6.2-rc2 and lm_sensors 
say me to load i2c-viapro, but sensors -s && sensors say: "no sensors 
available!". I read that in that case I need lm_sensors from CVS, but a 
friend of mine installed lm_sensors 2.8.3 on linux 2.6.2-rc2 and he got 
information from sensors. What I have to do?
Gianni
