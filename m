From: "Hans Edgington" <hans@edgington.nl>
Date: Tue, 05 Jun 2007 21:43:35 +0000
Subject: Re: [lm-sensors] Fintek F71882 on MSI mainboard
Message-Id: <001a01c7a7ba$9261ff40$20140a0a@EA002>
List-Id: <lm-sensors.vger.kernel.org>
References: <18021.51591.422191.587646@gate.local.mgri>
In-Reply-To: <18021.51591.422191.587646@gate.local.mgri>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Thanks for taking a look at the driver.

> I hacked the f71882fg driver so it works on my MSI P6N SLI Platinum
> mainboard (Socket 775 with Nvidia 650).

> The critical fix was to use the address values and logic from the
> existing f71805f driver (see diff).

I haven't had much time to look at your work, but as I understand it your
version is kind of a cross between the f71882fg & f71805f driver. Which
means it now won't work on the Epox mobo's and possibly others.
So somehow we are going to have to detect which mobo is being used.
 
> Note that the driver still causes a kernel oops on rmmod, this is
> probably because f71882fg_exit doesn't call f71882fg_remove but I didn't
> feel like working on that, after all I don't remove the module at all...
> ;-)

Is already fixed.


I'll have a closer look at it, as soon as I can.

Regards,
Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
