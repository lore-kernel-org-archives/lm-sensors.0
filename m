From: juergh@gmail.com (Juerg Haefliger)
Date: Tue, 26 Dec 2006 14:38:38 +0000
Subject: [lm-sensors] vt1211 internal sensor
Message-Id: <191fb4ca0612260638v77c473b7mf191a509a94ab004@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0612260635y1a161255qdeb540ce2e51abc9@mail.gmail.com>
In-Reply-To: <191fb4ca0612260635y1a161255qdeb540ce2e51abc9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Udo,

Just to clarify: The VT1211 internal temp is *not* the ambient temp
inside your box. It's measured inside the VT1211 and since the VT1211
consumes quite some power, that temp is much higher than the ambient.

...juerg


On 12/26/06, Juerg Haefliger <juergh at gmail.com> wrote:
> Hi Udo,
>
> > # sensors
> > vt1211-isa-6000
> > Adapter: ISA adapter
> > +2.5V:     +2.40 V  (min =  +2.38 V, max =  +2.63 V)
> > VCore:     +1.03 V  (min =  +0.97 V, max =  +1.03 V)
> > +5V:       +4.74 V  (min =  +4.76 V, max =  +5.26 V)   ALARM
> > +12V:     +12.14 V  (min = +10.77 V, max = +13.21 V)
> > +3.3V:     +3.30 V  (min =  +3.13 V, max =  +3.46 V)
> > Case Fan: 2199 RPM  (min = 1290 RPM, div = 4)
> > CPU Temp:  +23.2?C  (high =   +75?C, hyst =   +70?C)
> > Int Temp:  +42.0?C  (high =   +65?C, hyst =   +60?C)
> > vid:      +1.850 V  (VRM Version 9.1)
> >
> > In other words: the VT1211 says it is warmer than the CPU and the harddisk:
>
> Yes, that's possible. The VT1211 get's pretty hot. I'm not sure about
> the CPU temp though. Did you adjust sensors.conf for your particular
> CPU? The CPU scaling parameters in sensors.conf come straight from the
> VIA BIOS porting guide. If you believe they are wrong, blame VIA...
>
> Hope that helps.
> ...juerg
>
>
> > Could you please tell me if I am wrong?
> > Or if you can explain?
> >
> > Thanks in advance!
> >
> > Kind regards,
> > Udo
> >
>

