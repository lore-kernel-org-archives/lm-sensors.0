From: Justin Piszcz <jpiszcz@lucidpixels.com>
Date: Wed, 02 May 2007 22:41:59 +0000
Subject: Re: [lm-sensors] coretemp - take3
Message-Id: <Pine.LNX.4.64.0705021841280.14579@p34.internal.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <45FDC7A4.9070601@assembler.cz> <45FE0EE3.2030201@boichat.ch>
In-Reply-To: <45FE0EE3.2030201@boichat.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicolas Boichat <nicolas@boichat.ch>
Cc: Rudolf Marek <r.marek@assembler.cz>, LM Sensors <lm-sensors@lm-sensors.org>, bytes@linuxgazette.net, debian-user@lists.debian.org, linux-kernel@vger.kernel.org



On Mon, 19 Mar 2007, Nicolas Boichat wrote:

> Rudolf Marek wrote:
>> Hello all,
>>
>> I'm CCing all interested parties, if some isn't please tell!
>>
>> On URL bellow is current version of coretemp driver.
>>
>> http://ssh.cz/~ruik/patches/
>
> Small glitch in coretemp_init:
>
>    printk(KERN_NOTICE DRVNAME ": This driver uses undocumented features"
>
>        "of Core CPU. Temperature might be wrong!\n");
>
>
> Prints this in dmesg:
>
> [46487.231000] coretemp: This driver uses undocumented featuresof Core CPU. Temperature might be wrong!
>
>
> (Notice the space missing between "features" and "of")
>
> Best regards,
>
> Nicolas
>

This did not make it into 2.6.21?  Will it get into 2.6.22?

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
