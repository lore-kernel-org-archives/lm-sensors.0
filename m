From: grant_lkml@dodo.com.au (Grant Coady)
Date: Sun, 29 May 2005 05:05:33 +0000
Subject: [lm-sensors] RFC PATCH I2C: w83781d: remove redundant w83697hf,
Message-Id: <4nai91d2etpr1g930rm8qvvbpde3tk0r1g@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <eq4d91hhldf7u9jjp8s03hc7qrv0e9jo1k@4ax.com>
In-Reply-To: <eq4d91hhldf7u9jjp8s03hc7qrv0e9jo1k@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Khali,
On Sat, 28 May 2005 08:03:00 +0200, Jean Delvare <khali@linux-fr.org> wrote:

>            In fact I would much like others to comment on this. In the
>first place I had not planned to do the chip support removal on
>lm_sensors2, only 2.6, but you did it, and maybe it's not a bad I idea.

You did ask me to take non-i2c out of both, if I wanted to have a go.  
But I need the practice and discipline anyway, so it don't matter if 
you don't pick it up.  Took two tries to 'get' the non-i2c part :)

>I have no strong opinion on this, but we have to remember that the
>lm_sensors2 branch is supposed to be stable (whatever it exactly means).

On my hardware with w83697hf and 2.4.30-hf2 kernel it was a little 
battle with lm_sensors to get it _not_ use w83781d driver and use 
w83627hf instead.  

Stable branch with a longer term plan to remove non-i2c sensor chips 
from i2c drivers?  SuperIO _are_ on ISA, so support for them in an 
i2c might be quick way to get support long ago.  Less choices, less 
hiding places for bugs, less longer term maintenance.  It's a change 
putting up patches with net code removal.

--Grant

