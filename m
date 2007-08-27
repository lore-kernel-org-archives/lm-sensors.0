From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 27 Aug 2007 08:53:30 +0000
Subject: Re: [lm-sensors] [PATCH 1/5] hwmon/lm85: Use dynamic sysfs callbacks
Message-Id: <20070827105330.2d81222c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070705203612.7e630af2@hyperion.delvare>
In-Reply-To: <20070705203612.7e630af2@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

On Mon, 9 Jul 2007 17:52:36 +0200, Krzysztof Helt wrote:
> On Thu, 5 Jul 2007 20:36:12 +0200
> Jean Delvare <khali@linux-fr.org> wrote:
> 
> >  drivers/hwmon/lm85.c |  551 ++++++++++++++++++++++----------------------------
> >  1 file changed, 244 insertions(+), 307 deletions(-)
> 
> I reviewed this patch and I don't see anything wrong. It is repetitive change of
> API for set/show functions.

As this patch was reviewed, can it please be added to hwmon-testing?

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
