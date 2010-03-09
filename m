From: Phillip Pi <ant@zimage.com>
Date: Tue, 09 Mar 2010 09:05:58 +0000
Subject: Re: [lm-sensors] Upgraded my old Debian box's Kernel from 2.6.30 to
Message-Id: <20100309090558.GP25106@alpha.zimage.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100305222015.GR11436@alpha.zimage.com>
In-Reply-To: <20100305222015.GR11436@alpha.zimage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

> On Mon, 8 Mar 2010 13:43:14 -0800, Phillip Pi wrote:
> > In older Kernels like v2.6.30, did this conflict happen too? I only 
> > remember seeing inaccurate values like for voltages. Speaking of 
> > voltages, which part is responsibile for voltages showing that I don't 
> > have in 2.6.32, but did in 2.6.30?
> 
> Please be specific. What chip is it, which voltages are missing?

AMD Athlon X2 939 CPU 4600+ and MSI K8N NEO4-F (MS-7125) motherboard
(NVIDIA nForce4). See my secondary computer details at:
http://alpha.zimage.com/~ant/antfarm/about/computers.txt

As for voltages, Kernel 2.6.30 and earlier said something like:
$ sensors -f
k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp: +80.6�F
...
Adapter: ISA adapter
VCore: +1.12 V (min = +2.11 V, max = +2.48 V)
+3.3V: +3.28 V (min = +1.46 V, max = +0.21 V)
+5V: +4.97 V (min = +0.89 V, max = +0.22 V)
+12V: +11.43 V (min = +0.24 V, max = +9.67 V)
-12V: +0.72 V (min = -5.37 V, max = +0.63 V)
-5V: +5.10 V (min = +1.18 V, max = -7.66 V)
V5SB: +5.59 V (min = +0.13 V, max = +0.48 V)
VBat: +1.55 V (min = +2.24 V, max = +3.46 V)
fan1: 2360 RPM (min = 1622 RPM, div = 4)
fan2: 2376 RPM (min = 1985 RPM, div = 4)
temp1: +82.4�F (high = +201.2°F, hyst = +221.0°F) sensor = 
thermistor
temp2: +86.0�F (high = +176.0°F, hyst = +167.0°F) sensor = 
thermistor
beep_enable:enabled

I even reran sensors-detect command as shown in http://pastie.org/856408
(too long to show in this post/e-mail).

 
> Remember that the output of sensors is influenced by the contents of
> libsensors configuration files (/etc/sensors.conf, /etc/sensors3.conf
> and/or /etc/sensors.d/* depending on your libsensors version and
> distribution choices.)

I always keep my lm_sensors packages updated so whatever they gave me is 
what I use. The only I edited was /etc/modules based on sensors-detect 
results (w83627ehf). I do not recall editing sensors*.conf files or 
being asked to do so.
-- 
Quote of the Week: "This isn't a war. It never was a war, any more than
there's war between man and ants." --artilleryman from H.G. Wells' The
War of the Worlds
  /\___/\
 / /\ /\ \         Phil./Ant @ http://antfarm.ma.cx (Personal Web Site)
| |o   o| |                Ant's Quality Foraged Links: http://aqfl.net
   \ _ /                 E-mail: philpi@earthlink.net or ant@zimage.com
    ( )

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
