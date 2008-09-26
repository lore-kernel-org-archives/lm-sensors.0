From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 26 Sep 2008 07:10:28 +0000
Subject: Re: [lm-sensors] Intel DG45FC
Message-Id: <20080926091028.56d048ef@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <7bccedf10809181658o18aa47bbt46480ca2a67b1ac9@mail.gmail.com>
In-Reply-To: <7bccedf10809181658o18aa47bbt46480ca2a67b1ac9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Anthony,

On Thu, 25 Sep 2008 17:13:17 -0700, Anthony Arobone wrote:
> Finally got the board all hooked up again.  I've attached a text file with
> all the output I could think of.  Notice the dmesg warning when modprobing
> lm85.
> (...)
> lm85-i2c-0-2e
> Adapter: SMBus I801 adapter at f000
> V1.5:       +0.00 V  (min =  +0.00 V, max =  +3.32 V)
> VCore:      +0.00 V  (min =  +0.00 V, max =  +2.99 V)
> V3.3:       +0.00 V  (min =  +0.00 V, max =  +4.38 V)
> V5:         +0.00 V  (min =  +0.00 V, max =  +6.64 V)
> V12:        +0.00 V  (min =  +0.00 V, max = +15.94 V)
> CPU_Fan:      0 RPM  (min =    0 RPM)                     ALARM
> fan2:         0 RPM  (min =    0 RPM)                     ALARM
> fan3:         0 RPM  (min =    0 RPM)                     ALARM
> fan4:         0 RPM  (min =    0 RPM)                     ALARM
> CPU Temp:     +0 C  (low  =  -127 C, high =  +127 C)
> Board Temp:
>               +0 C  (low  =  -127 C, high =  +127 C)
> Remote Temp:
>               +0 C  (low  =  -127 C, high =  +127 C)
> CPU_PWM:   255
> Fan2_PWM:  255
> Fan3_PWM:  255
> vid:      +2.050 V  (VRM Version 8.2)

As I suspected, this is exactly the same case as in ticket #2182:
http://www.lm-sensors.org/ticket/2182

I've updated wiki/Devices to mention this known issue. At this point we
have no idea how to solve it.

Does your BIOS display (non-zero) hardware monitoring information?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
