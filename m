From: jeff@jdfiles.org (jeff@jdfiles.org)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: i2c for Alpha
Message-Id: <1209.10.0.0.5.1067304320.squirrel@secure.jdfiles.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200310121707.56799.jeff@jdfiles.org>
In-Reply-To: <200310121707.56799.jeff@jdfiles.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Yes, that would explain why you don't detect anything useful. Unless you
> are able to get a driver (or at least specs) for that XBUS thing, I fear
> you won't be able to use our drivers at all on your system. And even
> then, I wonder what kind of bus master you might have and how we'll make
> it work through that XBUS.

XBUS appears to an ISA bus, so that should be straightforward. It's just
finding the on-ramp to the thing...
