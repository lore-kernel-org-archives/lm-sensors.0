From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Thu, 27 Sep 2007 11:56:08 +0000
Subject: Re: [lm-sensors] i2c-i801 Interrupt Support
Message-Id: <46FB9A58.1060105@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <46FA2C8B.2060302@gmail.com>
In-Reply-To: <46FA2C8B.2060302@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Ivo,
> 
> On Wed, 26 Sep 2007 11:55:23 +0200, Ivo Manca wrote:
>> Hey Mark,
>>
>> We're three students from the TH-Rijswijk following a embedded software 
>> college (under supervision of Hans de Goede), trying to add Interrupt 
>> Handling support to the current i2c i801 bus driver. After looking for 
>> more information, we've found a message coming from you at Sunday 28 
>> November 2004 concerning a complete rewrite of the i2c-i801 for 2.6.x 
>> (http://archives.andrew.net.au/lm-sensors/msg28496.html)
>> This patch added interrupt handling support the the driver.
>>
>> However, this code does not seem to be present anymore.
>>
>> How come this code is no more?
>> We're unable to find any concrete information.
> 
> Well, the post above contains the rewritten driver in question, what
> else do you need?
> 
> I am very interested in having an interrupt-driven i2c-i801 driver. If
> you come up with something, I will be very happy to test it on my
> various Intel-based systems. I have one ICH3M, two ICH5 and one
> ICH7-based systems available for testing.
> 

The question is why wasn't the above code ever merged into the mainline? If you 
read the thread you will find various comments about it causing problems on 
varioussystems, triggering SMI interrupts and other nastiness there.

Regards,

Hans



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
