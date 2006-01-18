From: mgreer@mvista.com (Mark A. Greer)
Date: Wed, 18 Jan 2006 21:46:56 +0000
Subject: [lm-sensors] [PATCH] m41t00.c: sleepable i2c transfer cannot be
Message-Id: <20060118214656.GB15714@mag.az.mvista.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060118175510.GB13367@dmt.cnet>
In-Reply-To: <20060118175510.GB13367@dmt.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jan 18, 2006 at 03:55:10PM -0200, Marcelo Tosatti wrote:
> 
> Reported-by: Helio Fujimoto <Helio.Fujimoto at cyclades.com>
> 
> drivers/i2c/chips/m41t00.c RTC driver has a serious bug: it performs sleepable i2c 
> transfer at soft interrupt context, resulting in:

Marcelo, Helio,

This is a known bug and fixed in a patch that has been presented to
lm-sensors.

http://lists.lm-sensors.org/pipermail/lm-sensors/2005-December/014724.html

In addition to the bug fix, that patch adds support for some other m41txx
rtc chips and there is an outstanding question that needs to be answered
before it can continue on (read: a final patch presented & accepted).

Please bear with me and hopefully it will be fixed soon.

Mark

