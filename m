From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:50 +0000
Subject: Winbond W83792D driver
Message-Id: <oFLfUbC0.1113293123.0886490.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <42461044.3080406@mds.gotdns.com>
In-Reply-To: <42461044.3080406@mds.gotdns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


hi Mark,

> the way I read the datasheet the first time (page 44) bits 2 and 6 were
> fixed at 0 and 1; that's why I coded it the way I did.

I figured out that much.

> But reading again that doesn't look right, that's just the power-up
> default, they aren't fixed.

As a side note, it's quite smart from the Winbond designers to have made
the default subclient addresses depend on the main client address (let
alone the fact that the main address itself is now selectable). This
should address a number of issues we had before with (most notably Tyan)
systems having two Winbond chips.

That being said, it would have probably been even smarter to have bits
2-1 (as opposed to 1-0 currently) of the subclient addresses match the
lower bits of the main address, for an increased compatibility with
earlier designs.

--
Jean Delvare
