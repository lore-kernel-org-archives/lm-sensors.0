From: Stephen Clark <sclark46@earthlink.net>
Date: Thu, 01 Jan 2009 02:56:47 +0000
Subject: [lm-sensors] Support for Intel DG33FB main board?
Message-Id: <495C30EF.3090708@earthlink.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I have a new intel DG33FB mainboard when I run sensors-detect I get the following:
...
Trying family `SMSC'...                                     Yes
Found `SMSC LPC47M182 Super IO Fan Sensors'
     (but not activated)
...
Intel Core family thermal sensor...                         Success!
     (driver `coretemp')

This lets me see the temps of the cores on my q6600 but not
voltages or fan speeds. Are there any plans to support this
main boards further?

sensors version 3.0.2 with libsensors version 3.0.2

Thanks,
Steve

PS I am not subscribed so please CC me.

-- 

"They that give up essential liberty to obtain temporary safety,
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty
decreases."  (Thomas Jefferson)



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
