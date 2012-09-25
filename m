From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 25 Sep 2012 13:42:51 +0000
Subject: Re: [lm-sensors] About the INA2xx in linux
Message-Id: <20120925134251.GA10906@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <D07C73A334FF604B95B3CBD2A545D07B07A2C0FE@039-SN2MPN1-012.039d.mgd.msft.net>
In-Reply-To: <D07C73A334FF604B95B3CBD2A545D07B07A2C0FE@039-SN2MPN1-012.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Sep 25, 2012 at 06:58:17AM +0000, Tang Yuantian-B29983 wrote:
> Hello,
> I am currently using the driver of INA2xx you wrote in linux.
> Could you enlighten me how to set the shunt value via platform data?
> 
> If anyone else know how to do it, please also tell me.
> Thanks in advance.
> 
> Regards,
> Yuantian
> 
Hi,

Documentation/i2c/instantiating-devices gives you some examples.
Method 1 or 2 apply to your use case.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
