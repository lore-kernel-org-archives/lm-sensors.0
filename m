From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 08 Feb 2011 03:52:56 +0000
Subject: Re: [lm-sensors] Intel BOXDH57DD driver?
Message-Id: <20110208035256.GA11312@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTimuGHXHLovH57zR3tC3v1Gf7gyPgr10Zoc7i-kR@mail.gmail.com>
In-Reply-To: <AANLkTimuGHXHLovH57zR3tC3v1Gf7gyPgr10Zoc7i-kR@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Feb 07, 2011 at 10:08:42PM -0500, Jeff Sadowski wrote:
[ ... ]
> 
> Driver `to-be-written':
>  * ISA bus, address 0x680
>    Chip `Nuvoton W83677HG-I Super IO Sensors' (confidence: 9)
> 
[ ... ]
> 
Good timing, as I finished the first version of this driver last weekend.

Please try the standalone driver at http://www.roeck-us.net/linux/drivers/w83627ehf/ 
and let me know if you have any issues.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
