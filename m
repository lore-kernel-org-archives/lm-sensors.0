From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 31 Oct 2011 15:58:02 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] hwmon: (w83627ehf) Clean up probe
Message-Id: <1320076682.18747.16.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20111031152004.28e9f7b8@endymion.delvare>
In-Reply-To: <20111031152004.28e9f7b8@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2011-10-31 at 11:53 -0400, Ian Pilcher wrote:
> On 10/31/2011 10:22 AM, Guenter Roeck wrote:
> > No thoughts so far. Might be an option, but I am not sure if/when I
> > would have time to work on it. And I would have to get a board with
> > NCT6776 on it. If there are any with SandyBridge CPU, I might actually
> > get one ;).
> 
> Can it be a NCT6775?  The Intel DQ67SW has one.
> 
I already have a board with NCT6775F. If I end up writing a separate
driver, I would want to be able to test with/for all chips it supports.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
