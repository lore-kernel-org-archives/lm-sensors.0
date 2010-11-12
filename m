From: Luca Tettamanti <kronos.it@gmail.com>
Date: Fri, 12 Nov 2010 13:13:52 +0000
Subject: Re: [lm-sensors] IT8721F fan control?
Message-Id: <AANLkTikVLUZVo-uLmoRebRoOtZJ39S4JNn0AXyoD2BSY@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101106002259.GA1871@hellug.gr>
In-Reply-To: <20101106002259.GA1871@hellug.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Nov 12, 2010 at 12:23 AM, Alexandros Diamantidis <adia@hellug.gr> wrote:
> * Luca Tettamanti [2010-11-11 14:56]:
>> > For the moment I've disconnected the chassis fan because it was very
>> > distracting.
>>
>> It should be controllable with QFan, no?
>
> Do you mean the BIOS Q-Fan option? It only mentions a "CPU Q-Fan", which
> is enabled and doesn't seem to do much for the front fan. The other two
> fans indeed aren't so loud, so it probably works for them. Could that
> mean that the front fan speed isn't controllable at all by the hardware?

They are probably controllable, but the control is not implemented in
the firmware. My board (M4A79XTD) also has a Q-Fan options for the
chassis fan.

> Since even with Q-Fan enabled it's not as quiet as I'd like and
> temperatures don't rise much even under full load, I'd be nice if fans
> could go even slower if possible. My initial message was mostly a query
> about whether the native driver will allow this when complete.

The problem with the native driver is that it uses resources that are
claimed by ACPI, which might be unsafe.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
