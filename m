From: mgreer@mvista.com (Mark A. Greer)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: PATCH: lm92: port for 2.6 kernel
Message-Id: <42239E43.1080707@mvista.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <422318E5.4000201@katalix.com>
In-Reply-To: <422318E5.4000201@katalix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

>Hi Mark,
>
>  
>
>>Uhh oh...  The i2c-mv64xxx.c driver--note that the ctlr is *not* and 
>>smbus ctlr and only provides one byte at a time to the driver--that I 
>>wrote simply puts the incoming bytes into the buffer in the order
>>that they arrive (and sends them out in the order that they appear in
>>the buffer (i.e., as a byte-stream)).  That is wrong?!?!
>>    
>>
>
>No, it's all OK. Don't worry :)
>

Whew!
/me's heart rate drops below 200 bpm.  :)

>>So, after the read transfer is completed, I should go thru the buffer 
>>applying le16_to_cpu() to each pair of bytes? What if there are an
>>odd  number of bytes?  Also, I guess I should apply cpu_to_le16() to
>>the  buffer before I send it out?
>>    
>>
>
>No. The byte swapping thing only makes sense for word transfers anyway,
>as defined by the SMBus specification. In you case, your driver provides
>low control (byte-level and flags) control over the bus, if I read
>correctly.
>

You do.

> You do not implement SMBus functions individually. The
>i2c-core takes care of it for you, through an smbus-over-i2c-emulation
>function (i2c_smbus_xfer_emulated). Look at the function and you'll see
>this:
>
>    case I2C_SMBUS_WORD_DATA:
>    (...)
>        data->word = msgbuf1[0] | (msgbuf1[1] << 8);
>        break;
>

Ah, missed that part during my panic search of the emulated stuff.

>
>So as you see it'll work regardless of the endianess (although not
>necessarily in the most efficient way).
>
>No need to worry, really, your code is alright as far as I can see :)
>

Thanks Jean.  I can go back to sleep now.  ;)

Mark
