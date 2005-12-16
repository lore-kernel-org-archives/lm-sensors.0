From: hmh@debian.org (Henrique de Moraes Holschuh)
Date: Fri, 16 Dec 2005 11:59:33 +0000
Subject: [lm-sensors] Kernel hangs with i2c-i801 driver?
Message-Id: <20051216115933.GB30996@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051123100021.GA29473@oden.homeip.net>
In-Reply-To: <20051123100021.GA29473@oden.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 15 Dec 2005, Daniel Nilsson wrote:
> SCI and/or SMI#. This should be programmed by the BIOS though, right?
> Linux should be messing around with these chipset registers?

Yes, it can mess with anything as long as it doesn't get it wrong.  In this
case, that means you need a quirk keyed for the specific motherboards that
have that SMI setup.  And that code is not going to be added to any i2c or
hwmon module, of course.  It lives elsewhere in the Kernel.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

