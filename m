From: Holger.Kiehl@dwd.de (Holger Kiehl)
Date: Wed, 07 Feb 2007 13:00:04 +0000
Subject: [lm-sensors] LM85 problems with 2.6.16.x - 2.6.19.1
Message-Id: <Pine.LNX.4.64.0702071240350.19125@diagnostix.dwd.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.64.0702051500420.28290@diagnostix.dwd.de>
In-Reply-To: <Pine.LNX.4.64.0702051500420.28290@diagnostix.dwd.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Jean

On Tue, 6 Feb 2007, Jean Delvare wrote:

> Hi Holger,
>
> On Mon, 5 Feb 2007 15:09:03 +0000 (GMT), Holger Kiehl wrote:
>> Hello
>>
>> I am using a Tyan S4882 motherboard with 4 CPU's that has a LM85 sensor chip
>> which reports the following message during boot:
>
> Which revision of the S4882 is it?
>
I was unable to locate that. Looked for a long time and I found only one
number right in the corner that says 0400Y, but I don't know if that is the
revision.

>>
>>      .
>>      .
>>      ipmi device interface
>>      Enabling SMBus multiplexing for Tyan S4882
>
> It looks like you are using both IPMI and regular SMBus at the same
> time. I am not an IPMI expert but I suspect it could be the reason of
> your problems. What do you use IPMI for? Can you try without it?
>
Yes, that was it. Just unloading the modules did not work. I had to remove
the IPMI card and now I no longer get those SMBus collision messages and
the message about lm85 being locked and not ready no longer shows up.

I used IPMI to read the log about any system events, like reset button
being pressed, etc. But I found those IPMI cards did not write much
into the log that was of use for me, so it is okay for me to just
remove them. Another reason was that I at first did not know about
the W83627HF watchdog and I wanted to use the one on the IPMI card.
But that did not work, it did not reset my system. I then found the
W83627HF and that worked for me.

>>      lm85 0-002e: Client (0,0x2e) config is locked.
>>      lm85 0-002e: Client (0,0x2e) is not ready.
>>      lm85 0-002e: Client (0,0x2e) VxI mode is set. Please report this to the lm85 maintainer.
>>
>> Looking at /var/log/messages I also can see multiple entries of:
>>
>>      i2c_adapter i2c-0: SMBus collision!
>>           OR
>>      i2c_adapter i2c-1: SMBus collision!
>>           OR
>>      i2c_adapter i2c-2: SMBus collision!
>>            OR
>>      i2c_adapter i2c-3: SMBus collision!
>>            OR
>>      i2c_adapter i2c-4: SMBus collision!
>>
>> This happens with lm_sensors 2.9.2 and 2.10.1 and plain kernel.org kernels
>> 2.6.16.x to 2.6.19.1.
>
> Do these "SMBus collision" messages go away if you stop loading the
> i2c-amd756-s4882 driver?
>
I did not try this since removing the IPMI card solved it.

Many thanks for your help!

Regards,
Holger


