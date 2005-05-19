From: pioppo@ferrara.linux.it (Simone Piunno)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: [PATCH 2.6] I2C: Allow it87 pwm reconfiguration
Message-Id: <200501151818.27227.pioppo@ferrara.linux.it>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050113232904.GC2458@kroah.com> <g7Idbr9m.1105713630.9207120.khali@localhost> <20050115163045.2e636632.khali@linux-fr.org>
In-Reply-To: <20050115163045.2e636632.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LM Sensors <sensors@stimpy.netroedge.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>, Jonas Munsin <jmunsin@iki.fi>, djg@pdp8.net

On Saturday 15 January 2005 16:30, Jean Delvare wrote:

> Simone, feel free to test this (on top of 2.6.11-rc1-mm1 for example).

I've been unable to apply your patch cleanly on top of 2.6.11-rc1-mm1, but 
eventually I've managed to apply it manually.

I can confirm it works as expected.

Without parameters I get in dmesg:

  it87: Found IT8705F chip at 0x290, revision 2
  it87 0-0290: Detected broken BIOS defaults, disabling PWM interface

No pwm appears in sysfs and the missing linefeed has been fixed

Adding "options it87 fix_pwm_polarity=1" in modules.conf I get:

  it87: Found IT8705F chip at 0x290, revision 2
  it87 0-0290: Reconfiguring PWM to active high polarity

PWM controllers appear in sysfs, the fan doesn't stop running at load time and 
pwm values are now in normal direction: (0 stops, 255 runs full-speed).

Thanks!

/Simone

-- 
http://thisurlenablesemailtogetthroughoverzealousspamfilters.org
