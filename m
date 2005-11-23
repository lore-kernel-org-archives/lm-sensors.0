From: hmh@debian.org (Henrique de Moraes Holschuh)
Date: Wed, 23 Nov 2005 20:02:55 +0000
Subject: [lm-sensors] Kernel hangs with i2c-i801 driver?
Message-Id: <20051123190233.GB8899@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051123100021.GA29473@oden.homeip.net>
In-Reply-To: <20051123100021.GA29473@oden.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 23 Nov 2005, Jean Delvare wrote:
> driver didn't support it properly, including on SMP.

I use a 80875P+lm85 under SMT (using a SMP kernel) all the time, and
stress-test it a lot. If 2.6.8-2.6.13 had any easy-to-hit problems with the
SMBus i2c driver for the 80875P, I'd have hit it.

> The pretty much rules out the i2c-i801 driver guilt IMHO, on its own at
> least.

Yeah, it would have to be a corner case, or something else equally rare.

> > 60: XX 61 XX XX 64 XX XX XX XX 69 XX XX XX XX XX XX
> > 70: XX XX XX XX XX XX XX XX
> 
> I am really curious what the device at 0x64 can be. We don't know of any
> device living at that address.

And that 0x61? What would be that one?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
