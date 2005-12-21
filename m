From: mrenzmann@otaku42.de (Michael Renzmann)
Date: Wed, 21 Dec 2005 17:18:23 +0000
Subject: [lm-sensors] [PATCH] LM77: correction of "register
Message-Id: <1135185503.4485.29.camel@gimli>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean.

On Tue, 2005-12-20 at 20:52 +0100, Jean Delvare wrote:
> You seem to think that using more than one bit for sign is odd from
> National. This is actually the standard way of doing though. Think
> about it. [...]

Now that you say it: you're absolutely right. And as a result:

> Your patch is probably correct but also needlessly complex. All we
> really have here is a unsigned vs. signed issue. What about this more
> simple fix instead?

Tried your patch, with a test program I wrote (testing against the
positive and negative temperature values given in the LM77 data sheet)
as well as with a live system (only with positive temperature readings,
though). The patch works fine, thanks.

Bye, Mike


