From: Justin Piszcz <jpiszcz@lucidpixels.com>
Date: Mon, 30 Nov 2009 22:12:46 +0000
Subject: Re: [lm-sensors] ADT7490 support
Message-Id: <alpine.DEB.2.00.0911301712220.1059@p34.internal.lan>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="-1463747160-1097569435-1259619166=:1059"
List-Id: <lm-sensors.vger.kernel.org>
References: <64c68f1f0910261310y7a04f31du290bd6ff10dc0c1a@mail.gmail.com>
In-Reply-To: <64c68f1f0910261310y7a04f31du290bd6ff10dc0c1a@mail.gmail.com>
To: lm-sensors@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463747160-1097569435-1259619166=:1059
Content-Type: TEXT/PLAIN; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE



On Mon, 30 Nov 2009, Jean Delvare wrote:

> On Mon, 30 Nov 2009 06:36:51 -0500 (EST), Justin Piszcz wrote:
>> The one that shows the temperatures and fan speeds is labeled:
>> intel-p55kg-system-setup-realtime-hardware-monitoring.jpg
>
> This seems to match the output of "sensors" except for the missing
> thermal margin value. It certainly comes from the PECI input, for which
> we have no support.
>
>>> The above output suggests that temp1 isn't used on your system, temp2 i=
s
>>> internal to the ADT7490 so it would be the motherboard temperature,
>>> while temp3 would likely be the CPU temperature. Does the BIOS report
>>> more than 2 temperature values?
>> Yes but the top one is the thermal margin, so you are correct, the first
>> temperature for this board needs to be disabled so lm-sensors does not l=
ook
>> for it, see: intel-p55kg-system-setup-realtime-hardware-monitoring.jpg
>
> This isn't the driver's job, as it can't tell the difference between a
> permanently unused input and an actual sensor breakage. If you want to
> hide temp1, just add the following to your sensors3.conf's adt7475
> section:
>
>    ignore temp1
>
> As for the thermal margin, we lack support for this in libsensors at
> the moment. How this could be implemented is still under discussion.
> Until it settles, I can't add support to the adt7475 driver.
>
> --=20
> Jean Delvare
>

Thanks,

I added the ignore temp1 and also tried your latest release:

adt7490-i2c-0-2c
Adapter: SMBus I801 adapter at 7000
in0:         +1.52 V  (min =3D  +0.00 V, max =3D  +3.31 V)=20
Vcore:       +1.26 V  (min =3D  +0.00 V, max =3D  +2.99 V)=20
+3.3V:       +3.31 V  (min =3D  +0.00 V, max =3D  +4.39 V)=20
+5V:         +5.11 V  (min =3D  +0.00 V, max =3D  +6.68 V)=20
+12V:       +12.00 V  (min =3D  +0.00 V, max =3D +15.69 V)=20
in5:         +2.22 V  (min =3D  +0.00 V, max =3D  +4.48 V)=20
fan1:       1345 RPM  (min =3D    0 RPM)
fan2:       1308 RPM  (min =3D    0 RPM)
fan3:        729 RPM  (min =3D    0 RPM)
fan4:        933 RPM  (min =3D    0 RPM)
M/B Temp:    +41.8=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
                       (crit =3D +65.0=B0C, hyst =3D +61.0=B0C)=20
temp3:       +45.2=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
                       (crit =3D +65.0=B0C, hyst =3D +61.0=B0C)

Looks good, thanks.

Justin.

---1463747160-1097569435-1259619166=:1059
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
---1463747160-1097569435-1259619166=:1059--
