From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:50 +0000
Subject: Hardware monitoring presentation - slides
Message-Id: <fPoSKztT.1112965073.4023330.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050408014932.GD10623@jupiter.solarsys.private>
In-Reply-To: <20050408014932.GD10623@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Mark,

> On March 2, I gave a presentation to my local LUG in Philadelphia [1]
> on "Hardware Monitoring with lm_sensors and smartmontools".  The
> slides are available [2] if anyone is interested.

That's really good stuff. Now I know that smartd can be configured to
ignore the changes of some of the attributes, which I'd really need.

A couple notes on the lm_sensors part:

1* You do not mention SMBus at all. I think you should, as possibly
people will read about SMBus in their motherboard manual, and will be
interested to know that it is (almost) the same as I2C.

2* "Whenever you modify the /etc/sensors.conf file, you must run sensors
-s to apply the changes." This isn't exactly correct, most changes
will take effect immediately. Only changes made to "set" lines
requires "sensors -s".

3* About VRM, you could add that VRM is now automatically detected.
Pretty soon, setting the VRM through /etc/sensors.conf will not be even
possible anymore.

Great work :)
--
Jean Delvare
