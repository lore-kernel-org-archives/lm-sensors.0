From: Justin Piszcz <jpiszcz@lucidpixels.com>
Date: Mon, 30 Nov 2009 11:36:51 +0000
Subject: Re: [lm-sensors] ADT7490 support
Message-Id: <alpine.DEB.2.00.0911300632020.3678@p34.internal.lan>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="-1463747160-558418727-1259581011=:3678"
List-Id: <lm-sensors.vger.kernel.org>
References: <64c68f1f0910261310y7a04f31du290bd6ff10dc0c1a@mail.gmail.com>
In-Reply-To: <64c68f1f0910261310y7a04f31du290bd6ff10dc0c1a@mail.gmail.com>
To: lm-sensors@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463747160-558418727-1259581011=:3678
Content-Type: TEXT/PLAIN; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE



On Mon, 30 Nov 2009, Jean Delvare wrote:

> Hi Justin,
>
> Thanks for the fast test and report. Looks overall OK. Do you actually
> have 4 fans in this system?
I have 8 or so fans in the system with at least two-three connected via the
on-board fan connectors.

>
>> Why does temp1 say fault?
>
> The driver merely reports what the chip says. According to the dump you
> sent on October 16th, register 0x25 has value 0x80, bits [3:2] of
> register 0x76 have value 11b, this is a temperature value of -127.25=B0C.
> The fault is confirmed by bit 4 of register 0x41 (1b) and bit 6 of
> register 0x42 (1b) which stand for temp1 out of limits and temp1 open
> or short circuit, respectively.
>
>> All of the temps in the BIOS report properly.
>
> Can you please copy all the information reported by the BIOS and send
> it over? It will be interesting to compare what the BIOS says with what
> the adt7475 driver reports.
Here is a screenshot of nearly every screen in the BIOS:

longurl=3D"http://home.comcast.net/~jpiszcz/20091130"

wget $longurl/intel-p55kg-system-boot-display-options.jpg
wget $longurl/intel-p55kg-system-boot-menu.jpg
wget $longurl/intel-p55kg-system-configuration-sata-drives.jpg
wget $longurl/intel-p55kg-system-exit-menu.jpg
wget $longurl/intel-p55kg-system-setup-configuration.jpg
wget $longurl/intel-p55kg-system-setup-configuration-onboard-devices.jpg
wget $longurl/intel-p55kg-system-setup-event-log-configuration.jpg
wget $longurl/intel-p55kg-system-setup-fan-options.jpg
wget $longurl/intel-p55kg-system-setup-main.jpg
wget $longurl/intel-p55kg-system-setup-password-menu.jpg
wget $longurl/intel-p55kg-system-setup-pci-add-in-slots.jpg
wget $longurl/intel-p55kg-system-setup-performance-menu.jpg
wget $longurl/intel-p55kg-system-setup-power-menu.jpg
wget $longurl/intel-p55kg-system-setup-realtime-hardware-monitoring.jpg
wget $longurl/intel-p55kg-system-setup-video.jpg

The one that shows the temperatures and fan speeds is labeled:
intel-p55kg-system-setup-realtime-hardware-monitoring.jpg

>
> The above output suggests that temp1 isn't used on your system, temp2 is
> internal to the ADT7490 so it would be the motherboard temperature,
> while temp3 would likely be the CPU temperature. Does the BIOS report
> more than 2 temperature values?
Yes but the top one is the thermal margin, so you are correct, the first
temperature for this board needs to be disabled so lm-sensors does not look
for it, see: intel-p55kg-system-setup-realtime-hardware-monitoring.jpg

>
> I think we can use the following as the default configuration for the
> ADT7490:
>
> chip "adt7490-*"
>
>    label in1 "Vcore"
>    label in2 "+3.3V"
>    label in3 "+5V"
>    label in4 "+12V"
>
>    set in2_min  3.3 * 0.90
>    set in2_max  3.3 * 1.10
>    set in3_min  5.0 * 0.90
>    set in3_max  5.0 * 1.10
>    set in4_min 12.0 * 0.90
>    set in4_max 12.0 * 1.10
>
>    label temp2 "M/B Temp"

Please let me know if you need anything else, thanks.

Justin.

---1463747160-558418727-1259581011=:3678
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
---1463747160-558418727-1259581011=:3678--
