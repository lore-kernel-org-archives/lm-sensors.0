From: RaphaelD@tyan.com (Raphael Deng)
Date: Tue, 16 May 2006 23:15:54 +0000
Subject: =?GB2312?B?tPC4tDogW2xtLXNlbnNvcnNdIGxhdGVzdCBmaW5kaW5ncyAtIG15?=
Message-Id: <3174569B9743D511922F00A0C94314230F89570D@TYANWEB>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

Actually our AMD contact person is in vacation. I wonder you have to wait
for some while.

Raphael Deng

-----????-----
???: Rudolf Marek [mailto:r.marek at sh.cvut.cz] 
????: 2006?5?16? 13:53
???: Dieter Jurzitza
??: lm-sensors at lm-sensors.org; Raphael Deng
??: Re: [lm-sensors] latest findings - my older posting from ~ 11 days ago
/ Tyan Tiger MoBo 2460

Hi all,

> Hi folks,
> dear Rudolf,
> I think I've solved the issue. As it is a very "heuristic" approach I can
only 
> tell what I did and you can give me a commentary on it saying it makes no 
> sense this way or whatsoever ...
> 
> Nevertheless, I keep crash-looped now doing 
> 
> while true; do
> 	i2cdump -y 0 0x2d b > /dev/null
> done
> 
> for more than 105000 times (the best value I had had reached before was
around 
> 20000, and only with debugging turned on) so I think it is fair to say
things 
> have improved significantly at least.
> 
> I readily mentioned that I had had the impression that things were less 
> problematic with debugging turned on. Now, what does debugging do? It does

> many printk's or printf's thereby making the process slower.
> 
> Rudolf pointed me to the file in charge: i2c-amd756.c. I simply added a
single 
> msleep(1);

Good.

> 
> /usr/src/linux/drivers/i2c/busses/i2c-amd756.c (referring to linux-2.6.11.
4):
> 
> static int amd756_transaction(struct i2c_adapter *adap)
> {
>         int temp;
>         int result = 0;
>         int timeout = 0;
> 
>         dev_dbg(&adap->dev, "Transaction (pre): GS=%04x, GE=%04x,
ADD=%04x, "
>                 "DAT=%04x\n", inw_p(SMB_GLOBAL_STATUS),
>                 inw_p(SMB_GLOBAL_ENABLE), inw_p(SMB_HOST_ADDRESS),
>                 inb_p(SMB_HOST_DATA));  
> 
>         /* Make sure the SMBus host is ready to start transmitting */
>         /* but always wait one millisecond just in case ... */
>>>      msleep(1); <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<  Here!
>         if ((temp = inw_p(SMB_GLOBAL_STATUS)) & (GS_HST_STS | GS_SMB_STS))
{
> 
> and, until now, this seems to do the trick (knock on wood!!!). Tell me why

> this cannot happen - as a matter of fact it seems to work. The explanation
is 
> up to you, folks ;-).

I'm still waiting for Raphael to contact someone at AMD, that was the reason
for 
the quiet in this case...

This is "sleep" is good idea, there must be something wrong with the
controller, 
  as we already know ...

Explanation hmm :) hard to tell...

I checked the sequence of command and nothing really strange...

Have you some crash even with this delay?

Thanks
Regards
Rudolf

