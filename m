From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 28 May 2005 08:03:10 +0000
Subject: [lm-sensors] RFC PATCH I2C: w83781d: remove redundant w83697hf,
Message-Id: <20050528080300.635e88db.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <eq4d91hhldf7u9jjp8s03hc7qrv0e9jo1k@4ax.com>
In-Reply-To: <eq4d91hhldf7u9jjp8s03hc7qrv0e9jo1k@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant,

> > Please do not remove the w83627hf support for now. The W83627HF chip
> > has an I2C/SMBus interface, which the w83627hf driver doesn't support
> > (and we don't want to add I2C/SMBus support to the w83627hf driver).
> 
> Okay, that would be true for lm_sensors2 as well?

Obviously.

> Will do, gets
> easier  each time I go in :)  Perhaps I'll wait for okay on this
> before going to  lm_sensors2 again?

I think so. In fact I would much like others to comment on this. In the
first place I had not planned to do the chip support removal on
lm_sensors2, only 2.6, but you did it, and maybe it's not a bad I idea.
I have no strong opinion on this, but we have to remember that the
lm_sensors2 branch is supposed to be stable (whatever it exactly means).

-- 
Jean Delvare
