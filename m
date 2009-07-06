From: Jaswinder Singh Rajput <jaswinder@kernel.org>
Date: Mon, 06 Jul 2009 15:39:51 +0000
Subject: Re: [lm-sensors] Test of k8temp
Message-Id: <1246894071.3361.3.camel@ht.satnam>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A520751.3070803@assembler.cz>
In-Reply-To: <4A520751.3070803@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Rudolf,

On Mon, 2009-07-06 at 16:16 +0200, Rudolf Marek wrote:
> Hi again,
> 
> 
>  >Anyway, In the patch, replace :
> 
>  >+       /* Some AMD 10H cpus reports Inaccurate Temperature Measurement */
>  >+       if ((temp < 21000) || (temp > 90000))
> 
>  >+       /* Some AMD 10H cpus reports Inaccurate Temperature Measurement */
>  >+       if ((temp < 10000) || (temp > 90000))
> 
> So, now you see that workaround on some arbitrary temperature simply does not 
> make sense.
> 
> Please don't add  support for fam10h CPUs. This is not a point of HW monitoring, 
> to rule out  arbitrary temperatures.
> 

I totally agree with you that's why I removed the support for 10h as per
your suggestion.

> I'm perfectly fine if you come up with a patch for fam 11h because the Errata 
> seems to have vanished...
> 

x86: hwmon/k8temp.c Add support for AMD 11H

http://git.kernel.org/?p=linux/kernel/git/x86/linux-2.6-tip.git;a=commit;h18e6a08d340d853459a39b4104eab0334568427

is still waiting for your approval.

Thanks,
--
JSR


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
