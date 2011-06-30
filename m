From: Luca Tettamanti <kronos.it@gmail.com>
Date: Thu, 30 Jun 2011 10:15:55 +0000
Subject: Re: [lm-sensors] asus_atk0110 and suspend-to-disk
Message-Id: <CAKPcRGpjOKawNWF4=39=4wAPA_ZUFc_Aw=6zx8+eD3XndVTODg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110617205743.28aaf44a@endymion.delvare>
In-Reply-To: <20110617205743.28aaf44a@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jun 28, 2011 at 6:30 PM, Jean Delvare <khali@linux-fr.org> wrote:
>> # chassis
>> echo 0x04070070 > /sys/kernel/debug/asus_atk0110/id
>> cat /sys/kernel/debug/asus_atk0110/gitm
>
> cat: /sys/kernel/debug/asus_atk0110/gitm: Input/output error
>
>> echo 0x04070071 > /sys/kernel/debug/asus_atk0110/id
>> cat /sys/kernel/debug/asus_atk0110/gitm
>
> cat: /sys/kernel/debug/asus_atk0110/gitm: Input/output error

Ok, no chassis fan control.

> Results are the same before suspend to disk and after resume.
>
> Do you know if gitm reads from the hardware directly or from a cache in
> memory?

Not cached, the read method pokes an ioport (0xb2 - field called SMIC
- I guess it's system management IC), and reads back a value from the
memory. This is the Q-FAN setting though, probably read from the
non-volatile store, the hwmon chip is not queried directly (nor
programmed AFAICS). My guess is that at boot the BIOS reads the
settings a programs the chip - and forget do it when coming out from
S4; did you try and change the shutdown method? i.e.:

echo shutdown > /sys/power/disk

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
