From: mgreer@mvista.com (Mark A. Greer)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: PATCH: lm92: port for 2.6 kernel
Message-Id: <422393D1.6030303@mvista.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <422318E5.4000201@katalix.com>
In-Reply-To: <422318E5.4000201@katalix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

>>Don't the i2c_smbus_[read|write]_word_data() routines pass the u16
>>data in little endian format because that's the endian of the SMbus?
>>    
>>
>
>Not exactly. The bytes arrive LSB first, but the i2c bus drivers then
>convert the word to the endianess of the system. At least they are
>supposed to, those who don't are broken, if any.
>
>  
>
>>Surely if swab16() is used rather than cpu_to_le16(), different values
>>are passed to the xxx_word_data() routines depending on cpu endian?
>>    
>>
>
>No, since the conversion is done by the bus drivers. The only reason why
>swab16 is used is because the chips do not respect the SMBus specs (with
>good reasons, but still...)
>

Uhh oh...  The i2c-mv64xxx.c driver--note that the ctlr is *not* and 
smbus ctlr and only provides one byte at a time to the driver--that I 
wrote simply puts the incoming bytes into the buffer in the order that 
they arrive (and sends them out in the order that they appear in the 
buffer (i.e., as a byte-stream)).  That is wrong?!?!

So, after the read transfer is completed, I should go thru the buffer 
applying le16_to_cpu() to each pair of bytes?  What if there are an odd 
number of bytes?  Also, I guess I should apply cpu_to_le16() to the 
buffer before I send it out?

Mark
