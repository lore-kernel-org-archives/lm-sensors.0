From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Tue, 26 Feb 2008 19:33:13 +0000
Subject: Re: [lm-sensors] First shot at Asus M2N-SLI Deluxe config file
Message-Id: <47C46979.7090307@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.64.0802201829130.30160@birdbird.example.com>
In-Reply-To: <Pine.LNX.4.64.0802201829130.30160@birdbird.example.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Matt Roberds wrote:
> On Tue, 26 Feb 2008, Jordan Crouse wrote:
>> On 21/02/08 08:19 -0600, Matt Roberds wrote:
>>
>>> My second shot is attached.  I have changed the name to inlclude the
>>> "deluxe" designation.  This second shot also requires a small patch to
>>> Jordan Crouse's latest adt7475.c driver to work; a diff is attached as
>>> well.
>> Thanks.  Patch integrated into the driver and I also removed the URL to
>> the datasheet due to the upstream churn.  Full patch is attached.
> 
> Disclaimer: I haven't tried it yet.
> 
> Having said that, in show_voltage(), this patch has
> 
>> case LABEL:
>>  return sprintf(buf, "%s\n",
>>    sattr->index = 0 ? "1" : "2");
> 
> which I think should be
> 
> ---
> case LABEL:
>   return sprintf(buf, "in%s\n",
>     sattr->index = 0 ? "1" : "2");
> ---
> 
> Note the string constant "in".
> 

Ah, good catch.

Actually, the xxx_label attributes should be completely removed, those are only 
meant to be use by drivers which can give an end user presentable labels, other 
drivers should rely on a proper label being set in /etc/sensors.conf

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
