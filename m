From: Mathias Gerber <mathias_g@tuxedo.ath.cx>
Date: Thu, 20 Feb 2014 23:16:14 +0000
Subject: Re: [lm-sensors] Configuration ASUS H87-PRO for Wiki
Message-Id: <53068CBE.9050604@tuxedo.ath.cx>
List-Id: <lm-sensors.vger.kernel.org>
References: <52F7AFB9.8040109@tuxedo.ath.cx>
In-Reply-To: <52F7AFB9.8040109@tuxedo.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Jean

Thanks for your comments and your effort.

On 20.02.2014 21:55, Jean Delvare wrote:
>> label in0 "VCCin" # CPU Input Voltage
> We typically use "Vcore" for the CPU voltage, even though I see
> Asus names it VCCIN in the BIOS.
I didn't knew it better so I have just chosen the BIOS label. But ok.

>> compute in0  @*2    , @/2
> This is very surprising. The NCT6791 has a 2.04 V ADC so any
> voltage below 2 V doesn't need to be scaled. CPU core voltage is
> typically way below 2 V on modern CPUs.
According to [1], Page 94 is Vcc can be requested by the CPU up to
3.04V (0xFF) on a 4th gen Intel Core CPU.

Unscaled i get a reading of 0.86V, the BIOS shows 1.728.
It seems that this is not the only board with such a "wiring", see [2]

>> label in1 "+5V" # 5V
> How did you figure out?
With the following BIOS sample readings:
5, 5.08, 5.12, 5.2

Minimal difference found in the reading: 0.04V. The nct6791 has
8mV/Bit unscaled. => 40/8

> As a general comment, I don't see the point of these comments 
> duplicating the label.
Ok, some of them were just leftovers from the "development" of the
configuration file.

> Yes, these are AVCC and +3.3V, no need for question marks. These
> are hardwired in the chipset so they can't be wrong.
I did not knew thank, thanks for the explanation.

>> label in4 "+12V" # 12V
> How did you figure out?
I took/found the following BIOS samples:
11.328, 12, 12.096, 12.384
Minimal difference found in the reading: 0.096V. The nct6791 has
8mV/Bit unscaled. => 96/8

But I could not clearly assign the 12V reading to in1 or in4 because
the two readings were nearly identical :-/
So I connected an external 12V PSU to the 12V rail and turned the
voltage slightly up and down :-) (with a PicoPSU)

>> label in7 "3VSB?" # 3VSB? set in7_min 3.3 * 0.95 set in7_max 3.3
>> * 1.05
> Again, yes they are, no need for question marks.
Fine :-) But do you know why its 3VSB (=standby?)
I thought the standby voltage is usually 5V, isn't it?

> Setting  in8_min to 3 V seems a bit optimistic, it's a 3 V battery
> so it could easily go slightly below 3 V. 3 * 0.95 would seem more 
> reasonable. Likewise, in8_max doesn't need to be so high, worst
> case the battery is backed by 3VSB which is 3.3 V +/- 5% according
> to the ATX specification. So a max of 3.3 * 1.05 seems reasonable.
Actual reading here: 3.33V. But normally I agree, yes.

> For the wiki, we don't put ignore statements for inputs which do
> exist on the board (although I understand you put them in your
> local copy of the file.)
Ok.

>> #label CPUTIN "CPU temperature"
> I suppose you really mean temp2. But why is it commented out?
This is a leftover from one of my first tests with this board.
I just forgot to clear the line completely.

>> ignore intrusion0
> Is the intrusion detection feature not available on the board?
Found no connector nor an mentioning in the manual.

>> ignore temp7		# PECI Agent 0 => value is the same as coretemp,
>> phys ID0
> That's not a reason to ignore it. Having more sources can be
> useful, for example to setup automatic fan speed control, or to use
> the min/max settings which the coretemp driver doesn't have.
Ok

[1]
> https://www-ssl.intel.com/content/dam/www/public/us/en/documents/datasheets/4th-gen-core-family-desktop-vol-1-datasheet.pdf

[2]
> 
http://www.spinics.net/lists/lm-sensors/msg40663.html
- -- 
thanks!

kind regards
 Mathias
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlMGjLcACgkQnfTEjDUZ2fOgVACfcE0xps+2vzRMVmXI//CtsxEs
DCwAoPWrAqJBcbao8EqPf3wgoV/MaR18
=pQWD
-----END PGP SIGNATURE-----

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
