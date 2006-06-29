From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 29 Jun 2006 11:34:56 +0000
Subject: [lm-sensors] RTC + DS1337
Message-Id: <20060629113456.GB4772@home.fluff.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44A37C0E.3090604@laposte.net>
In-Reply-To: <44A37C0E.3090604@laposte.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jun 29, 2006 at 09:06:54AM +0200, Matthieu TORRES wrote:
> Hi,
> 
> I faced a problem with DS1337 RTC.  I use a pxa255 cpu with 2.6.16 
> kernel. I tried to make a DS1339 chip (real time clock) working with 
> hwclock.
> In my config, I selected I2C, DS1337/DS1339 driver, and ehanced RTC 
> support to have it working with /dev/rtc as expected by hwclock. That is 
> to say the following options:
> 
> CONFIG_RTC=y
> CONFIG_I2C=y
> CONFIG_I2C_PXA=y
> CONFIG_SENSORS_DS1337=y
> 
> The ioctl() to dev/rtc did not work. While investaigating on that issue, 
> I found 2 problems :

Look at 2.6.17, which has a new RTC core, and sysfs based interface
which is much cleaner way of dealing with the RTC systems on the many
different systems that there are.

-- 
Ben (ben at fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

