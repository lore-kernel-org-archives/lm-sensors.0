From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 20 Sep 2006 20:11:21 +0000
Subject: [lm-sensors] asus P5GD2 Premium
Message-Id: <4511A069.30906@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <42C6BFB0.7090900@sh.cvut.cz>
In-Reply-To: <42C6BFB0.7090900@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Michael,

> I build a server based on an Asus but continually got
> an overtemperature alert (fan isn't modulating).  I
> first submitted a support ticket to this user group a
> year ago.  At that time, the drivers for my chipset
> were not written. I put the server in the basement
> with a fan blowing on it and only on the hottest days
> did I get the error.
> 
> I'm hoping that with lm-sensors upto 2.10, perhaps the
> chipset is supported.  Here is my system:
> 
> motherboard: asus P5GD2 Premium
> chipsets: Intel? 915P, Intel? ICH6R
> distribution: SuSE 9.2
> kernel: 2.6.8-24.14-smp
> processor: Intel P4 3.0 GHz
> Winbond W83627ehf (according to digital-life.com)

You need newer kernel, 2.6.13 has some support for the chip, but consider 
upgrading to even newer kernel if possible.

> Hopefully this is operator error.  Any help would be
> greatly appreciated so that I can take this server out
> of my dusty basement.

Maybe all you need is to check setup and set correctly the temperature alarm in 
BIOS. And turn on the qfan support there...

Regards
Rudolf

