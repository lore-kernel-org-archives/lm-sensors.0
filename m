From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:36 +0000
Subject: [mas@ssl.co.uk: [ltp] Incorporating Thinkpad Detection into Lm_sensors]
Message-Id: <20020722193851.3e09f0a9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020722095819.B16805@Stimpy.netroedge.com>
In-Reply-To: <20020722095819.B16805@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> There's some code in arch/i386/kernel/dmi_scan.c whose intention
> is to change an APM setting for all IBM laptops.  The relevant
> table entry looks like this in 2.4.18:
> 
> { set_apm_ints, "IBM", {	/* Allow interrupts during suspend on
> IBM laptops */
> 		MATCH(DMI_SYS_VENDOR, "IBM"),
> 		NO_MATCH, NO_MATCH, NO_MATCH
> 		} },

I was about to suggest the very same. This file contains an impressive
number of model-based or brand-based workarounds for the Linux kernel,
not only for IBM laptops but also for many other systems such as Sony or
Dell, and also more generic things related to chipsets themselves. Thus,
it looks like a very standard and working way of detecting wether we
have an IBM or not. I suggest we be very exclusive first (I wouldn't
mind blacklisting *all* IBM models), at least until we know more about
which models are causing problems and have a reliable way to be sure of
what we are doing.

-- 
Jean "Khali" Delvare
http://www.ensicaen.ismra.fr/~delvare/
