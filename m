From: Luca Tettamanti <kronos.it@gmail.com>
Date: Wed, 26 May 2010 07:43:42 +0000
Subject: Re: [lm-sensors] trouble configuring an ASUS M51VA laptop
Message-Id: <AANLkTinwukTGoJA-ZBLaEQJ0qWKvxwmCx6Hh3LPg4mg0@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4BF5069A.7030602@kalfaoglu.com>
In-Reply-To: <4BF5069A.7030602@kalfaoglu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, May 26, 2010 at 8:50 AM, Jean Delvare <khali@linux-fr.org> wrote:
>> I was also unable to find any /etc/sensors3.conf example that had this
>> laptop's hardware.
>
> As this is an Asus laptop, you might give a try to the asus_atk0110
> ACPI driver. It should load automatically though, and apparently it did
> not. Maybe your kernel is too old: you need kernel 2.6.30 or later, and
> I think Fedora 11 has 2.6.29.
>
> Or maybe your laptop simply doesn't implement the ATK0110 interface. In
> that case, the coretemp driver output is the best thing you can have on
> this laptop.

AFAIK notebooks do not have the ATK0110 hwmon interface (there's the
HID, but it's used for hotkeys and leds).
Usually all you can get on a notebook is what is provided by the
standard ACPI interface.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
