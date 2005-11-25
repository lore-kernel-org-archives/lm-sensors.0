From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Fri, 25 Nov 2005 17:51:31 +0000
Subject: [lm-sensors] Kernel hangs with i2c-i801 driver?
Message-Id: <20051125165114.GB9425@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051123100021.GA29473@oden.homeip.net>
In-Reply-To: <20051123100021.GA29473@oden.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello:

* Henrique de Moraes Holschuh <hmh@debian.org> [2005-11-23 17:02:33 -0200]:
> On Wed, 23 Nov 2005, Jean Delvare wrote:
> > driver didn't support it properly, including on SMP.
> 
> I use a 80875P+lm85 under SMT (using a SMP kernel) all the time, and
> stress-test it a lot. If 2.6.8-2.6.13 had any easy-to-hit problems with the
> SMBus i2c driver for the 80875P, I'd have hit it.

I also have an i875 SMT/SMP; I've never seen 'sensors -s' hang like that
either.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

