From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: i2c address probing and AT24RF08 corruption
Message-Id: <40801940.90202@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <1082123259.407fe3fb3d41c@imp.gcu.info>
In-Reply-To: <1082123259.407fe3fb3d41c@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

(A couple comments in line below)

Jean Delvare wrote:

>>>This is exactly a SMBus "quick command" with data bit 1, if I
>>>understood it correctly. This isn't what we do (we do "quick
>>>command" with data bit 0), but that's my second choice if it turns
>>>out that "receive byte" isn't possible as a probing command.
>>>      
>>>
>>I'd prefeare a reading "quick command" over a "receive byte" as we
>>don't actually want read a byte on probing ...
>>    
>>
>
>There is no such thing as a "reading quick command", that's the problem.
>In the SMBus spec, the "quick command" is described as sending a single
>but to the chip (so the R/W but loses its R/W status on this one). So
>you write either 0 or 1, but you write it.
>
>  
>
Correct.  However, it might be seen as the equivelent to an aborted read 
operation, depending on how the client chip treats it.  There are very 
few chips that use a quick read/write for anything practical.  Of those 
that do, I think they are mostly simple switches.

>I think it's absolutely silly from the SMBus folks to have done that,
>since it's against the spirit of I2C (I would even say it makes SMBus
>incompatible with I2C), and dangerous, and useless, but that's how it
>is.
>
>That said, after reading this:
>http://archives.andrew.net.au/lm-sensors/msg01143.html
>I understand that this is not the "quick command" itself corrupting the
>24RF08 but the fact that its state machine is broken and it really sees
>the "quick command 0" as the first byte of a write.
>
>  
>
Exactly.  A 'quick read/write' is the closest thing to sending an 
address, waiting for an ack, and then sending a stop.  As you mention, 
the state machine in the AT24RF08 doesn't respond to the stop in this 
case, so it keeps listening for bytes like those directed to other chips 
and constructs in it's state machine an unintended data-byte-write (or 
something similar).

>I wish I had read that before sending my proposal to everyone, but hey
>that's how life goes.
>
>Anyway, what you say here, and the facts on the 24RF08, confirm my
>impression that a quick write 1 would be less dangerous than a quick
>write 0. OTOH I am told that the former is likely to make some chips
>lock the bus. So we're not only fighting against the 24RF08's broken
>state machine, but also with some other chips (don't even have the
>complete list). Damn, I hate it when broken hardware forces us to write
>broken software to workaround :(
>
>  
>
Unfortunately, probing and detection is something we have just sort of 
'made up' since there is nothing nice and defined in the way we can see 
what's on a bus.  It would be great to have some table like PCI does to 
see the vendor id, device id, etc.  But I2C/SMBus is, by design, is much 
simplier than that.


Phil
