From: Ankit Chaturvedi <ankit.chaturvedi@gmail.com>
Date: Wed, 11 Apr 2007 15:46:59 +0000
Subject: Re: [lm-sensors] w83627ehf reporting ghost fan?
Message-Id: <461D0023.4000900@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <461C3562.2070006@gmail.com>
In-Reply-To: <461C3562.2070006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Jean Delvare wrote:
---snip
> 
> This isn't an issue, it works as designed. The ignore statement in your
> configuration file is a user-space thing, the driver doesn't know about
> it. The driver attempts to get a valid reading from the fan input,
> until the clock divider hits the max (128), it cannot differentiate
> between a very slow fan and no fan at all.

 Thanks for bringing this to light.
> 
> BTW, you get these messages in your logs because you asked for them.
> These are debugging messages, normally not printed.

 True. I enabled debug to get my CPU fan sensor to get the correct
divisor. On my earlier Mandriva(kernel 2.6.17-mdv) setup, it always set
the divisor to 4 and my monitors would go berserk. Back then I changed
the sensors.conf to correct that but this time (with kernel 2.6.19) it
just worked so I got interested.
> 
> Thanks for testing and reporting, I'll push the patch upstream.
> 

Great.

Regards,
Ankit Chaturvedi

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
