From: r.marek@assembler.cz (Rudolf Marek)
Date: Sun, 07 Jan 2007 12:05:11 +0000
Subject: [lm-sensors] sensors.conf for supermicro x7dbe+
Message-Id: <45A0E1F7.9030609@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701031701.08165.nromer@arcmailtech.com>
In-Reply-To: <200701031701.08165.nromer@arcmailtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

One more thing.

> w83793-i2c-0-2f
> Adapter: SMBus I801 adapter at 1100
> VCoreA:    +1.22 V  (min =  +0.92 V, max =  +1.49 V)   
> VCoreB:    +1.26 V  (min =  +0.92 V, max =  +1.49 V)   
> -12V:      +1.49 V  (min =  +1.34 V, max =  +1.65 V)   
> +1.5V:     +3.30 V  (min =  +2.96 V, max =  +3.63 V)   
> +3.3V:    +11.90 V  (min = +10.75 V, max = +13.25 V)   
> +12V:      +4.97 V  (min =  +4.49 V, max =  +5.50 V)   
> +5V:       +4.92 V  (min =  +4.49 V, max =  +5.50 V)   
> 5VSB:      +3.25 V  (min =  +2.99 V, max =  +3.66 V)   

Why has your board 5VSB connected to 3.3V? The chip specs say it needs this to
be 5V? Maybe Supermicro did this wrong??? (I checked different board and it has
there 5V)

Please can you ask them if pin7 5VSB is connected to 5VSB?

Thanks,

Rudolf

