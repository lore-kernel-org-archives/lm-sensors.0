From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 27 Apr 2006 18:37:07 +0000
Subject: [lm-sensors] Dell Latitude D610 and 2.6.16
Message-Id: <20060427203707.925046cf.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060421050124.GY14481@daedalus.andrew.net.au>
In-Reply-To: <20060421050124.GY14481@daedalus.andrew.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Andrew,

[Jean Delvare]
> > The result you have is consistent with the drivers you loaded (which in
> > turn sound OK for your hardware, I have a Dell Latitude D600 and I use
> > the same drivers.) The sensors program and libsensors library were
> > modified in lm_sensors 2.10.0 not to show non-sensors devices anymore
> > (at least for 2.6 kernels.) EEPROMs are not sensors so it didn't belong
> > there in the first place.

[Andrew Pollock]
> FWIW, the D600 is a vastly different beast to the D610. I made that mistake
> when I bought it.

Ah, didn't know that. I stupidly assumed that nearby numbering meant
nearby design.

[Andrew Pollock]
> So are you saying that given the drivers I've loaded, there's nothing to
> report on?

Yes, that's what I think, and said.

Your best chance for hardware monitoring on this laptop is ACPI
(fan, ec and thermal). Load all available acpi modules and see
in /proc/acpi/{embedded_controller,fan,thermal_zone} if there's any
interesting data to be found.

On my D600, embedded_controller and fan are empty directories, but
thermal_zone has some interesting files. I can get the system
temperature, a status flag and a critical temperature limit (which I can
also set). That's a bit cheap and inconvenient compared to what
lm_sensors can offer, but that's much better than nothing at all.

There's some documentation available about acpi/thermal_zone here:
http://acpi.sourceforge.net/documentation/thermal.html

Hope that helps,
-- 
Jean Delvare

