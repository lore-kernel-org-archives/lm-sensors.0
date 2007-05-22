From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Tue, 22 May 2007 18:03:12 +0000
Subject: Re: [lm-sensors] THMC50 review
Message-Id: <4654832B.4060405@wp.pl>
List-Id: <lm-sensors.vger.kernel.org>
References: <web-67221254@hhs.nl>
In-Reply-To: <web-67221254@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Mon, 21 May 2007 21:49:26 +0200, Goede, J.W.R. de wrote:
>> Actually keeping a queue that can be used with people which
>> have time to review sounds like a plan. I think we should
>> create a page for this at the trac wiki. Mark AFAIK you've
>> been collecting reviews, can you create such a page. (I can
>> do it myself but I don't have a list of everything that
>> needs reviewing).
> 
> This certainly doesn't prevent you from creating such a page. If the
> list is incomplete, it can be completed later, by Mark or others.
> 

The great thing would be to mark who is going to review the driver (after it is decided), so a contributor of the patch can see how far in the queue the driver is.

> Note that I am already trying to maintain
> http://www.lm-sensors.org/wiki/Devices
> with this information. If you search for "review" on this page, you
> should find most drivers waiting for a review, with a link to the
> latest version that was posted.

The information about the ADM1022 is not accurate. I have not tested the 2.4 kernel, but the thmc50 driver do not handle the adm1022 mode. It means that it works if the adm1022 is working as the pure thmc50 (which is default). This is not true for my motherboard. The adm1022 works in an extended mode (two external temperatures) and the 2.4 I used to create the 2.6 patch did not handle this. The result of incorrect mode wss the fan forced to full speed.

I may fix it.

Regards,
Krzysztof

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
