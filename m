From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: Intel S845WD1-E
Message-Id: <20040428224735.1d884cef.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200404280005.56044.lists@localguru.de>
In-Reply-To: <200404280005.56044.lists@localguru.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I use the lm_sensors-2.8.6/doc/chips/lm85 example file an modified it
> to my needs:
> 
> lm85b-i2c-0-2e
> Adapter: SMBus I801 adapter at efa0
> V1.5:       +1.52 V  (min =  +1.42 V, max =  +1.58 V)
> VCore:      +1.50 V  (min =  +1.45 V, max =  +1.60 V)
> V3.3:       +3.32 V  (min =  +3.13 V, max =  +3.47 V)
> V5:        +5.21 V  (min =  +4.74 V, max =  +5.26 V)
> V12:      +11.94 V  (min = +11.38 V, max = +12.62 V)
> CPU_Fan:   4808 RPM  (min = 4000 RPM)
> CPU:         +29 C  (low  =   +10 C, high =   +50 C)
> Board:       +23 C  (low  =   +10 C, high =   +35 C)
> Remote:      +23 C  (low  =   +10 C, high =   +35 C)
> CPU_PWM:   255
> Fan2_PWM:  255
> Fan3_PWM:  255
> vid:      +1.525 V    (VRM Version  9.1)

Great. Care to share the resulting configuration section with us? I
would then include it in the default configuration file.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
