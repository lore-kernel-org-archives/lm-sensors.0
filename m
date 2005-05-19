From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:30 +0000
Subject: 2.6.10-mm2: it87 sensor driver stops CPU fan
Message-Id: <20050111224130.GA19173@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200501102341.44949.pioppo@ferrara.linux.it> <YN0o4rkI.1105435582.0805630.khali@localhost> <20050111202437.GA2914@nemo.sby.abo.fi>
In-Reply-To: <20050111202437.GA2914@nemo.sby.abo.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonas Munsin <jmunsin@iki.fi>, Jean Delvare <khali@linux-fr.org>, pioppo@ferrara.linux.it, sensors@Stimpy.netroedge.com, djg@pdp8.net, LKML <linux-kernel@vger.kernel.org>

On Tue, Jan 11, 2005 at 10:24:38PM +0200, Jonas Munsin wrote:
> On Tue, Jan 11, 2005 at 10:26:22AM +0100, Jean Delvare wrote:
> > 1* Jonas, please send a modified version of your original patch to Greg.
> > The only difference would be that you wouldn't force on/off mode to be
> > on at driver load time. Instead, disabling PWM for one fan control
> > output (echo 0 > pwmN_enable) would both set on/off mode to on for that
> > output (new) and turn that output to on/off mode (same as before).
> 
> Ok, thanks for doing the thinking ;), here is the modified patch
> (it87.c_2.6.10-jm3-corrected_manual_pwm_20050111.diff). In addition to
> the above change, it also refreshes fan_main_ctrl in the update routine,
> as suggested by Jean on IRC.
> 
>  - adds manual PWM
>  - removes buggy "reset" module parameter
>  - fixes some whitespaces

Applied, thanks.

greg k-h
