From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:14 +0000
Subject: LM83 test results
Message-Id: <3F495702.3080206@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030806122107.6d678b30.khali@linux-fr.org>
In-Reply-To: <20030806122107.6d678b30.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Jean Delvare wrote:
..
> 
>># dump/i2cdump 0 0x19 b
>>     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f   
>>00: 24 26 00 00 00 50 50 64 64 64 64 64 64 64 64 64   
>>10: 64 64 64 64 64 64 64 64 64 64 64 64 64 64 64 64  
>>20: 64 64 64 64 64 64 64 64 64 64 64 64 64 64 64 64   
>>30: 21 22 22 22 22 00 00 00 5a 5a 6e 6e 6e 6e 6e 6e  
>>40: 6e 6e 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f   
>>50: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f  
>>60: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f   
>>70: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f  
>>80: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f   
>>90: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f  
>>a0: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f   
>>b0: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 
>>c0: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f   
>>d0: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f  
>>e0: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f   
>>f0: 00 85 18 35 26 26 26 00 38 25 24 24 24 24 01 03  
> 
> 
> That's very interesting. See how the limits appear not only in one, but
> many registers. I had never seen this behavior. Could be used for
> detection purpose (although we already have a reliable detection
> mechanism now, thanks to you).

what you're seeing is a relatively common behavior where,
when you read an invalid location, it returns the
value from the last valid read.
So it depends on the order you read things.
I would be wary of using this for detection purposes.
