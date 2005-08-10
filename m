From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Wed, 10 Aug 2005 19:25:59 +0000
Subject: [lm-sensors] wrong temperature values
Message-Id: <2538186705081010255a26d142@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1123669211.4125.7.camel@localhost.localdomain>
In-Reply-To: <1123669211.4125.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jonathan,

On 8/10/05, jonathan <support-squid@bfinance.fr> wrote:
> hi ,
> I have installed lm-sensors with i2c, ipmi and bmcsensors modules but
> the sensors command give me wrong values :
> 
> # sensors -s     --> no output ?
> # sensors
> bmc-i2c-1-00
> Adapter: IPMI adapter
> in1:       +1.48 V  (min =  +1.56 V, max =  +1.73 V)
> in2:       +1.90 V  (min =  +1.56 V, max =  +1.73 V)
> in3:       +1.90 V  (min =  +1.56 V, max =  +1.73 V)
> in4:       +1.48 V  (min =  +1.56 V, max =  +1.73 V)
> in5:       +1.90 V  (min =  +4.79 V, max =  +5.21 V)
> in6:       +5.08 V  (min = +11.39 V, max = +12.61 V)
> in7:      +11.90 V  (min =  +3.16 V, max =  +3.44 V)
> in8:       +3.27 V  (min =  +2.49 V, max =  +3.28 V)
> in9:       +3.12 V  (min =  +2.42 V, max =  +2.58 V)
> in10:      +2.55 V  (min =  +2.42 V, max =  +2.58 V)
> fan1:     6240 RPM  (min = 1080 RPM)
> fan2:     6360 RPM  (min = 1080 RPM)
> fan3:     6240 RPM  (min = 1080 RPM)
> fan4:     6720 RPM  (min = 1080 RPM)
> fan5:     6360 RPM  (min = 1080 RPM)
> fan6:     6240 RPM  (min = 1080 RPM)
> fan7:     6480 RPM  (min = 1080 RPM)
> temp1:    -128.0 C  (high =   +80 C, hyst =  -127 C)
> temp2:    -930.0 C  (high =   +80 C, hyst =  -127 C)
> temp3:    -1280.0 C  (high =   +80 C, hyst =  -127 C)
> temp4:    -930.0 C  (high =   +80 C, hyst =  -127 C)
> temp5:    +320.0 C  (high =   +55 C, hyst =  -127 C)
> temp6:    +190.0 C  (high =   +40 C, hyst =  -127 C)
> temp7:    -750.0 C  (high =   +55 C, hyst =  -127 C)
> temp8:    -760.0 C  (high =   +55 C, hyst =  -127 C)
> temp9:    -750.0 C  (high =   +55 C, hyst =  -127 C)
> temp10:   +270.0 C  (high =   +55 C, hyst =  -127 C)

Well I don't think they aren't 'wrong' but they do need scaling :-)
(although the negative ones are strange), see the example sensors.conf
(http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/etc/sensors.conf.eg)
for how to do so, specifically the compute lines. You will need to
have some idea of what they normally should be, and if your bios gives
you the same info you can compare with that. Also try ipmitool and see
what it reads, it will probably give you the same thing though.

Yani
