From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 25 Jun 2010 14:51:09 +0000
Subject: Re: [lm-sensors] Fwd: sensors.conf for DFI LP MI P55-T36 (it8720-*)
Message-Id: <20100625165109.6272762a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100625142936.296e3aa3@hyperion.delvare>
In-Reply-To: <20100625142936.296e3aa3@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Fri, 25 Jun 2010 15:13:55 +0100, Another Sillyname wrote:
> On 25 June 2010 13:29, Jean Delvare <khali@linux-fr.org> wrote:
> > On Fri, 25 Jun 2010 13:07:27 +0100, Another Sillyname wrote:
> >> I have 3 of these motherboards including one on a Win 7/Fedora 13 dual boot.
> >>
> >> What would you like to know?
> >
> > Nothing actually. It would have been needed if the BIOS wasn't
> > displaying the +12V value, but as it turns out that it does, we'll just
> > use that as our comparison point.
> >
> > Thanks for the proposal anyway!
> >
> > --
> > Jean Delvare
> >
> 
> No Problem
> 
> If it helps I'm running mine off 300w PSU's and have NVidia GT220
> cards installed, the NVidia temps are detected.
> 
> it8720-isa-0a10
> Adapter: ISA adapter
> in0:         +0.85 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
> in1:         +1.09 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
> in2:         +3.41 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
> in3:         +3.04 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
> in4:         +2.99 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
> in5:         +1.81 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
> in6:         +1.50 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
> in7:         +2.96 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
> Vbat:        +3.34 V
> fan1:          0 RPM  (min =    0 RPM)
> fan2:       1019 RPM  (min =    0 RPM)
> fan3:       2393 RPM  (min =    0 RPM)
> temp1:       +44.0°C  (low  =  -1.0°C, high =  -1.0°C)  sensor = thermistor
> temp2:       +39.0°C  (low  =  -1.0°C, high =  -1.0°C)  sensor = thermistor
> temp3:       +29.0°C  (low  =  -1.0°C, high =  -1.0°C)  sensor = disabled
> cpu0_vid:   +0.513 V

Feel free to use Lars configuration file:
http://www.eso.org/~llundin/sff/sensors.conf

You'll get a much better output.


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
