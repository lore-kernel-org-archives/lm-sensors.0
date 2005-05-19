From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: lm_sensors for 2.6 kernels
Message-Id: <20040125170132.5ed1b0a6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58-035.0401251037500.2678@unix46.andrew.cmu.edu>
In-Reply-To: <Pine.LNX.4.58-035.0401251037500.2678@unix46.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>   one of my goals for the next couple of months is to get lm_sensors
>   working properly on my computer cluster where i work. the expected
>   timeframe for a 2.6 kernel upgrade is may/june this year.
> 
>   my main interest is to obtain status info for Intel E7xxx chipsets;
>   the current test system is a SuperMicro P4SAA (E7205) mobo.
>   when running "sensors-detect", i end up with all modules loading and
> 
> Driver `w83627hf' (should be inserted):
>   Detects correctly:
>   * ISA bus address 0x0290 (Busdriver `i2c-isa')
>     Chip `Winbond W83627HF Super IO Sensors' (confidence: 9)
> 
>   your status page says this driver (and 2.6 support) is in beta.
>   being impatient, i naturally tried to
> 
> gcc -c -Wall -DMODULE -D__KERNEL__ -O6 \
>     -I${KPATH}/linux-2.6.1-p4/include w83627hf.c
> 
>   but -- as your documentation says -- it "will not compile".
> 
>   --> i'll be happy/willing to participate in some testing here
>       if you think it would be of use yet.

The 2.4 driver may be beta (although I think it has been succesfully
tested by several users by now). The 2.6 driver just doesn't exist. All
chip drivers needs to be ported to 2.6, not all have been yet.

If you are willing to try porting it yourself, instructions on how to do
so is available in Documentation/i2c/porting-clients in Linux 2.6. This
is your best chance to have it done quickly, since I am already busy
porting another driver (adm1025) and have so many other things to do for
this project and others (including real life stuff, yes, really).

And, just to make it clear, all this doesn't depend on Intel E7xxx
chipsets at all. Your sensor chip is accessed through the ISA bus, so it
doesn't depend on any particular motherboard chipset.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
