From: Luca Tettamanti <kronos.it@gmail.com>
Date: Mon, 08 Nov 2010 12:53:52 +0000
Subject: Re: [lm-sensors] IT8721F fan control?
Message-Id: <AANLkTimE2LbMpHb7XrjX7exHizbXDs0hbRYyssbpukd3@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101106002259.GA1871@hellug.gr>
In-Reply-To: <20101106002259.GA1871@hellug.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi,
I can't comment on the native driver, but:

On Sat, Nov 6, 2010 at 1:22 AM, Alexandros Diamantidis <adia@hellug.gr> wrote:
> atk0110-acpi-0
> Adapter: ACPI interface
> Vcore Voltage:     +1.31 V  (min =  +0.80 V, max =  +1.60 V)
> +3.3V Voltage:     +3.31 V  (min =  +2.97 V, max =  +3.63 V)
> +5V Voltage:       +4.93 V  (min =  +4.50 V, max =  +5.50 V)
> +12V Voltage:     +12.05 V  (min = +10.20 V, max = +13.80 V)
> CPU Fan Speed:    675000 RPM  (min =  600 RPM)

There's something wrong with the reading of this fan. Can you send me
a copy of the DSDT table (/sys/firmware/acpi/tables/DSDT)?

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
