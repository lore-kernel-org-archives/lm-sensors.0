From: hmh@debian.org (Henrique de Moraes Holschuh)
Date: Sun, 04 Jun 2006 17:58:31 +0000
Subject: [lm-sensors] sysfs interface for fan present capability
Message-Id: <20060604175831.GL24739@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4482843D.5020506@hhs.nl>
In-Reply-To: <4482843D.5020506@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 04 Jun 2006, Jean Delvare wrote:
> > On Sun, 04 Jun 2006, Jean Delvare wrote:
> > > Sure, why not. fan[1-*]_present sounds like a good idea. I wonder how
> > > this works physically. It would be great if other chips could implement
> > > this feature, that would make autoconfig easier for fans. If you
> > 
> > We can certainly implement it as in-driver logic if the hardware doesn't
> > cooperate, but a stuck fan on startup will be shown as not-present unless
> > you DO have hardware detection.
> 
> No, this feature is only valuable if implemented by the hardware. If we
> emulate it in any way, it would be in user space and not in the
> drivers, but even there I fail to see the value.

I fully agree, and I suggest that the sysfs interface description makes it
clear that this attribute can be exported only if it is a *hardware sense*
result...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

