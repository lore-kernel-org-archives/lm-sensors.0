From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Fri, 25 Nov 2005 17:54:40 +0000
Subject: [lm-sensors] Kernel hangs with i2c-i801 driver?
Message-Id: <20051125165429.GC9425@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051123100021.GA29473@oden.homeip.net>
In-Reply-To: <20051123100021.GA29473@oden.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello:

* Henrique de Moraes Holschuh <hmh@debian.org> [2005-11-23 23:57:57 -0200]:
> On Wed, 23 Nov 2005, Jean Delvare wrote:
> > abandonned. I wish I had an SMBus 2.0 system myself to experiment with,
> > but unfortunately even the most recent systems I have don't support
> > SMBus 2.0.
> 
> Well, I suppose this means there is a device in that bus doing it, because I

Correct.

> have the same SMBus controller and there is no such 0x61 (neither is there a
> 0x64) device in the scan report.

If a device supports SMBus 2.0, it will answer on 0x61.  In fact, there may
be *multiple* devices answering on 0x61... which is perfectly normal, until
the host assigns them all individual addresses.

But as was mentioned, that is not supported in Linux at the moment.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

