From: Achim Gottinger <achim@ag-web.biz>
Date: Mon, 12 May 2008 15:02:39 +0000
Subject: Re: [lm-sensors] [PATCH] i2c-piix4: Blacklist two mainboards
Message-Id: <48285C0F.3030101@ag-web.biz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080504183048.177fc0b4@hyperion.delvare>
In-Reply-To: <20080504183048.177fc0b4@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> This is how you hit the problem, but there are many other ways people
> could hit it, such as using i2cdump, i2cget or i2cset, or even just
> loading a hardware monitoring driver which happens to probe I2C address
> 0x2e. While we fixed sensors-detect by now, not everyone will upgrade
> to the new version of the script immediately, and all the other ways to
> screw it up are still available. So, the only safe thing to do at the
> moment is to disable the SMBus on your motherboard completely.
>
> In the future, we could refine this and allow access again with
> restrictions, such as no probing allowed from kernel drivers, and no
> access from user-space (there's some more work needed before we can do
> that.) Or we could limit the blacklisting to specific addresses (that's
> easier to implement).
>
>   
But that way you can not run it on the DFI and Sapphire boards even if 
the latest lm-sensors version is
in use. How about a kernel config flag to disable this patch? Also I 
noted that you added infos on the website about this board.
The DFI Lanparty UT 790FX-M2R is not mentioned there but this board is 
also affected, two users reported they had to rma
board and/or cpu after running sensors-detect meanwile.
> I am worried that "hwmod" is too similar to "hwmon" and this will lead
> to confusion. What about "overclock" or a similarly explicit term?
>
>   
I'm concerned about that similarity here also. I don't want to put the 
focus on overclocking, so
i picked hwmod (hardware modification) for now, can use hwchange,hwshift 
or hwco (hardware change/clock over)
also. It's easy to change this in future.
>> I see no requirement to write separate modules for the smbus 
>> controllers. I guess there is way to use I2C_CLASS_HWMON adapters for 
>> devices ending up in /sysfs/class/hwmod, till  i figured out how i'll 
>> simply patch i2c-piix4.
>>     
>
> There is indeed no reason for separate modules for the SMBus
> controllers, I'm not even sure how you came to think we could do that.
> Adding a new class flag to i2c-piix4 was the right thing to do.
Good, that keeps things simple. I did not expect to run a hwmod version 
of that module parallel to the hwmon version.
Is this list the right place to discuss i2c related kernel modules? I 
dont want to get off topic here.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
