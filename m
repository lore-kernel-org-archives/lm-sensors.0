From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 12 Jul 2011 06:38:49 +0000
Subject: Re: [lm-sensors] RFC: Moving pmbus drivers into hwmon subdirectory
Message-Id: <20110712083849.0adcc5cc@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110712021230.GA22766@ericsson.com>
In-Reply-To: <20110712021230.GA22766@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 11 Jul 2011 19:12:30 -0700, Guenter Roeck wrote:
> Hi all,
> 
> since the number of PMBus slave/client drivers keeps getting larger,
> I have been wondering if I should move them into a separate subdirectory,
> most likely drivers/hwmon/pmbus/.
> 
> Any thoughts/comments about that ?

Seems to be a good idea, yes.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
