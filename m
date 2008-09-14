From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 14 Sep 2008 06:43:32 +0000
Subject: Re: [lm-sensors] New Asus board and multiple sensors
Message-Id: <48CCB294.907@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Marco Chiappero wrote:
> Jean Delvare ha scritto:
>> Loading random drivers isn't going to help. The two interesting
>> things are:
>>
>> * What does sensors-detect see? Unidentified chips on the SMBus at
>>   addresses typically used by monitoring chips (0x2c-0x2f or
>>   0x48-0x4f)? Or nothing at all? If unidentified chips are seen then
>>   we need the output of i2cdump for these chips to find out what
>>   they are.
> 
> I attached the sensors-detect output, but I have never used i2cdump 
> before, so I don't know exactly which parameters I should pass to it. 
> Any help appreciated.
> 
>> * What makes you think there are "two other sensor chips" on the
>>   board? Can you see them physically on the board?
> 
> A little search through the web. Let me explain. This board I own (Asus
> Maximus II Formula) it's essentially a refreshment of the previous
> Maximus Formula / Rampage Formula motherboard (which are exactly the
> same board with different northbridge chip) and both share the same
> temperature & voltage readings, fan and optional sensors headers. So I
> think we can assume the hwmon section it's almost the same.
> Unfortunately the only chip clearly visible is the Winbond W83667HG also
> because the board comes with a wide heatsink that may cover some chips
> (as it is for the ICS clock generator, half visible). As soon as I can
> I'll try to get a closer look. However I've found these informations
> about those "older" models:
> 
> - Sensor Type W83627DHG + W83791D + ADT7475 + ADP3228 (ISA 290h, SMB
> 2Ch/2Eh/20h)
> 

When manufacturers change a board chances are high they will change more then 
just the northbridge. That seems to be the case here, as the smbus probe for 
your board shows no sensors IC's attached.

I have an asus M8N-SLI Deluxe which has an adt7475 and sensors-detect detects 
that just fine, so either you don't have an adt7475, or Asus has multiplexed 
the smbus, hiding the sensors in that way.

If you really want to know how the additional headers are hooked up you will 
need to go and look for hwmon IC's, and yes that means you might need to take 
the cooler of the motherboard. Are they actually all monitored, maybe some of 
them will drive a fan but do not monitor it? How many fans does windows allow 
you to monitor?.

Refards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
