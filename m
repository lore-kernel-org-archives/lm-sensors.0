From: hmh@debian.org (Henrique de Moraes Holschuh)
Date: Fri, 16 Sep 2005 17:36:59 +0000
Subject: [lm-sensors] RFC: Acoustics enhancement interface
Message-Id: <20050916153433.GA28335@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050911211327.GA23393@khazad-dum.debian.net>
In-Reply-To: <20050911211327.GA23393@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 11 Sep 2005, Henrique de Moraes Holschuh wrote:
> Unfortunately, such an interface appears to not have been defined yet, so
> here is my proposal:

Well, since no one commented on this, I am implementing it asis.

> auto_acoustics_enhancement_pwm#:
> auto_acoustics_enhancement_fan#:

Added auto_acoustics_enhancement_temp# as well.  Alternatively,
auto_acoustics_enhancement_channel could have been used instead of _temp and
_pwm, but this is much more user friendly IMHO.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
