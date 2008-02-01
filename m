From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 01 Feb 2008 13:21:11 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (it87) Add individual alarm
Message-Id: <20080201142111.6d3ce58b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 28 Jan 2008 14:27:06 +0200, Riku Voipio wrote:
> Jean Delvare wrote:
> > The new libsensors needs this.
> >
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > ---
> > Riku, you said you have a chip to test the it87 driver, maybe you can
> > test this patch? Thanks.
>
> Sorry, forgot about this. Reviewed, fine. Tested by applying to
> 2.6.24, adds correctly the alarm sysfs nodes and new lm-sensors
> parses them fine. full ack.

Thanks Riku!

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
