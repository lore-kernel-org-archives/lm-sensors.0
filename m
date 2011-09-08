From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 08 Sep 2011 18:07:33 +0000
Subject: Re: [lm-sensors] Fintek F71862FG Super IO Sensors only shows
Message-Id: <4E690465.5010104@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAPtvKsNGD2fY1Fo7BSLRqVVU+92Rh0YyfMbdD2FBFpu=bHhCng@mail.gmail.com>
In-Reply-To: <CAPtvKsNGD2fY1Fo7BSLRqVVU+92Rh0YyfMbdD2FBFpu=bHhCng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi,

On 09/08/2011 03:11 PM, Daniel Schenkenberger wrote:
> sensors detect my chip but he only shows the core temp.
>
> sensors-detect:
>
> mezo@vdr:~$ sudo sensors-detect[sudo] password for mezo:
> # sensors-detect revision 5861 (2010-09-21 17:21:05 +0200)
> # System: OEM OEM
> # Board: PCPartner G43-F71862
>

<Snip>

> Driver `coretemp':
>    * Chip `Intel digital thermal sensor'  (confidence: 9)
>
> Driver `f71882fg':
>    * ISA bus, address 0x295
>      Chip `Fintek F71862FG Super IO Sensors'  (confidence: 9)

<Snip>

> sensors show me only:
>
>   mezo@vdr:/etc/sensors.d$ sensors
> acpitz-virtual-0
> Adapter: Virtual device
> temp1:       +40.0°C  (crit = +127.0°C)
>
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +55.0°C  (high = +80.0°C, crit = +100.0°C)
>
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 1:      +55.0°C  (high = +80.0°C, crit = +100.0°C)
>

Hmm, that is weird. Likely the problem is that
the kernel driver finds the device and thus the module
loads, and then during driver initialization it finds something
it does not like so it does not bind to the platform device
created during the probing phase.

Can you please do (as root):
rmmod f71882fg
modprobe f71882fg
dmesg

And then send a reply with the last few lines of the dmesg output
(All the ones referring to the f71882fg driver).

Thanks,

Hans




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
