From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 28 Feb 2012 21:01:53 +0000
Subject: Re: [lm-sensors] Chip Addition: ITE IT8783F
Message-Id: <1330462913.23014.229.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <B9D3C48C98930741A166756A50C44A611FF696B3@helx1.corp.vaisala.com>
In-Reply-To: <B9D3C48C98930741A166756A50C44A611FF696B3@helx1.corp.vaisala.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2012-02-28 at 13:53 -0500, kevin wrote:
> <jukka.hynninen <at> vaisala.com> writes:
> 
> > 
> > Anyone interested in adding support for this? I'd be glad to assist on
> > further evaluation and testing.
> >
> 
> BCM motherboards have this sensor and would be nice to have support.
> http://www.bcmcom.com/bcm_product_mx57qm.htm
> 
> Is there any code at all to compile this driver manually?

You can try to force-load the it87 driver. ITE datasheets are difficult
if not impossible to get, so it is unlikely that we will be able to add
support for the chip.

I added your request to the "supported devices" list on lm-sensors.org.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
