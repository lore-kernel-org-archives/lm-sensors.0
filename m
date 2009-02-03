From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 03 Feb 2009 18:55:31 +0000
Subject: Re: [lm-sensors] fan control questions
Message-Id: <20090203195531.6e4a90cf@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <glni7k$fut$1@ger.gmane.org>
In-Reply-To: <glni7k$fut$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

On Tue, 03 Feb 2009 10:29:56 -0800, Mark Nienberg wrote:
> Jean Delvare wrote:
> > It would help if you would provide more information about your board.
> > In particular, which hardware monitoring chip(s) are found by
> > sensors-detect? What does the output of "sensors" look like?
> > 
> > If there is more than one chip, are the PWM outputs found on the same
> > chip that reports the fan speeds?
> 
> I'll run pwmconfig again and see if I can answer that.  Maybe I should try a newer 
> lm_sensors, but so far I have been sticking with rpms rather than source.

The sensors-detect script is standalone, so you can download the latest
version, run it, report and delete it afterwards:

http://www.lm-sensors.org/svn/lm-sensors/trunk/prog/detect/sensors-detect

This should at least tell us whether there's a second hardware
monitoring chip available on your system.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
