From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 22 Oct 2009 12:28:46 +0000
Subject: Re: [lm-sensors] Gigabyte GA-P35-DS3P - VID Zero value
Message-Id: <20091022142846.1c347589@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091019164516.701032uxlen5ai2k@mail.simonandkate.net>
In-Reply-To: <20091019164516.701032uxlen5ai2k@mail.simonandkate.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Adam,

On Wed, 21 Oct 2009 14:53:19 +0200, Jean Delvare wrote:
> On Tue, 20 Oct 2009 21:50:31 +1000, Adam Nielsen wrote:
> > I can test an it87 patch if you need a guinea pig - especially if it'll
> > compile against 2.6.30 so I don't have to reboot ;-)
> 
> I'll prepare a patch as my time and health permits.

Here's a standalone driver for you to try:
http://khali.linux-fr.org/devel/misc/it87/

Build with "make", then as root, "rmmod it87 && insmod it87.ko".

Should build fine on any recent kernel. Fixes in this version of the
it87 driver:
* Really read VID on IT8718F/IT8720F.
* Don't expose VID if pins are in GPIO mode.
* Don't expose fan2 if pin is in GPIO mode.
* Don't expose fan3 if pin is in GPIO mode.
* Don't expose pwm2 if pin is in GPIO mode.
* Don't expose pwm3 if pin is in GPIO mode.

According to the dump you sent, only item #2 should be relevant for
your motherboard.

The last 5 items affect all chip types except the IT8705F. Everyone
else with one of the affected chips is welcome to test and report.

I'll send separate patches to the mailing list soon, for review.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
