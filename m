From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 11 Feb 2013 12:43:09 +0000
Subject: Re: [lm-sensors] i2c-i801 on AppleTV (1st gen)
Message-Id: <20130211134309.4a4411bb@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.LRH.2.02.1302050844220.2736@pikachu.3ti.be>
In-Reply-To: <alpine.LRH.2.02.1302050844220.2736@pikachu.3ti.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 7 Feb 2013 12:03:10 +0100, Jean Delvare wrote:
> The dump above rules out the DS75 and DS1621. Could be an LM73, but
> then the lm73 driver would have found it. What did you try before
> coming to the conclusion that it "don't seem to do anything"?
> 
> Next thing you can try is:
> 
> # i2cdump -r 0-0x3f 0 0x48 b
> 
> And then as usual:
> 
> # i2cget 0 0x48

Did you try? Did it return anything useful?

There is some risk so I would understand if you don't want to try, but
if you do try, I'm definitely curious to know the outcome.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
