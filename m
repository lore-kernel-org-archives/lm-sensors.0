From: gardner.ben@gmail.com (Ben Gardner)
Date: Fri, 02 Dec 2005 20:28:19 +0000
Subject: [lm-sensors] Re: [patch] ds2482: i2c to 1-wire bridge
Message-Id: <808c8e9d0512021127u2f992fcbk3fc6b573a2ef0a70@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <808c8e9d0512020734rb7d351bla98161d14c8cb70@mail.gmail.com>
In-Reply-To: <808c8e9d0512020734rb7d351bla98161d14c8cb70@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Evgeniy,

I will incorporate your suggestions and repost the patch.
 - remove unecessary () in return statements
 - remove { } from around simple, single statement if statement bodies
 - fix indentation of #defines
 - add timeout for ds2482_wait_1wire_idle (good catch, BTW)
 - fix Kconfig stuff

Thank you for your time!

Ben
