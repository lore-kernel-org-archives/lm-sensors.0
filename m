From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 27 Sep 2008 20:16:39 +0000
Subject: Re: [lm-sensors] Intel DG45FC
Message-Id: <20080927221639.1eebd011@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <7bccedf10809181658o18aa47bbt46480ca2a67b1ac9@mail.gmail.com>
In-Reply-To: <7bccedf10809181658o18aa47bbt46480ca2a67b1ac9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 27 Sep 2008 11:08:12 -0700, Anthony Arobone wrote:
> On Sat, Sep 27, 2008 at 4:47 AM, Jean Delvare <khali@linux-fr.org> wrote:
> > OK. So either the LM96000 can be re-enabled, or there's another
> > monitoring chip on your motherboard.
> >
> > Can you please list the labels and values displayed by your BIOS? To
> > check whether this corresponds to the LM96000 inputs or not.
> 
> Here is what my BIOS list, the "xxx" is just a replacement for that actual 3
> decimal numbers that i didn't capture:
> 
> CPU Die/Package Temp         Prochot-49C
> Motherboard Temp                 38C
> ICH Temp                              65C
> MCH Temp                            45C
> 
> +12v                                     12.xxxv
> +5v                                       5.xxxv
> +3.3v Standby                       3.3xxv
> MCH Vcc                              1.1135v
> CPU 1 Vccp                          1.218v
> 
> CPU Cooling FAN                  836 RPM
> Chassis Inlet FAN                  3061 RPM

This seems to match the LM96000 features (assuming "CPU Die/Package
Temp" is from the Intel Core internal sensor.)

> > (...)
> > OK, so this is basically the same case as in ticket 2182: first version
> > of the LM96000, and strange value in register 0x6f. So please do the
> > same test I suggested in this ticket:
> >
> > # rmmod lm85
> > # i2cset -y 0 0x2e 0x40 0x04
> > # i2cset -y 0 0x2e 0x6f 0x00
> > # i2cset -y 0 0x2e 0x40 0x05
> > # modprobe lm85
> >
> > And report if it helps or not.
> 
> Didn't help.  Everything is still zero.  :(

OK... No other idea for now.


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
