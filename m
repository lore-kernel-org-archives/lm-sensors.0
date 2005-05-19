From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:26 +0000
Subject: [medlock@turboshower.net: Re: Ticket number 725]
Message-Id: <3C045102.407A71E7@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20011117152214.B4693@milhouse.turboshower.net>
In-Reply-To: <20011117152214.B4693@milhouse.turboshower.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

looks good.
I added native w83697hf support to the w83781d driver in CVS
if you would like to test it.
It should be the same as the w83782d except no
vid, no temp3, no fan3.
mds

Jan Medlock wrote:
> 
> Subject: Re: Ticket number 725
> Date: Sat, 17 Nov 2001 15:20:55 -0800
> From: Jan Medlock <medlock@turboshower.net>
> To: "Mark D. Studebaker" <mds@paradyne.com>
> References: <20011113225818.A4133@milhouse.turboshower.net> <3BF5AA3A.EF1A4AFB@paradyne.com>
> 
> here's the output from 'isadump 0x295 0x296'
> 
> [root@milhouse dump]# ./isadump 0x295 0x296
>   WARNING! Running this program can cause system crashes, data loss
>   and worse!
>   I will probe address register 0x0295 and data register 0x0296.
>   You have five seconds to reconsider and press CTRL-C!
> 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 01 ff 01 ff 00 00 00 00 01 01 01 01 3c 3c 0a 0a
> 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 20: 6f 00 5e b7 c6 c8 a4 18 89 ff ff 55 4d 55 4d d8
> 30: c4 c3 b0 d9 b2 15 31 31 3b 3c 32 e1 e1 e1 00 00
> 40: 01 00 00 00 00 00 00 5f 2d 02 01 c4 58 95 00 a3
> 50: ff ff 00 ff ff ff 00 00 60 70 ff ff 19 01 ff 05
> 60: 6f 00 5e b7 c5 c9 a4 18 89 ff ff 55 4d 55 4d d8
> 70: c4 c3 b0 d9 b2 15 31 31 3b 3c 32 e1 e1 e1 00 00
> 80: 01 ff 01 ff 00 00 00 00 01 01 01 01 3c 3c 0a 0a
> 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> a0: 6f 00 5e b7 c5 c9 a4 18 89 ff ff 55 4d 55 4d d8
> b0: c4 c3 b0 d9 b2 15 31 31 3b 3c 32 e1 e1 e1 00 00
> c0: 01 00 00 00 00 00 00 5f 2d 02 01 c4 58 95 00 a3
> d0: ff ff 00 ff ff ff 00 00 60 70 ff ff 19 01 ff 05
> e0: 6f 00 5e b7 c5 c9 a4 18 89 ff ff 55 4d 55 4d d8
> f0: c4 c3 b0 d9 b2 15 31 31 3b 3c 32 e1 e1 e1 00 00
> 
> On Fri, Nov 16, 2001 at 07:07:22PM -0500, Mark D. Studebaker wrote:
> > isadump 0x295 0x296
> >
> >
> > Jan Medlock wrote:
> > >
> > > here's the output from 'sensors':
> > >
> > > [medlock@milhouse medlock]$ sensors
> > > eeprom-i2c-0-50
> > > Adapter: SMBus Via Pro adapter at 5000
> > > Algorithm: Non-I2C SMBus adapter
> > >
> > > eeprom-i2c-0-51
> > > Adapter: SMBus Via Pro adapter at 5000
> > > Algorithm: Non-I2C SMBus adapter
> > >
> > > w83627hf-isa-0290
> > > Adapter: ISA adapter
> > > Algorithm: ISA algorithm
> > > VCore 1:   +1.79 V  (min =  +1.23 V, max =  +1.36 V)
> > > VCore 2:   +0.00 V  (min =  +1.23 V, max =  +1.36 V)
> > > +3.3V:     +1.50 V  (min =  +3.13 V, max =  +3.45 V)
> > > +5V:       +4.97 V  (min =  +4.72 V, max =  +5.24 V)
> > > +12V:     +11.89 V  (min = +10.79 V, max = +13.19 V)
> > > -12V:      +2.10 V  (min = -10.90 V, max = -13.21 V)
> > > -5V:       +0.52 V  (min =  -4.76 V, max =  -5.26 V)
> > > V5SB:      +5.38 V  (min =  +4.72 V, max =  +5.24 V)
> > > VBat:      +3.12 V  (min =  +2.40 V, max =  +3.60 V)
> > > fan1:     4963 RPM  (min = 3000 RPM, div = 2)
> > > fan2:        0 RPM  (min = 3000 RPM, div = 2)
> > > fan3:        0 RPM  (min =  750 RPM, div = 8)
> > > temp1:       +24  (limit =  +60, hysteresis =  +50) sensor > > > thermistor
> > > temp2:     +36.0  (limit =  +60, hysteresis =  +50) sensor > > > thermistor
> > > temp3:    +255.5  (limit = +256, hysteresis = +256) sensor > > > thermistor
> > > vid:      +1.30 V
> > > alarms:   Chassis intrusion detection
> > > beep_enable:
> > >           Sound alarm disabled
> > >
> > > I was asked to do an 'i2cdump' but this doesn't work because the chip
> > > is on an ISA bus.  I presume that I should use 'isadump' but with what
> > > arguments?
> > >
> > > Thanks.
