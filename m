From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: ALi1563
Message-Id: <405AF7F5.5000800@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <000001c407ce$1bcddc30$1e01a8c0@BruceV505B>
In-Reply-To: <000001c407ce$1bcddc30$1e01a8c0@BruceV505B>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I wrote the 15x3 driver and the 1535 driver started as a copy of the 15x3,
so it doesn't much matter, which ever one looks closer to what you need.
The 1535 authors aren't on the mailing list and haven't heard from them in quite a while.
Let me know if you need any help.
mds

Jean Delvare wrote:
>>I am looking into this and I might need some help.  Which driver do
>>you think would be a better starting point for the M1563: the
>>i2c-ali15x3 or i2c-ali1535?
> 
> 
> How could I tell without the M1563 datasheet?
> 
> 
>>Also -- I can't provide the data sheets since I have received them
>>under NDA.
> 
> 
> So you're basically on your own :/ Not that we won't help but it'll be
> obviously harder.
> 
> Anyway, help requests should be directed to the i2c-ali15x3 or
> i2c-ali1535 driver authors. I did not write them and have almost no
> experience with SMBus drivers, so I wouldn't be able to help you much.
> 
