From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 05 Jun 2012 20:33:48 +0000
Subject: Re: [lm-sensors] System: "Point of View ION-MB330-1" produces wrong values with lm-sensors 3.3.2
Message-Id: <1338928428.478.247.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAOB5NSGJmSkyng5C4YDACgcKAAAAQAAAARsa0Leonh0i8VcwkGa2IBgEAAAAA@casema.nl>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAOB5NSGJmSkyng5C4YDACgcKAAAAQAAAARsa0Leonh0i8VcwkGa2IBgEAAAAA@casema.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2012-06-05 at 15:10 -0400, Ger vermeulen wrote:

[ ... ]

> 
> The workaround you suggested to change the tjmax is not possible for my
> coretemp.ko unknown symbol.
> 
Not sure I understand. What command do you execute, and what exactly is
the output ?

> So a work around can be adding to /etc/sensors3.conf
> 
> chip "coretemp-isa-0000"
>      label temp1 "Core0"
>      compute temp1 @+35,@-35
> 
> chip "coretemp-isa-0001"
>      label temp1 "Core1"
>      compute temp1 @+35,@-35
> 
> Is this correct?
> 
It shows you the correct temperature. So, yes, it is one way to solve
the problem. Do you really need the "label" line ?

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
