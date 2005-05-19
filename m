From: kmalkki@cc.hut.fi (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: sesnsors-detect segmentation fault
Message-Id: <Pine.OSF.4.50.0301270040160.13915-100000@kosh.hut.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E343F5D.4090201@manetti.homelinux.com>
In-Reply-To: <3E343F5D.4090201@manetti.homelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 26 Jan 2003, Maurizio Manetti wrote:

> Is there anybody (who can help me) outthere?
>
> kernel: 2.4.20
> i2c: latest CVS release
> lm-sensors2: laterst CVS release

Read the latest news and mailing list archive about the CVS status.

> Compiled and installed, all ok...

>  i2c-core.o: adapter unregistered:
> i2c-sis645.o: version 2.7.0 (20021208)

CVS checkouts always shows the date of latest release here.

> i2c-sis645.o: Found SiS962 [MuTIOL Media IO].
> i2c-sis645.o: SiS645 SMBus base address: 0xe600
> i2c-core.o: adapter  registered as adapter 1.
>
> maurizio:~# cat /proc/bus/i2c
> Segmentation fault
>
> any suggestion?

Be more specific what you have checked out from CVS,
and describe if you compile inside the 2.4 tree after
patching it with i2c and lm_sensors.

-- 
  Ky?sti M?lkki
  kmalkki@cc.hut.fi
