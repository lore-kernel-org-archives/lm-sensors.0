From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 23 Oct 2006 09:26:20 +0000
Subject: [lm-sensors] w83627hf 9191-0290: If reset=1 solved a problem
Message-Id: <20061023112620.1f963d6a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <453B393C.9000204@xs4all.nl>
In-Reply-To: <453B393C.9000204@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Udo,

On Mon, 23 Oct 2006 10:32:30 +0200, Udo van den Heuvel wrote:
> Jean Delvare wrote:
> > On Sun, 22 Oct 2006 11:26:20 +0200, Udo van den Heuvel wrote:
> >> I report that I have to use reset=1 for w83627hf to make my fans start
> >> again after booting the kernel on VIA Epia EK8000.
> >> The w83629hf driver sees a w83697hf chip.
> > 
> > I'd need more information.
> 
> OK.
> 
> > Are there options related to fan speed control in your BIOS? If there
> > are, what are they set to?
> 
> None, as far as I know. Just a System Health page to see status.
> 
> > What is the fan status at boot time (i.e. before loading the w83627hf
> > driver)?
> 
> Fans running. (two fans atached to the system fan connector on the
> mainboard)

OK, so let me summarize what I understood:

* When your computer boots, fans are spinning.
* If you load the w83627hf driver with no parameter, the fans stop.
* If you instead load the w83627hf driver with reset=1, the fans don't
  stop.

Is that it? If so, I consider it a critical issue which needs to be
addressed quickly.

If "sensors -s" is run as part of your init scripts, please remove it
and check again, I'd like to get it out of the list of suspects.

Which kernel are you using? Is it from your distribution, or
self-compiled?

Do you also have the w83781d driver loaded?

What if you load w83627hf with init=0 (and not reset=1)?

Thanks,
-- 
Jean Delvare

