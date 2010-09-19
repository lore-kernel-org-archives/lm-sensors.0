From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 19 Sep 2010 21:34:53 +0000
Subject: Re: [lm-sensors] New/undocumented ABI attributes in w83795 driver
Message-Id: <20100919213453.GA31435@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100919163321.GA30847@ericsson.com>
In-Reply-To: <20100919163321.GA30847@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Sun, Sep 19, 2010 at 03:40:24PM -0400, Jean Delvare wrote:
> Hi Guenter,
> 
> On Sun, 19 Sep 2010 09:33:22 -0700, Guenter Roeck wrote:
> > I had a closer look into the w83795 driver - this time trying to ignore
> > coding style problems ;) - and noticed that there are several attributes
> > which are not defined in the ABI.
> 
> Correct. I've seen them too, but they are not in the part of the driver
> I carefully reviewed and tested yet. I think most (all?) of them are in
> the automatic fan speed control area. The few ones which were in the
> monitoring part of the driver, I have fixed already, hopefully.
> 
Just wondering - does it make sense to push the untested parts of the driver
into the kernel, or would it be better to keep that out until you had a chance 
to test it ? Especially since those parts go beyond monitoring and actually
control something.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
