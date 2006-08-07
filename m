From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 07 Aug 2006 10:19:09 +0000
Subject: [lm-sensors] BIOS Corruption (was : new abituguru driver in mm
Message-Id: <20060807121909.fef9fe74.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <ce9ef0d90608052222j74e9f6fes40cbc5edf5678577@mail.gmail.com>
In-Reply-To: <ce9ef0d90608052222j74e9f6fes40cbc5edf5678577@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sunil, Hans,

> I found an issue with the driver. It seems to have put something in the
> uguru part of BIOS, which makes my BIOS hang when I enter Abit uGuru
> temperature monitor screen in the BIOS. No keys work and only way for me at
> that point is to give it the three finger salute. The peculiar thing I
> noticed was that somehow it modified the shutdown and beep CPU temperatures
> to 245C and 235C while I had them set at 65C and 75C.
> 
> As soon as the temp monitor displays 245C in CPU row, it just hangs. The
> next values to be displayed are the enable bit for these temps, I think.
> 
> I never used the driver to write anything to BIOS, so how did it end up
> updating those values?

Err, this is bad :(

Hans, see why I was reluctant to having your driver in the kernel tree?
Nothing personal, but that kind of problem is to be expected when
writing a driver without a datasheet :(

What should we do now? Mark the driver broken in the kernel tree?
2.6.18 is just around the corner, and we sure don't want people to
corrupt their BIOS.

Sunil, did you try a complete power-off (with PSU switched off or
unplugged) to see if the default values are back?

-- 
Jean Delvare

