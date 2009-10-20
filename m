From: Simon Wilson <simon@simonandkate.net>
Date: Tue, 20 Oct 2009 11:23:09 +0000
Subject: Re: [lm-sensors] Gigabyte GA-P35-DS3P - VID Zero value
Message-Id: <20091020212309.1843734dy9dfdkt9@mail.simonandkate.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091019164516.701032uxlen5ai2k@mail.simonandkate.net>
In-Reply-To: <20091019164516.701032uxlen5ai2k@mail.simonandkate.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Adam Nielsen <a.nielsen@shikadi.net>:


> All the hwmon-vid driver seems to do is ask the driver for the raw vid value
> and run it through a formula.  It doesn't actually have anything to do with
> hardware at all (other than detecting the CPU brand and model.)
>
> Quite possibly, but if you download the latest Linux kernel, compile and boot
> that, and try again you'll know for sure whether code exists to handle it or
> not.  Given the number of quirks motherboard sensors seem to have, I suspect
> this issue is just another quirk that needs to be added to the it87 driver.
>
> The next step is to probably get some raw vid values off the it87 chip to see
> what they look like - if those are all zero then we know the lines aren't
> connected, but if there are some values there it should in theory be possible
> to map them to vid voltages.  I guess this is where that isadump output you
> posted comes in...
>
> It's a shame there's no "passthrough" vrm version that disables the formula
> and shows the raw vid value, as that would probably be quite helpful.  Maybe
> it's worth adding a patch to do just that?
>
> Cheers,
> Adam.
>
>

Phil from elrepo assures me that the kmod-it87 driver has all the  
latest patches backported, so it's not that.

Interpreting the isadump is way over my head, so it looks like we're  
on a hiding to nowhere here unless someone can assist us with that and  
investigating hwmon-vid.

I won't be doing a kernel upgrade - this is a CentOS server that runs  
my family email, web site, etc... I try and keep downtime and reboots  
to a bare minimum. :)

As to a patch for VRM 'passthrough' - again, way over my level of  
expertise I'm afraid. :(

What is interesting is that there is obviously a value being obtained  
from the motherboard - otherwise setting VRM to 100 (10.0) would also  
produce 0.000 V. But the calculation that it is running when the value  
is 110 (11.0) is resulting in a 0 value. So somehow, the formulae and  
cals in teh VRM translation is screwy when hwmon (correctly) detects  
my Conroe and sets it to 11.0.

Cheers
Simon

-- 
Simon Wilson
www.simonandkate.net

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
