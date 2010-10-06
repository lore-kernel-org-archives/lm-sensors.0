From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 06 Oct 2010 21:02:26 +0000
Subject: Re: [lm-sensors] local macro
Message-Id: <1286398946.9690.100.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTi=t1ObqqZiamKdZGHxrWc6FEP-QqSxrsbordDTi@mail.gmail.com>
In-Reply-To: <AANLkTi=t1ObqqZiamKdZGHxrWc6FEP-QqSxrsbordDTi@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2010-10-06 at 15:54 -0400, Paul Thomas wrote:
> > No, both of those are runtime options internal to the ads7871, and
> > because we initiate a read by setting that register anyway there isn't
> > any additional setup cost (at least there isn't any spi cost, there is
> > a little additional code in show_voltage).
> >
This isn't a matter of cost, but a matter of maintaining a consistent
ABI.

A brief look into the datasheet shows that the chip is a generic adc. So
I assume its use is not limited to voltage monitoring, and that you
would in fact expect to change the gain during runtime (ie not only at
system startup). Is this a correct assumption ?

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
