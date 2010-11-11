From: Luca Tettamanti <kronos.it@gmail.com>
Date: Thu, 11 Nov 2010 13:56:03 +0000
Subject: Re: [lm-sensors] IT8721F fan control?
Message-Id: <AANLkTinqwga4F5U+cGKmusQuHGA2GRTkSuLDzSkBLQM3@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101106002259.GA1871@hellug.gr>
In-Reply-To: <20101106002259.GA1871@hellug.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Mon, Nov 8, 2010 at 6:13 PM, Alexandros Diamantidis <adia@hellug.gr> wrote:
> * Luca Tettamanti [2010-11-08 13:53]:
>> > atk0110-acpi-0
>> > CPU Fan Speed:    675000 RPM  (min =  600 RPM)
>>
>> There's something wrong with the reading of this fan. Can you send me
>> a copy of the DSDT table (/sys/firmware/acpi/tables/DSDT)?
>
> Oops, I hadn't noticed that!
>
> In fact, that fan speed is usually read correctly, but intermittently
> jumps to some absurd value. I don't think it's a problem of the driver,
> since I see this in the BIOS "system info" screen as well.

Ok, then. The DSDT looks fine too :)

> For the moment I've disconnected the chassis fan because it was very
> distracting.

It should be controllable with QFan, no?

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
