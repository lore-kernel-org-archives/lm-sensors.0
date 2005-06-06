From: grant_lkml@dodo.com.au (Grant Coady)
Date: Mon, 06 Jun 2005 10:42:25 +0000
Subject: [lm-sensors] Re: RFC PATCH I2C: w83781d: remove non-i2c sensor
Message-Id: <bt28a155nib3j95eivcmlupj00qo57q7kn@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <bulu915hhnr8oj5orjq2p5i53ublc3b6gu@4ax.com>
In-Reply-To: <bulu915hhnr8oj5orjq2p5i53ublc3b6gu@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 3 Jun 2005 21:46:32 +0200, Jean Delvare <khali@linux-fr.org> wrote:

>Hi Grant,
>
>> This patch removes non-i2c w83697hf, w83627thf sensor chips from the 
>> w83781d driver.  Compile tested.
>> 
>> Also remove references to those sensor chips in w83781d docs.
>
>Great, except for:
>
>> -	}
>> -	
>> +
>
>Please avoid this "noise" change (same holds for all future patches, of
>course).
Fine, I'll wait until your CodingStyle patches go through, as twice now 
I've been told by you to violate CodingStyle.  Understanding yet to dawn 
as to why this is so.

--Grant.

