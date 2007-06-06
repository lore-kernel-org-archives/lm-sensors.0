From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 06 Jun 2007 05:23:47 +0000
Subject: Re: [lm-sensors] Fintek F71882 on MSI mainboard
Message-Id: <466644E3.5000902@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <18021.51591.422191.587646@gate.local.mgri>
In-Reply-To: <18021.51591.422191.587646@gate.local.mgri>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hans Edgington wrote:
 > Hi,
 >
 > Thanks for taking a look at the driver.
 >
 >> I hacked the f71882fg driver so it works on my MSI P6N SLI Platinum
 >> mainboard (Socket 775 with Nvidia 650).
 >
 >> The critical fix was to use the address values and logic from the
 >> existing f71805f driver (see diff).
 >
 > I haven't had much time to look at your work, but as I understand it your
 > version is kind of a cross between the f71882fg & f71805f driver. Which
 > means it now won't work on the Epox mobo's and possibly others.
 > So somehow we are going to have to detect which mobo is being used.
 >

No, what he has done is fixed the address detection logic in your driver, so 
that it should work on more motherboards, iow it should still work on the epox 
motherboard and now also on his.

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
