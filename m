From: olof@lixom.net (Olof Johansson)
Date: Thu, 25 Jan 2007 17:11:24 +0000
Subject: [lm-sensors] [PATCH] [2.6.21] Add adt7467 to lm85
Message-Id: <20070125171124.GA17472@lixom.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070125173825.c7a60c7e.khali@linux-fr.org>
In-Reply-To: <20070125173825.c7a60c7e.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jan 25, 2007 at 05:38:25PM +0100, Jean Delvare wrote:
> Hi Olof,
> 
> You hit the wrong list. Hardware monitoring driver updates should be
> directed to the lm-sensors list, to which I am replying.

Yep, my bad. Sorry about that.

> On Thu, 25 Jan 2007 01:10:02 -0600, Olof Johansson wrote:
> > Enable ADT7467 support in lm85.
> 
> Did you make sure that the ADT7467 is 100% compatible with the ADT7463?
> The change of major revision number causes me to have a doubt.

The main difference seems to be that the 7467 lacks some of the voltage
features, something that I wasn't using in my setup so I never ran into
issues with it. I'll double-check and repost.

> Please also update Documentation/hwmon/lm85 and drivers/hwmon/Kconfig.

Will do.


-Olof

