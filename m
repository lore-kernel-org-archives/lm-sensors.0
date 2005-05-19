From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: [PATCH 2.6] more i2c bus drivers (2/2)
Message-Id: <3FD8DD0C.9080709@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031205222400.1b7ff3a6.khali@linux-fr.org>
In-Reply-To: <20031205222400.1b7ff3a6.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I only count 31 letters...

[ppokorny@vaio ppokorny]$ echo SMBus AMD756 compatible adapter | wc
      1       4      32

 (+1 for the newline)

If you want something shorter, what about "type", "compat", or "style" 
instead of "compatible"

Or leave "compatible" out entirely...

Or go with 7xx.

It's just cosmetic, and I was only trying to improve understanding.  If 
it doesn't fit, then it doesn't fit.

:v)

Jean Delvare wrote:

>>Rather than saying 7xx in the names what about changing:
>>
>>    SMBus AMD7xx adapter
>>to
>>    SMBus AMD756 compatible adapter
>>    
>>
>
>39 bytes, while we are limited to 31. Another suggestion? Maybe we can
>say AMD756 and just forget about the "compatible".
>
>  
>

