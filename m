From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: Gigabyte GA-K8NS Ultra-939 issues
Message-Id: <20050508215026.263b7ba3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050507182053.GA4791@amelek.gda.pl>
In-Reply-To: <20050507182053.GA4791@amelek.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Marek,

> in8 seems to always give +4.08V (a little too high for 3V battery?)

Yes, a bit high as you say. +4.08 is the max value which can be sensed,
if this helps.

> vid reports 2.8V while this CPU uses 1.4 / 1.1 V (for 1800 / 1000 MHz)

Have you tried changing VRM?

> With the help of lm_sensors, it should be possible to tweak IT8712
> "smart guardian" settings to make it work right on this motherboard
> under Linux.  But, I'm wondering if the lm_sensors developers have
> any good contacts with Gigabyte BIOS developers, who could fix the
> settings to make it work right by default under any OS...

I don't think we have such contacts. You may take your chance with
Gigabyte directly.

Note that the it87 driver of Linux 2.6 is quite diffrent from the Linux
2.4 version, so you might give it a try. Maybe it will behave
differently.

As a side note, I just bought myself a system which is similar to yours:
box AMD Athlon 64 3200+ on a Gigabyte G8V Ultra-939. I yet have to
install Linux on it, so I can't tell how lm_sensors will work there.
Feel free to come back to me in some times if you want me to share my
experience.

-- 
Jean Delvare
