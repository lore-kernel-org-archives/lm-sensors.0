From: hmh@debian.org (Henrique de Moraes Holschuh)
Date: Sat, 17 Jun 2006 15:42:38 +0000
Subject: [lm-sensors] Second request to support the 'Analog Devices
Message-Id: <20060617154238.GI29687@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <449408C1.1000307@dolbeau.org>
In-Reply-To: <449408C1.1000307@dolbeau.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 17 Jun 2006, Romain Dolbeau wrote:
> I thought of that at first (more experienced people
> claim it's basically a grandson of the lm85), but

If it is a grandson of the lm85, I can help you.  But we *need* the spec
sheet, lm85 and look-alikes are very complex chips, you have to read the
entire datasheet to not hit gotchas.

> unfortunately this particular machine is a test machine
> at my company, and there's actually people working
> on it. So I can't start modprobe'ing some random code

*If* the chip looks very much like an lm85 or an ATDT7463, *and* you get us
a full datasheet, we can try to do a spec-sheet-based change to lm85 and
carefully review it before you try.  At least it shouldn't oops the kernel
:-) and chances are it will actually work fine.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

