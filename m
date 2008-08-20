From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 20 Aug 2008 15:41:43 +0000
Subject: Re: [lm-sensors] PATCH: hwmon-new-driver-ti-tmp401.patch
Message-Id: <20080820174143.6c274c68@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4853E081.1020109@hhs.nl>
In-Reply-To: <4853E081.1020109@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 20 Aug 2008 13:20:32 +0200, Jean Delvare wrote:
> As a side note, it seems to me that your driver also supports the TI
> TMP411 chip. Both chips have the same device ID and seem to be
> essentially compatible. The only differences I can see are:
> * The TMP411 lacks the one-shot mode.
> * The TMP411 stores the minimum and maximum temperatures during runtime.
> * The TMP411 can be reset by software.

Oops, scratch this. I had an old version of the datasheet. The new
version has different IDs for the TMP411 (3 IDs, one for each possible
I2C address) and it also shows the one-shot mode. I'll fix sensors-detect
and the wiki in a minute.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
