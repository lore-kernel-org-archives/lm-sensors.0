From: Stian Jordet <liste@jordet.net>
Date: Tue, 02 Oct 2007 20:47:07 +0000
Subject: Re: [lm-sensors] [Openipmi-developer] IPMI and ipmisensors on an
Message-Id: <1191358027.2210.3.camel@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <4701E789.5020103@jordet.net>
In-Reply-To: <4701E789.5020103@jordet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On tir, 2007-10-02 at 14:51 -0500, Corey Minyard wrote:
> There is a big difference between the driver, which just passes messages 
> around mostly, and the sensor handling, which requires interpretation of 
> SDRs and things like that.  The driver should work with a 0.9 system, 
> but the OpenIPMI library will not, for instance.
> 
> I'd be willing to work on this (the driver part), but I'll need access 
> to the system.

That would be truly awesome!

I'll send you the details in a private mail. I have a (small) hope that
if ipmi_si loads, perhaps the ipmisensors module will read the sensors
in human readable way...

Anyway, I hope I'll find out :)

Thanks again, everyone!

-Stian


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
