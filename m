From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 22 Sep 2008 16:41:35 +0000
Subject: Re: [lm-sensors] No Alarm when values not within range
Message-Id: <20080922184135.34223cae@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <5E5D87015BF8A54A93DAD6F808B1129ACB046F@DEEXVS13.wincor-nixdorf.com>
In-Reply-To: <5E5D87015BF8A54A93DAD6F808B1129ACB046F@DEEXVS13.wincor-nixdorf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 22 Sep 2008 18:05:55 +0200, Gerhart, Bjoern wrote:
> > Just thinking about it now:
> > what kernel version are you running? I assumed you were running
> > something recent (2.6.25 or later) but maybe not?
> 
> Ah, this seems to be the missing part. We use Centos 5 with kernel 2.6.18,
> Therefore the missing alarm support is explained.
> 
> Maybe we would try backporting the missing functionality to kernel 2.6.18.
> For our different systems, in sum we use the following kernel modules
> related to lm_sensors:
> 
> * it87 (you already said that this one is affected)
> * pc87360
> * i2c-i801
> * i2c-isa
> * eeprom
> 
> For backporting we'd need to know which kernel modules are affected. My guess
> is, beside of the it87 it's just the pc87360 - am I right?

Yes you are. But what are you trying to do in the first place? If you
are using kernel 2.6.18, then just stick to lm-sensors 2.10.x and
you're done. Nobody is forcing you to upgrade, and lm-sensors 2.10.x is
still maintained as far as security issues and bugs are concerned.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
