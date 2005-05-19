From: nico@cam.org (Nicolas Pitre)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: 2.6.10-mm2: it87 sensor driver stops CPU fan
Message-Id: <Pine.LNX.4.61.0501191448160.5315@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <200501080150.44653.pioppo@ferrara.linux.it>
 <20050108172020.64999e50.khali@linux-fr.org> <200501082023.54881.pioppo@ferrara.linux.it>
 <200501102023.44847.pioppo@ferrara.linux.it> <20050110203427.5061cf0d.khali@linux-fr.org>
In-Reply-To: <20050110203427.5061cf0d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LM Sensors <sensors@stimpy.netroedge.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Jean Delvare <khali@linux-fr.org>, Jonas Munsin <jmunsin@iki.fi>, Simone Piunno <pioppo@ferrara.linux.it>, djg@pdp8.net, greg@kroah.com

On Mon, 10 Jan 2005, Jean Delvare wrote:

> When I get this, I'll compare with the datasheets so as to understand
> how your chip is configured (or left unconfigured) by your BIOS. This
> will both help me propose a workaround in the it87 driver and explain
> the Gigabyte support what I think they should do.

FWIW, I have a Gigabyte motherboard with an it87 chip too.  Reading 
about this it87 polarity thing I'm suspecting something is really wrong 
here:

When system is idle, the sensors report shows:
CPU temp = +25?C and CPU fan = 2136 RPM (and rather noisy)

When system is 100% busy (with dd if=/dev/urandom of=/dev/null):
CPU temp = +41?C and CPU fan =   1288 RPM (and obviously much quieter)

I'm running a 2.6.10 kernel (not -mm) so I guess the BIOS settings for 
fan control are not altered.  And incidentally the BIOS has a setting 
called "smart fan control" set to "enabled" which maps to the ITxxF 
automatic PWM control mode I suppose.  So if the BIOS actually set the 
fan polarity wrong then the fan would slow down when the temperature 
rises and vice versa, right?


Nicolas
