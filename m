From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 22 Oct 2010 15:02:41 +0000
Subject: Re: [lm-sensors] [PATCH/RFC] sensors-detect: Add detection of PMBus
Message-Id: <20101022150241.GA31571@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101014154042.GA20794@ericsson.com>
In-Reply-To: <20101014154042.GA20794@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Fri, Oct 22, 2010 at 09:32:31AM -0400, Jean Delvare wrote:

[ ... ]

> 
> Indeed these devices don't seem to fit in our detection scheme, and
> overall seems detection-unfriendly by design. So I wouldn't bother
> adding detection support for them for the time being. Better add kernel
> support first, and see the actual use cases for these devices. Then we
> can discuss the user-spac detection again if needed.
> 
Ok, makes sense. And, besides, someone complaining about non-support
by sensors-detect is a good indicator of chip use ... 

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
