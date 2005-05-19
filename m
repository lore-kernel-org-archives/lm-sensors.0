From: fdavis@si.rr.com (Frank Davis)
Date: Thu, 19 May 2005 06:23:35 +0000
Subject: [PATCH] 2.5.21: i2c conversion for drivers/media/video/saa7110.c
Message-Id: <3D147B0F.5000502@si.rr.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3D13EB35.153C1689@paradyne.com>
In-Reply-To: <3D13EB35.153C1689@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark,
    Dave Jones added my patch to his latest 2.5.2X-djK patches. If 
things go well with users using his kernel, then I don't mind writing a 
porting guide. I going to give it a while for bugs to present 
themselves. If I don't here any negative feedback in the short term, 
I'll convert the remaining drivers using the old i2c API.

Regards,
Frank

Mark D. Studebaker wrote:
> did your patch work in testing?
> Would you consider writing a porting guide from i2c-old to i2c for
> others?
> 
> Frank Davis wrote:
> 
>>Hello all,
>>   Here's what I propose as a complete conversion from the old i2c-old
>>interface to the current one (against 2.5.21). I used
>>drivers/media/video/saa5249.c as a basis for the conversion, as well as
>>reviewing the i2c documentation. Let me know what you think.
>>Regards,
>>Frank
>>
> 
> 

