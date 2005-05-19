From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: questions on i2c-isa
Message-Id: <3FF866CF.1010708@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040104165323.4a824f59.khali@linux-fr.org>
In-Reply-To: <20040104165323.4a824f59.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Jean Delvare wrote:
> Hi all,
> 
> Two questions on i2c-isa:
> 
> 1* Why is it that i2cdump does not work with i2c-isa? I understand that
> i2cdetect cannot work (since i2c-isa isn't a real i2c bus) but i2cdump
> does exactly what a chip driver could do if I'm not mistaking.
> 

For all i2c accesses you need an i2c bus address 0x00 - 0x7f.
This concept doesn't work for isa busses.


> 2* Is i2c-isa broken in 2.6? The sensors-detect script says I should use
> i2c-isa + via686a. I load both and have nothing in sensors. It is with
> 2.6.1-rc1. It used to work with 2.4.x + i2c-2.8.x.
>

I reported a while back that via686a sometimes worked and sometimes didn't.
Playing with rmmoding and modprobing the modules (in various combinations,
including i2c-isa and i2c-core), seemed to make a difference, but I couldn't
figure out what made it work or not and never got to the bottom of it.
