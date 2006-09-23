From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 23 Sep 2006 21:34:04 +0000
Subject: [lm-sensors] [patch 3/3] pc87360 - fix unchecked
Message-Id: <20060923233404.d638c9b5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44E73765.80603@gmail.com>
In-Reply-To: <44E73765.80603@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

> BTW, everything includes :
> 3 patches for pc87360 return-status-checks (already on your list)
> 1 vrm patch,
> 2 patches giving  pc87360 2D-callbacks,
> 3 superio-locks patches (add module, use in pc87360 & pc8736x_gpio)
> 
> Id like to get these into 18-mmX, for some value of X.
> Do you have any thoughts on how and when this should happen ?
> Im presuming it is sometime after the 19-rc0 submit window closes.

Yeah, for now I am concentrating on pushing all "important" hwmon
patches to Greg for 2.6.19-rc1. This should happen tomorrow. This will
be a large patchset, which isn't ideal as the merge window is already
open, so I had to postpone some less important patches. But we really
want the unchecked return values to be fixed in 2.6.19.

For your own patches, this means the following:
* 3 patches for pc87360 return-status-checks
  -> 2.6.19-rc1
* 1 vrm patch
  -> 2.6.19-rc1-mm1
* 2 patches giving pc87360 2D-callbacks
  -> I need to review them first, I seem to remember that a quick look
  had me conclude "first OK, second not quite so". But I'm not so sure
  so I need to spend some more time on it.
* 3 superio-locks patches (add module, use in pc87360 & pc8736x_gpio)
  -> I already know I won't have time to handle this. I am busy enough
  with hwmon and i2c, I just can't work on yet another subsystem or I'm
  going to blow up into pieces.

-- 
Jean Delvare

