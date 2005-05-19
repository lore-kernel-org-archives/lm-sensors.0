From: lists@localguru.de (Marcus Schopen)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: Intel S845WD1-E
Message-Id: <200404282104.02295.lists@localguru.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200404280005.56044.lists@localguru.de>
In-Reply-To: <200404280005.56044.lists@localguru.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Wednesday 28 April 2004 11:23, Jean Delvare wrote:
> > Ah, nice! I'm running Debian/woody (kernel 2.4.18) which contains the
> > following source packages of lm-sensors and i2c:
> >
> >    Package: lm-sensors-source - Version: 2.6.3-5
> >    Package: i2c-source - Version: 2.6.3-5
> >
> > Are these versions too old?
>
> They are admittedly old, but I'd expect the i2c-i801 driver to already
> support your Intel chip though. The best way to make sure is to try,
> don't you think? Just try modprobing i2c-i801 and see what happens. If
> it doesn't work, then provide the output of "lspci -n".

I built all from source and it seems to work fine :) Any idea where to find a 
translation of in0, in1, fan1, pwm1 etc ?

Cheers,
Marcus

lm85b-i2c-0-2e
Adapter: SMBus I801 adapter at efa0
in0:        +1.52 V  (min =  +0.00 V, max =  +3.32 V)
in1:        +1.50 V  (min =  +0.00 V, max =  +2.99 V)
in2:        +3.32 V  (min =  +0.00 V, max =  +4.38 V)
in3:       +5.21 V  (min =  +0.00 V, max =  +6.64 V)
in4:      +11.94 V  (min =  +0.00 V, max = +15.94 V)
fan1:      4825 RPM  (min =    0 RPM)
fan2:         0 RPM  (min =    0 RPM)
fan3:         0 RPM  (min =    0 RPM)
fan4:         0 RPM  (min =    0 RPM)
temp1:       +28 C  (low  =  -127 C, high =  +127 C)
temp2:       +23 C  (low  =  -127 C, high =  +127 C)
temp3:       +23 C  (low  =  -127 C, high =  +127 C)
pwm1:      255
pwm2:      255
pwm3:      255
vid:      +1.525 V    (VRM Version  9.1)
