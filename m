From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 09 Sep 2005 16:54:34 +0000
Subject: [lm-sensors] Patch: Kernel 2.6 and multiple buses
Message-Id: <5e2oeclP.1126277180.0438030.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <43215B5F.7050100@megware.com>
In-Reply-To: <43215B5F.7050100@megware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Karsten,

On 2005-09-09, Karsten Petersen wrote:

> My main problem is easily describable as:  Although there was a good 
> looking sensors.conf, its options were not used with all chips.  Those 
> chips with chip-lines like "bla-*" were ok, but those with lines like 
> "bla-i2c-3-*" just showed default labels.

Yes, this is a known problem with Linus 2.6.

> One first problem was, that the "bus" line in sensors.conf needs to have 
> another value than when running kernel 2.4 on the same machine.
> With kernel 2.4 its like this:
>    bus "i2c-4" "SMBus 8111 adapter (CPU3)" "Non-I2C SMBus adapter"
> But with kernel 2.6, it must be like this:
>    bus "i2c-4" "SMBus 8111 adapter (CPU3)" "Unavailable from sysfs"
> It seems to me, that the third argument is redundant these days, so it 
> could probably be dropped or made optional.  It took me some time to 
> find out about this problem, because the comparison in lib/data.c:233 is 
> not helpful at all.  :-/

Correct, that explains a part of the problem. Thanks for pointing it out.
We should probably drop the algorithm test completely (and make it
optional in the configuration file as you suggested, but I don't know
how do to this myself.) That algorithm name was given way too much
importance in the early days of lm_sensors, I believe it should never
have been handled by libsensors in the first place. Algorithms are
implementation details users don't care about.

> But this did not solve my problem, more sensor chips showed usefull 
> labels but not all.  After a lot of printf debugging it became clear, 
> that the sensors_substitute_chip function in lib/data.c assigns wrong 
> bus numbers to the configured chips.  This is because the busses in the 
> sensors_config_busses array are _not_ sorted, so 
> sensors_config_busses[j] does not need to be the bus with id "j".  But 
> the function thinks, that this is the case.  It probably was with kernel 
> 2.4, but not with the kernel 2.6.9 (+lot of patches) I am running.
> The attached patch corrects this behavior, it uses the bus id from the 
> entry sensors_config_busses[j] instead of "j".

Thanks a lot for this patch. I had been investigating this bug some times
ago but could never figure out what the problem was. It's really great
that you did succeed in finding the reason. I know it'll make a few
other users happy too.

Thanks again,
--
Jean Delvare
