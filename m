From: Luca Tettamanti <kronos.it@gmail.com>
Date: Wed, 28 Apr 2010 12:24:19 +0000
Subject: Re: [lm-sensors] asus_atk0110 Not Activated in lm_sensors-3.1.1-3
Message-Id: <s2p68676e01004280524w93c9234az452c4e30ac73e392@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Apr 28, 2010 at 1:41 PM, Jean Delvare <khali@linux-fr.org> wrote:
>> Runnig Rehat Fedora Core 12 with an Asus k8n-dre motherboard.
[...]
> On a recent Asus desktop board, I suspect that you have to use the
> asus_atk0110 driver for (ACPI-based) monitoring. It is even supposed to
> load automatically.
[...]
> Please also try loading the asus_atk0110 driver manually, and see what
> happens. Report the messages from the kernel logs if there are any.

It it doesn't work please send me a copy of the DSDT and if possible
enable HWMON_DEBUG_CHIP.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
