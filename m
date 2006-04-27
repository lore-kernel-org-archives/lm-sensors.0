From: tandrews@grok.co.za (Thomas Andrews)
Date: Thu, 27 Apr 2006 10:34:29 +0000
Subject: [lm-sensors] making a geode i2c slave driver
Message-Id: <20060427103429.GB27959@grok.co.za>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060427092159.GA27959@grok.co.za>
In-Reply-To: <20060427092159.GA27959@grok.co.za>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Apr 27, 2006 at 11:21:59AM +0200, Thomas Andrews wrote:

> I need to get the kernel to become an i2c slave from time to time. The
> kernel is on a geode sc1100. Actually it is on one of Pascal's
> (pc-engines) "WRAP" boards.

Just a small additional note - I don't really need a "full" slave
implementation, because the Atmel is not likely to ever read from the
geode. It will basically write status info to the geode only. I think
that should make it much simpler.

Regards,
Thomas

