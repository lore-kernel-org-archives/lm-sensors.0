From: gardner.ben@gmail.com (Ben Gardner)
Date: Sun, 18 Dec 2005 23:59:09 +0000
Subject: [lm-sensors] [PATCH] i2c-busses-scx200_acb : add support for
Message-Id: <1134950349.7485.0.camel@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <808c8e9d0512160810t664d3939t846efce05a50ebf0@mail.gmail.com>
In-Reply-To: <808c8e9d0512160810t664d3939t846efce05a50ebf0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Good idea.
As long as I'm at it, I'll do some cleanup based on your feedback to the
i2c-cs5535 driver, since that all still applies.

Thanks,
Ben

On Sun, 2005-12-18 at 18:42 +0100, Jean Delvare wrote:
> Hi Ben,
> 
> > Modify scx200_acb.c to support the AMD Geode CS5535 and CS5536 SMBus,
> > since they are all register-compatible.
> 
> Can you please split this patch into two distinct parts:
> 1* Whitespace cleanups and similar minor edits.
> 2* AMD Geode CS5535 and CS5536 support.
> 
> This will make the review much easier.
> 
> Thanks,


