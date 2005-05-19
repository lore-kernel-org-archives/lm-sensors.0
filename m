From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:30 +0000
Subject: 2.6.10-mm2: it87 sensor driver stops CPU fan
Message-Id: <20050113232904.GC2458@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200501102341.44949.pioppo@ferrara.linux.it> <YN0o4rkI.1105435582.0805630.khali@localhost> <20050112222735.GA13572@nemo.sby.abo.fi>
In-Reply-To: <20050112222735.GA13572@nemo.sby.abo.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonas Munsin <jmunsin@iki.fi>, Jean Delvare <khali@linux-fr.org>, pioppo@ferrara.linux.it, sensors@Stimpy.netroedge.com, djg@pdp8.net, LKML <linux-kernel@vger.kernel.org>

On Thu, Jan 13, 2005 at 12:27:35AM +0200, Jonas Munsin wrote:
> > 2* I would then add a check to the it87 driver, which completely disables
> > the fan speed control interface if the initial configuration looks weird
> > (all fans supposedly stopped and polarity set to "active low"). This
> > should protect users of the driver who have a faulty BIOS.
> > 
> > When a bogus configuration is detected, we would of course complain in
> > the logs and invite the user to complain to his/her motherboard maker
> > too.
> 
> Here is it87.c_2.6.10-jm4-detect_broken_bios_20050112.diff implementing
> this. It goes on top of the previous patch.
> 
> - detects broken bioses, disables the pwm for them and prints a message
> - fixes an unrelated minor bug in set_fan_div()
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Signed-off-by: Jonas Munsin <jmunsin@iki.fi>

Applied, thanks.

greg k-h
