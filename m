From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 15 Jan 2007 17:28:42 +0000
Subject: [lm-sensors] MAX6655 support
Message-Id: <20070115182842.4b14ef96.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <7244bcd20701140424x71f0b2ceue44d7b4a90bb0bff@mail.gmail.com>
In-Reply-To: <7244bcd20701140424x71f0b2ceue44d7b4a90bb0bff@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Olexiy,

On Sun, 14 Jan 2007 14:24:27 +0200, Olexiy Avramchenko wrote:
> Is there any chanse for [1] (MAX6655/6 support) to be included in
> mainline? I've tried to follow "doc/developers/new_drivers" guideline
> but if something is missed or screwed in the patch please let me know.

The 2.4 kernel support of lm_sensors is essentially in maintenance
mode. We hardly have the resources to deal with all the drivers that
need to be merged in Linux 2.6, things can only get worse if we also
keep adding new drivers to lm_sensors for Linux 2.4.

So, unless you can find someone trustworthy willing to review your
driver publicly, it's probably not going to be integrated in lm_sensors
anytime soon.

The only part I am willing to review and apply is the update to
sensors-detect, so that at least people with these chips know that they
have them. I'll apply this part as soon as we are done with releasing
lm_sensors 2.10.2.

> PS: I'm attaching the copy of the linux 2.4 MAX6655, MAX6656
> lm-sensors 2.1x chip driver [2] anyway, so one may probably find and
> use it if needed.
> 
> [1] http://lists.lm-sensors.org/pipermail/lm-sensors/2007-January/018635.html
> [2] some keywords for search engines

I added an entry for the MAX6655 and MAX6656 chips to our "Devices"
wiki page, with a link to your previous post. That's about all I can
do, sorry.

-- 
Jean Delvare

