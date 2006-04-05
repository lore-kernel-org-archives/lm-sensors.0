From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 05 Apr 2006 09:03:14 +0000
Subject: [lm-sensors] ali1563 problems
Message-Id: <20060405110314.9a6ed54c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <000001c657ef$bd81d2c0$937ba8c0@genesis>
In-Reply-To: <000001c657ef$bd81d2c0$937ba8c0@genesis>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Do you want to scan the ISA bus? (YES/no):
> > 
> > Probing for `Winbond W83627HF'
> > Trying address 0x0290... Success!
> > (confidence 8, driver `w83781d')
> >
> > Some Super I/O chips may also contain sensors. Super I/O probes are
> > typically a bit more dangerous, as we have to write to I/O ports to do
> > this. This is usually safe though.
> > 
> > Do you want to scan for Super I/O sensors? (YES/no):
> > Probing for `Winbond W83627HF Super IO Sensors'
> > Success... found at address 0x0290/
> 
> Please can you provide dump of:
> 
> isadump 0x295 0x296

And even before that, the contents of /proc/ioports

Kernel 2.6.14 was still affected by the PNP ACPI vs w83627hf issue, we
fixed it only in 2.6.15.
(See http://bugzilla.kernel.org/show_bug.cgi?id@14 for details.)

-- 
Jean Delvare

