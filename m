From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 06 Apr 2007 18:57:56 +0000
Subject: Re: [lm-sensors] asb_100 sensor location in /sys heirarchy changes
Message-Id: <46169C69.1090100@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <4615F494.6070403@hhs.nl>
In-Reply-To: <4615F494.6070403@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

jk wrote:
> Perhaps there is another way of looking at.
> How does the program 'sensors' know what <busnumber>-<busaddress>
> combination to use?
> 

It doesn't the asb100 address is "configured" with this line in 
/etc/sensors.conf: 'chip "asb100-*"'

The * being the address, iow sensors will show any asb100 independent of the 
address.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
