From: mrenzmann@otaku42.de (Michael Renzmann)
Date: Tue, 27 Jun 2006 10:42:05 +0000
Subject: [lm-sensors] snapshot generation
Message-Id: <2375.194.45.26.221.1151404925.squirrel@webmail.otaku42.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <449D304E.5070603@sh.cvut.cz>
In-Reply-To: <449D304E.5070603@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi (again).

Sorry for the noise (by adding yet another mail to this thread), I didn't
notice that part of Axel's mail before:

> On Mon, Jun 26, 2006 at 09:56:08PM +0200, Jean Delvare wrote:
>> It would also be convenient if we could have a "Download" link it
>> trac's top bar, as this is clearly one of the most popular page. Is it
>> possible? I'm surprised there isn't one by default.
>
> That seems to be a bit difficult and is currently advised against
> since it may conflict with upgrades

I wrote a plugin (which should work on Trac 0.9 as well as 0.10-dev, but
tested it on 0.9 only so far) which allows to add custom buttons to the
various navigation bars. You can see it in action on http://madwifi.org -
the "download" button in the mainnav bar is added by the plugin.

I will publish the plugin on trac-hacks.org as soon as I find a bit time
to document it, but can provide it to you along with a few lines of
explanation if you're interested.

Bye, Mike


