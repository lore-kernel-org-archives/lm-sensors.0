From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 20 Oct 2009 11:57:47 +0000
Subject: Re: [lm-sensors] Gigabyte GA-P35-DS3P - VID Zero value
Message-Id: <20091020135747.5f918b3a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091019164516.701032uxlen5ai2k@mail.simonandkate.net>
In-Reply-To: <20091019164516.701032uxlen5ai2k@mail.simonandkate.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 20 Oct 2009 21:23:09 +1000, Simon Wilson wrote:
> Interpreting the isadump is way over my head, so it looks like we're  
> on a hiding to nowhere here unless someone can assist us with that and  
> investigating hwmon-vid.

See my reply to your original post.

> What is interesting is that there is obviously a value being obtained  
> from the motherboard - otherwise setting VRM to 100 (10.0) would also  
> produce 0.000 V.

This is an incorrect assumption. VID decoding is tricky and you really
cannot assume anything like that. Only the raw VID value holds the
truth.

> But the calculation that it is running when the value  
> is 110 (11.0) is resulting in a 0 value. So somehow, the formulae and  
> cals in the VRM translation is screwy when hwmon (correctly) detects  
> my Conroe and sets it to 11.0.

Your register dump makes it pretty clear that there is no VID value to
be read in the first place. At least not from the VID value register
0xfc).

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
