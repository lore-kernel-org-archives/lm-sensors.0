From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 20 Aug 2007 12:07:07 +0000
Subject: Re: [lm-sensors] lm-sensors-3.0.0 snapshots
Message-Id: <20070820140707.62854ed3@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070818175926.6ed4411e@hyperion.delvare>
In-Reply-To: <20070818175926.6ed4411e@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Axel,

On Sun, 19 Aug 2007 17:04:35 +0200, Axel Thimm wrote:
> On Sun, Aug 19, 2007 at 04:26:17PM +0200, Jean Delvare wrote:
> > I would be fine with
> > 
> > http://dl.lm-sensors.org/lm-sensors/snapshots/lm-sensors-3-r<rev>-<date>.tar.bz2
> 
> I changed /lm-sensors/ -> /lm-sensors-3/ for symmetry's sake 8and
> because it was easier to script ;)
> 
> > For i2c, no need to change anything as there is no development branch.
> > 
> > (...)
> > For i2c-tools, this really doesn't have anything to do with i2c, so I
> > would like to have a separate base directory:
> > 
> > http://dl.lm-sensors.org/i2c-tools/snapshots/i2c-tools-r<rev>-<date>.tar.bz2
> 
> OK, done. I manually kicked in the first snapshots, the next should
> follow once bits in the respective dir change (in daily frequencies).

Doesn't seem to work. No new snapshots this morning for lm-sensors nor
lm-sensors-3 despite my commits yesterday evening. Can you please check?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
