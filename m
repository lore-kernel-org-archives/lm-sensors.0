From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 19 Oct 2007 09:22:31 +0000
Subject: [lm-sensors] What todo with driver entry in sensors-detect for FSC
Message-Id: <47187757.3000308@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi All,

I just remembered that I still need to update 2.10.5's sensors-detect for the 
new fschmd driver. I've left the fscpos and fscher drivers in there for now as 
fschmd will not be available until 2.6.24 gets released.

But what should I do with the fscscy entry? The fscscy driver is only available 
in 2.4 and in 2.6 the fschmd driver should be used.

Thanks & Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
