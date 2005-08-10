From: david.vanhoose@comcast.net (David van Hoose)
Date: Wed, 10 Aug 2005 00:03:50 +0000
Subject: [lm-sensors] [PATCH 2.6] I2C: Rewrite i2c_probe
Message-Id: <42F927E6.3020804@comcast.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050809201755.15962b81.khali@linux-fr.org>
In-Reply-To: <20050809201755.15962b81.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Sounds like a good point to me. I'll submit patches for any code that 
could semantically use the defines.
Why or why should we not use enums instead of ints? Personally, I find 
enums are better for type checking, and I find that "command none" or 
"flags none" is more natural as it is very explicit. It is really a 
matter of convention though as it doesn't affect the running any. 
However, it is possible that it could uncover and possibly prevent 
obscure typo related bugs.
Thoughts?

Regards,
David

Jean Delvare wrote:
> Hi David,
> 
> 
>>From places like below (a snippet from your patch). You use 0 instead
>>of preprocessor tokens. It is also this way in various other places
>>in the i2c core code.
>>
>>// Snippet of i2c_probe_addresses
>>+	/* Make sure there is something at this address, unless forced */
>>+	if (kind < 0
>>+	 && i2c_smbus_xfer(adapter, addr, 0, 0, 0, I2C_SMBUS_QUICK, NULL) < 0)
>>+		return 0;
>>// Snippet end
> 
> 
> As far as I can see only one "0" (the middle one) has a replacement
> preprocessor token (I2C_SMBUS_WRITE), right? I don't think we have
> preprocessor token for "no flags" nor "command doesn't matter", and I
> don't think we should introduce them, as 0 is just as natural in this
> case.
> 
> I think that I2C_SMBUS_WRITE is not used here on purpose, because there
> is not such thing as a quick read command in the SMBus protocol. The
> quick command is always a write, sending a single bit of data to the
> target chip. This is a *very* weird choice from Intel if you want my
> opinion, but that's the way SMBus was designed. I'd expect that you will
> find 0 or 1 instead of I2C_SMBUS_WRITE or I2C_SMBUS_READ, respectively,
> only when I2C_SMBUS_QUICK is used. If this is the case, that's not
> something we want to change, as it makes some sense with regards to the
> SMBus protocol.
> 
> Now, if there are non-quick commands not using I2C_SMBUS_WRITE/READ when
> they should, please point them out to us.
> 
> Thanks,

