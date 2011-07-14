From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 14 Jul 2011 11:52:24 +0000
Subject: Re: [lm-sensors] RFC: Moving pmbus drivers into hwmon subdirectory
Message-Id: <20110714135224.43a7cd9e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110712021230.GA22766@ericsson.com>
In-Reply-To: <20110712021230.GA22766@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 12 Jul 2011 08:38:49 +0200, Jean Delvare wrote:
> On Mon, 11 Jul 2011 19:12:30 -0700, Guenter Roeck wrote:
> > Hi all,
> > 
> > since the number of PMBus slave/client drivers keeps getting larger,
> > I have been wondering if I should move them into a separate subdirectory,
> > most likely drivers/hwmon/pmbus/.
> > 
> > Any thoughts/comments about that ?
> 
> Seems to be a good idea, yes.

Thinking some more about this... Does PMBus fit entirely in hwmon, or
does it cover additional functions? If it does cover additional
functions, then maybe drivers/pmbus would be a better place.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
