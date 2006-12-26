From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 26 Dec 2006 09:11:25 +0000
Subject: [lm-sensors] w83793 driver ready
Message-Id: <20061226101125.f3febb40.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061208153817.de1c2b4c.khali@linux-fr.org>
In-Reply-To: <20061208153817.de1c2b4c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi GongJun,

On Tue, 26 Dec 2006 13:47:24 +0800, JGong at winbond.com wrote:
> It's good news that the w83793 driver has been included in the
> 2.6.20. Here is a result report from our w83793 test board.
> It seems all right.
> 
> [root at localhost ~]# sensors -v
> sensors version 2.10.1 with libsensors version 2.10.1
> [root at localhost ~]# uname -a
> Linux localhost.localdomain 2.6.20-rc2 #0 SMP Tue Dec 26 11:44:49 CST 2006 i686 i686 i386 GNU/Linux
> [root at localhost ~]# sensors
> w83793-i2c-0-2f
> Adapter: SMBus I801 adapter at 1100
> VCoreA:    +1.18 V  (min =  +0.00 V, max =  +2.05 V)
> VCoreB:    +1.19 V  (min =  +0.00 V, max =  +2.05 V)
> Vtt:       +1.23 V  (min =  +0.00 V, max =  +2.05 V)
> in3:       +1.50 V  (min =  +0.00 V, max =  +4.08 V)
> in4:       +1.79 V  (min =  +0.00 V, max =  +4.08 V)
> +3.3V:     +3.31 V  (min =  +0.00 V, max =  +4.08 V)
> +12V:     +11.90 V  (min =  +0.00 V, max = +24.48 V)
> +5V:       +4.92 V  (min =  +0.00 V, max =  +6.12 V)
> 5VSB:      +4.94 V  (min =  +0.00 V, max =  +6.12 V)
> VBAT:      +3.20 V  (min =  +0.00 V, max =  +4.08 V)
> fan1:        0 RPM  (min =    0 RPM)
> fan2:     3169 RPM  (min =    0 RPM)
> fan3:        0 RPM  (min =    0 RPM)
> fan4:     3461 RPM  (min =    0 RPM)
> fan5:        0 RPM  (min =    0 RPM)
> fan6:        0 RPM  (min =    0 RPM)
> fan7:        0 RPM  (min =    0 RPM)
> fan8:        0 RPM  (min =    0 RPM)
> CPU1 Temp: +30.0??C  (high = +100.0??C, hyst = +95.0??C)
> CPU2 Temp: +31.0??C  (high = +100.0??C, hyst = +95.0??C)
> temp3:      +0.0??C  (high = +100.0??C, hyst = +95.0??C)
> temp4:      +0.0??C  (high = +100.0??C, hyst = +95.0??C)
> temp5:       +39??C  (high =  +100??C, hyst =   +95??C)
> temp6:       +37??C  (high =  +100??C, hyst =   +95??C)
> cpu0_vid: +1.513 V  (VRM Version 11.0)
> cpu1_vid: +0.425 V  (VRM Version 11.0)
> 
> If you have any idea that wants to be tested on w83793, feel free
> to contact us.

You could try writing voltage, fan and temperature limits to make sure
it works OK. Also try setting limits too low and see if the ALARM flags
are set as expected.

Thanks,
-- 
Jean Delvare

