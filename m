From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:30 +0000
Subject: ASUS P4S333
Message-Id: <3C8031ED.F0A773C8@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020219105403.A1721@mercury.solarsys.net>
In-Reply-To: <20020219105403.A1721@mercury.solarsys.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

"Mark M. Hoffman" wrote:

> > If it is on the ASB100 i2c bus you are out of luck.
> 
> Maybe not... remember there's a SMBus connector on the board.
> Is there any reason I can't wire it to the parallel port and
> use the i2c-pport driver?  I hope the 8707 is on the same bus.
> I think I'll try that this weekend.
> 

A long shot but as long as the bus master on the board
is playing nice and has the bus tristated it might work.

> Also, please add me to the sensors mailing list.
> 

*** PHIL ^^^^^
