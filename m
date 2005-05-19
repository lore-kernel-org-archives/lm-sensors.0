From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: ADM 1025 on 2.6 kernel
Message-Id: <20040707082938.6ccd1e5b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1084951647.6186.13.camel@powerride>
In-Reply-To: <1084951647.6186.13.camel@powerride>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> this is the sensors output:
> 
> adm1025-i2c-0-2d
> Adapter: SMBus I801 adapter at efa0
> +2.5V:     +2.49 V  (min =  +0.00 V, max =  +3.32 V)
> VCore:     +1.68 V  (min =  +0.00 V, max =  +2.99 V)
> +3.3V:     +3.37 V  (min =  +0.00 V, max =  +4.38 V)
> +5V:       +4.92 V  (min =  +0.00 V, max =  +6.64 V)
> +12V:     +11.94 V  (min =  +0.00 V, max = +15.94 V)
> VCC:       +3.39 V  (min =  +0.00 V, max =  +4.38 V)
> CPU Temp:  +43.0 C  (low  =    +0 C, high =  +127 C)
> M/B Temp:  +39.0 C  (low  =    +0 C, high =  +127 C)
> vid:      +1.700 V
> 
> The CPU is a Pentium III 866 (SL4MD). Its voltage is supposed to be
> 1.7V

OK. Looks very good! Now you can copy etc/sensors.conf.eg to
/etc/sensors.conf and tweak this configuration file to fit your needs.
Defaults for voltage limits should be just fine, but you may want to
refine the temperature limits. Then running "sensors -s" will set the
requested limits.

Thanks for reporting, and glad that my driver seems to be working OK :)

-- 
Jean Delvare
http://khali.linux-fr.org/
