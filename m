From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 28 Oct 2010 15:25:52 +0000
Subject: Re: [lm-sensors] New/undocumented ABI attributes in w83795 driver
Message-Id: <20101028152552.GB4311@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100919163321.GA30847@ericsson.com>
In-Reply-To: <20100919163321.GA30847@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,
On Thu, Oct 28, 2010 at 11:11:38AM -0400, Jean Delvare wrote:

[ ... ]
> 
> As a compromise, I can offer to introduce a temporary configuration
> option, CONFIG_SENSORS_W83795_FANCTRL, which would default to no, with
> a big disclaimer that enabling it isn't encouraged except for
> developers and careful testers. Once this part of the code has been
> properly reviewed and tested, the configuration option can default to
> yes, and finally get dropped.
> 
> Would this be OK with you?
> 
Excellent idea. Go for it.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
