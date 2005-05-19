From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: 2.6.10-mm2: it87 sensor driver stops CPU fan
Message-Id: <20050119215209.77950499.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200501080150.44653.pioppo@ferrara.linux.it>
	<20050108172020.64999e50.khali@linux-fr.org>
	<200501082023.54881.pioppo@ferrara.linux.it>
	<200501102023.44847.pioppo@ferrara.linux.it>
	<20050110203427.5061cf0d.khali@linux-fr.org>
	<Pine.LNX.4.61.0501191448160.5315@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.61.0501191448160.5315@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicolas Pitre <nico@cam.org>
Cc: Jonas Munsin <jmunsin@iki.fi>, Simone Piunno <pioppo@ferrara.linux.it>, LM Sensors <sensors@stimpy.netroedge.com>, LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>

Hi Nicolas,

> FWIW, I have a Gigabyte motherboard with an it87 chip too.  Reading 
> about this it87 polarity thing I'm suspecting something is really
> wrong  here:
> 
> When system is idle, the sensors report shows:
> CPU temp = +25?C and CPU fan = 2136 RPM (and rather noisy)
> 
> When system is 100% busy (with dd if=/dev/urandom of=/dev/null):
> CPU temp = +41?C and CPU fan =   1288 RPM (and obviously much quieter)
> 
> I'm running a 2.6.10 kernel (not -mm) so I guess the BIOS settings for
> fan control are not altered.  And incidentally the BIOS has a setting 
> called "smart fan control" set to "enabled" which maps to the ITxxF 
> automatic PWM control mode I suppose.  So if the BIOS actually set the
> fan polarity wrong then the fan would slow down when the temperature 
> rises and vice versa, right?

That's right, what you describe really sounds like a wrong polarity
setting.

Could you please tell us what model it is, with what BIOS revision? I
would also appreciate a dump of the chip (isadump 0x295 0x296 unless it
lives at some uncommon address) to confirm the guess.

The code Jonas and I have been adding to the it87 driver recently will
probably not work for you if you leave the "smart fan control" enabled
in your BIOS setup screen (because we supposed that no reponsible
motherboard maker would enable this mode without properly configuring
the polarity beforehand - wrong guess in your case - and are not
allowing a polarity inversion in this case). However, by disabling this
mode in the BIOS setup screen, you should be able to use the new
fix_pwm_polarity module register to get the polarity fixed, with manual
PWM control (no auto mode yet).

You might also search for a BIOS update for your board. I consider the
behavior your describe a major problem and would expect Gigabyte to fix
it at some point in time.

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/
