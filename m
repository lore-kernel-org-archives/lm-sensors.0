From: mds@mds.gotdns.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: RFC parameter based voltage scaling
Message-Id: <42821576.5050208@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <rl8u711rq5bc1e1jtt91s76fed180ctoav@4ax.com>
In-Reply-To: <rl8u711rq5bc1e1jtt91s76fed180ctoav@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Grant Coady wrote:
> Hi Khali,
> On Tue, 10 May 2005 14:35:31 +0200 (CEST), "Jean Delvare" <khali@linux-fr.org> wrote:
> 
> 
>>Hi Grant,
>>

> 
> Future resistor values come in E96 series which is a noisy calculation, 
> the other option is resnet's where you might get 10/20 ratio or 10/30 
> ratio which is also covered in E24 series.  
> 
> I've already demonstrated that E24 resistor ratios are below the basic 
> error of the sensor chip.  E24 series over two decades gives ratios to 
> much better than 1/2%, point 2: is that mobo makers are likely to use 
> cheap 5% resistors, 
> 

Maybe, maybe not... IIRC 1% 0603 resistors are about $20.00 for a reel
of 5000, where I used to work we used only 1% to minimize inventory,
of course we weren't in Taiwan. But using 5% resistors in front of
a sensor is just bad design. The Winbond datasheets  I've looked at
have 1% resistors in the schematics. What's the basis for
your 5% assumption?


> Sort of, datasheets can be poorly expressed, poorly understood when 
> one doesn't have the hardware, sure.  The errors I'm finding are way 
> beyond that.  You're trying to tell a former electronics design 
> engineer who was working with 50000 count A/D converters 20 years 
> ago how to read datasheets and where error terms come from?  
> 

You aren't the only EE around here, please don't give us a bad name by being
snippy.

mds
