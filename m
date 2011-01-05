From: Luca Tettamanti <kronos.it@gmail.com>
Date: Wed, 05 Jan 2011 11:35:30 +0000
Subject: Re: [lm-sensors] Erratic value of MCH temp. (0C),
Message-Id: <AANLkTinrMyXbrOnM6TB+bc7eruT9xKvXL2CivTOZN_W+@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1294052867.1860.36.camel@Asus5>
In-Reply-To: <1294052867.1860.36.camel@Asus5>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Mon, Jan 3, 2011 at 12:07 PM, Joris Creyghton <jorisctn@gmail.com> wrote:
> Dear reader,
>
> Problem:
> The sensors command reports 0C for the MCH temp., while the BIOS gives a
> reasonable value of about 40C.
>
> Output of sensors command:
>
> joris@Asus5:~$ sensors
> atk0110-acpi-0
[...]
> MCH Temperature:     +0.0°C  (high = +60.0°C, crit = +95.0°C)

Is it always 0 or does it jump up and down?

Please send a copy of /sys/firmware/acpi/tables/DSDT

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
