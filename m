From: Daimonos Tereutes <tereutes@nainwak.com>
Date: Wed, 25 Mar 2009 10:28:48 +0000
Subject: Re: [lm-sensors] Issues with ACER Travelmate 2423wxm
Message-Id: <49CA0760.8050205@nainwak.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ea963e260903250255x37d75f24qac2fd0fb0b52a2f7@mail.gmail.com>
In-Reply-To: <ea963e260903250255x37d75f24qac2fd0fb0b52a2f7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Cristiano Barbaro a =E9crit :
> Hello everyone. I am unable to get lm-sensors to detect my laptop's=20
> sensors. This is most annoying because in order to activate fan=20
> control to cool off the processor I need to have lm-sensors to find=20
> the sensors themselves. As a result, the laptop goes into some sort of=20
> slow mode after heating the processor up to 96 degrees celsius(!),=20
> and  everything sloooows down to a crawl including this  email that=20
> I'm typing. I have tried upgrading the bios to the Phoenix 1.06 latest=20
> version, but the only benefit has been that the temperature is=20
> correctly read by the system. The /proc/acpi/fan directory is totally=20
> empty.
> The system even overheats and slows down in Windows XP which I=20
> reinstalled recently in order to upgrade the bios.
>
> I am using Ubuntu 8.10 at the moment, with a small partition dedicated=20
> to windoze for future bios upgrades.
>
Hello,
I don't know for your specific model, but most acer laptop doesn't allow=20
to manage the fan.
The fan automaticaly (bios ? acpi ?) start when the trip temp is reached=20
(~50=B0C).

Your fan is probably in bad chape. If your laptop is no longer under=20
waranty you may try to open it to clean the fan and heat dissipator.
Or more easy, try to chase the dust with a vacuum cleaner or a gas=20
duster (canned air).

If it's under warranty, contact acer support.

Sincerely,
Fran=E7ois



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
