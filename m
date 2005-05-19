From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: SENSDEV problems with Makefile in prog/rrd/
Message-Id: <1076504282.402a26da797bd@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040211120945.BNUH21240.mxfep02.bredband.com@mo0ze>
In-Reply-To: <20040211120945.BNUH21240.mxfep02.bredband.com@mo0ze>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[Please reply to the list, not to me.]

Quoting Sami Virtanen <sami.virtanen@bredband.net>:

> I cant make the rrd package it just ends up saying: Makefile:32: ***
> error - sensor asb100-i2c-1-2d not installed - check SENSDEV
> definition in Makefile.
> Stop.
> 
> And according to output from doing the cmd sensors it is the
> asb100-i2c-1-2d sensor being used.
> 
> My system: 
> Debian 3.0 with 2.6.2 kernel and lm_sensors 2.8.4 compiled with make
> user and make user_install.
> 
> What am I doing wrong? Or is it just the script package that isn't
> using the new /sys instead of the old /proc?

Yes, I think it's that easy. The scripts in prog/rrd haven't been ported
to support sysfs yet.

I don't know anything about these scripts since I don't use rrd, so I
won't be of much help here.

However, if you would like to take your chance and update the scripts so
that they work with your 2.6 kernel, go on and let us know how it
goes.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
