From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: 8rdavcore GPL issue
Message-Id: <1079971817.405f0fe923d87@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <405C821F.4050003@verizon.net>
In-Reply-To: <405C821F.4050003@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Sebastian Witt <se.witt@gmx.net>:

> I'm very sorry about this. I haven't tought about the license in
> the early stage of the project and than forget this code. Now I've
> updated the freshmeat project page and the tar-archive and hope
> that the lm-sensors project can forgive me my mistake.

I'd have two objections:

1* I still see "BSD License (revised)" listed on Freshmeat (as well as
GPL). Is it intentional? IANAL, but I don't think you can do that kind
of dual licensing in this case, since the BSD License is less
restrictive than the BSD license, and part of the code was originally
under GPL.

2* I would ask you to do the same for your "8RDA hardware watchdog
timer" project as well, since it seems to contain the same part of
i2cdetect the "8rdavcore" project does.

And now a few hints and questions:

1* In this document:
  http://www.hasw.net/8rdawdt/README
you suggest the w83781d driver for ISA W83627HF. The w83627hf is known
to work better.

2* Any reason why 8rdawdt was implemented as a user-space program
relying on i2c-dev, instead of as a kernel driver?

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
