From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: piix4 fails to reset? (ticket #1078)
Message-Id: <3E0E5F27.1050000@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1040328325.1738.165.camel@albatross.yyz.somanetworks.com>
In-Reply-To: <1040328325.1738.165.camel@albatross.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Joe Drew wrote:
> On Fri, 2002-12-20 at 10:09, Joe Drew wrote:
> 
>>On Thu, 2002-12-19 at 16:31, Philip Edelbrock wrote:
>>
>>>Humm, I don't suppose you can connect a scope to SDA and SCL to see what 
>>>is happening?  It sounds like a hardware flaw. :'(
>>
>>Actually, this could be possible. But - SDA looks like part of the IDE
>>interface?
> 
> 
> Never mind, I see them on the DIMM connector. Problem is, they're not
> very accessable, even when I have a board out here on my desk. From
> within the racks it'll be impossible, I'm afraid.
> 
> Even so, the second question still stands:
> 
> 
>>As well, what *should* these lines show on the scope?
> 
> 
> 

SDA and SCL should both be high when the bus is idle.
