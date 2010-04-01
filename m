From: Luca Tettamanti <kronos.it@gmail.com>
Date: Thu, 01 Apr 2010 20:34:39 +0000
Subject: Re: [lm-sensors] lm-sensors with ASUS P6TD Deluxe and Ubuntu 9.04
Message-Id: <y2i68676e01004011334n41b3d36ez9ff6c5bc4a6b9205@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <000001cad1d0$d5ea3820$81bea860$@org.uk>
In-Reply-To: <000001cad1d0$d5ea3820$81bea860$@org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Please keep the list in CC.

On Thu, Apr 1, 2010 at 9:59 PM, Jon & Lisa Williams
<jon-lisa@doctors.org.uk> wrote:
> On Thu, Apr 1, 2010 at 9:23 PM, Jon & Lisa Williams
> <jon-lisa@doctors.org.uk> wrote:
>>> someone on the
>>> official Folding Forum has said that even this doesn’t support the P6TD – is
>>> that right?
>>
>> asus_atk0110 driver should be able to handle the monitoring (but it
>> does not support direct fan control); if it doesn't work please report
>> back so I can fix it :-)
>
> Is there a 'crib sheet' or 'how to' that describes the process required
> to fix things with the asus_atk0110 driver - the 'in-and-outs' of Linux
> are not my strong point - I'm more of a Linux n00b!!

If your kernel is recent enough (which version are you currently
using?) you can load the driver with "modprobe asus_atk0110"; the
module should be inserted automagically though, can you check whether
it's already there or not (lsmod)?
If "sensors" still reports nothing - even after loading the driver
manually - please include the output of "ls -l /sys/class/hwmon/",
dmesg and a copy of the DSDT (/sys/firmware/acpi/tables/DSDT).

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
