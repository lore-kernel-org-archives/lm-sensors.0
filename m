From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: lmsensors on Abit IC7-G
Message-Id: <20031121233756.559729fd.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FB92482.2070306@langfeldt.net>
In-Reply-To: <3FB92482.2070306@langfeldt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> - This is a pure PCI system, no ISA bus so no ISA probe, Intel ICH5 
> chipset is correct.

You're wrong. You might not have ISA slots, still you *do* have an ISA
bus. Almost everybody does. And that's probably where your monitoring
chipset is hiding.

> Probing for `Winbond W83627HF'
>    Trying address 0x0290... Success!
>      (confidence 8, driver `w83781d')

Here it is.

>   Some Super I/O chips may also contain sensors. Super I/O probes are
>   typically a bit more dangerous, as we have to write to I/O ports to
>   do this.  Do you want to scan for Super I/O sensors? (YES/no): no

Error. You want to say yes. It will detect the W83627HF driver again,
and propose an alternate (and better) driver.

That said, the w83781d should have worked also, but W83627HF detection
is known to be broken in 2.8.1. I have fixed it since (2003-10-25) so if
you check lm_sensors2 CVS out, you should be able to use the w83781d
driver. But anyway, try Super I/O, it should give even better results.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
