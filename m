From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Mon, 18 Jun 2007 19:55:35 +0000
Subject: Re: [lm-sensors] Is it possible to raise the abituguru voltage test
Message-Id: <4676E337.9020401@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070613121553.17775.qmail@science.horizon.com>
In-Reply-To: <20070613121553.17775.qmail@science.horizon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

linux@horizon.com wrote:
> 
> Okay.  Is it worth asking about the poll-every-10-ms option?  It's a
> fairly minor change, and does speed up initialization.
> 

On your motherboard that may work, but on others I have seen problems trying to 
play clever tricks like this. The firmware in older uguru's is a bit buggy and 
easily rubbed the wrong way. If you really care about the initialisation speed 
use the bank1_types param.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
