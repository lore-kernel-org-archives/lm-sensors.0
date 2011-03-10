From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 10 Mar 2011 05:06:40 +0000
Subject: Re: [lm-sensors] RFC: nct6776f support in the w83627ehf and fan RPM
Message-Id: <20110310050640.GA14075@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BE6F61DB46364D4B839ED3F50CDFDFAB@portable2>
In-Reply-To: <BE6F61DB46364D4B839ED3F50CDFDFAB@portable2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi again,

On Wed, Mar 09, 2011 at 10:45:30PM -0500, Guenter Roeck wrote:
[ ... ] 
> > fan1:                    0 RPM  (min =    0 RPM, div = 64)
> > fan2:                 1110 RPM  (min =    0 RPM, div = 32)  ALARM
> > fan3:                    0 RPM  (min =    0 RPM, div = 64)
> > fan4:                    0 RPM  (div = 64)
> > 
[ ... ]
> Looks reasonable. There is one problem which I had wondered about - the ALARM 
> which tends to show up for running fans.
> 
> I finally tracked that down. Turns out the chip has a "maximum RPM" register.
> Apparently that register is not set, which causes the alarm.
> 
Actually, I am not sure if I got that right. Can you set the minimum speed of fan2
to something larger than 1110 rpm and check if that causes ALARM to go off ?

I suspect I might have misinterpreted the meaning of "Fan Count Limit". I thought
it is the low limit, but it might well be the high limit.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
