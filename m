From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: [PATCH] i2c driver changes for 2.5.72
Message-Id: <3EFCF10A.3050209@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <10559607053930@kroah.com>
In-Reply-To: <10559607053930@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'll chime in here to agree.
You can't generally think of read_word_data as getting one byte and the next byte.
If a chip supports it at all it may return a "word" (2 bytes)
from a single address (see Winbond chips vendor ID at address 0x4f).
eeproms do it right by doing "autoincrement" to the next byte.
You can use 'i2cdump z 0xzz w' to experiment with
word reads and see how a chip behaves....

Mark M. Hoffman wrote:
> * Philip Pokorny <ppokorny@penguincomputing.com> [2003-06-23 20:57:36 -0700]:
> 
>>Mark M. Hoffman wrote:
>>
>>>* Greg KH <greg@kroah.com> [2003-06-23 16:41:14 -0700]:
> 
> 
>>>>Hm, so I can understand if we need to protect access to the hardware
>>>>when we read two values in a row, like this:
>>>>              res = i2c_smbus_read_byte_data(client, reg) & 0xff ;
>>>>              res |= i2c_smbus_read_byte_data(client, reg+1) << 8 ;
>>>>
>>>>or the same thing when writing.
>>>
>>>
>>>Good point.  The I2C core provides I2C/SMBus locking to prevent trashing
>>>the bus itself, but that doesn't help the above.  Which brings about
>>>another question... why wasn't i2c_smbus_read_word_data() used in that
>>>case?  Philip?
>>
>>I actually tried that, but it didn't work.  My original code had a 
>>#define that would let you try and re-enable it, but I ditched it when I 
>>didn't see any other drivers using read_word variants.
>>
>>I should have spoken up that read_word seemed to be broken at the time.
>>
>>But as I write this, I think I read in the chip data sheet that it 
>>doesn't support SMBus word reads...  (Go figure...)  That was probably 
>>the real reason I pulled the read_word code...
> 
> 
> It's just as well... maybe some bus drivers don't support it either.  It
> doesn't hurt to use lowest common denominator SMBus routines if possible.
> 
> 
