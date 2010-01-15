From: Luca Tettamanti <kronos.it@gmail.com>
Date: Fri, 15 Jan 2010 13:38:32 +0000
Subject: Re: [lm-sensors] ATK0110 on older Asus board
Message-Id: <68676e01001150538n7c397f71r104d73b57d91eb65@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <52ae42fa1001140656w17e9e219lad760a0687db6b20@mail.gmail.com>
In-Reply-To: <52ae42fa1001140656w17e9e219lad760a0687db6b20@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, Jan 15, 2010 at 8:43 AM, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Karl,
> On Thu, 14 Jan 2010 08:12:33 -0800, Karl Newman wrote:
>> On Thu, Jan 14, 2010 at 7:19 AM, Jean Delvare <khali@linux-fr.org> wrote:
>> > On Thu, 14 Jan 2010 06:56:34 -0800, Karl Newman wrote:
>> > > I have a 4-year-old Asus A8N-VM CSM motherboard, which has a W83627E=
HG
>> > > chip for hardware monitoring. I recently upgraded to kernel 2.6.31 a=
nd
>> > > ran into the "Device or Resource busy" error when trying to load my
>> > > existing w83627ehf module. After some research, I discovered that I
>> > > should use the asus_atk0110 module instead. So, I updated my kernel
>> > > config to build that module and it will load with no problem, but
>> > > "sensors" is ignoring it. When I modprobe the module, it silently
>> > > succeeds (it's listed in lsmod) but there are no messages in dmesg or
>> > > the syslog to indicate any activity from the module,

The module is very quiet unless an error is detected (or debug is enabled).
I guess I could add a printk to let the user known that the driver is
loaded and functional.

>> > > which makes me
>> > > suspect that my board is not currently supported by this module. I d=
id
>> > > confirm that it has the atk0110 chip (ls /sys/bus/acpi/devices shows=
 a
>> > > ATK0110:00 entry). Am I doing something wrong, or do you need a DSDT
>> > > dump to support my motherboard, or...?
>> >
>> > Which version of lm-sensors are you running? "sensors -v" will tell
>> > you. Minimum version for asus_atk0110 support is 3.1.0, as documented
>> > on:
>> > =C2=A0http://www.lm-sensors.org/wiki/Devices
>>
>> Sorry, I forgot to mention that. I'm using 3.1.1 (sensors version 3.1.1 =
with
>> libsensors version 3.1.1), on Gentoo, along with kernel 2.6.31-gentoo-r6.
>
> OK, that would be a kernel-side problem then. I guess that you don't
> have a /sys/class/hwmon/hwmon* directory created for the asus_atk0110?
>
> I'm adding Luca to Cc, your best chance is probably to send him your
> DSDT in private and let him investigate.

I've never seen the DSDT of this board, so it's possible that it's
using a variation of the interface that is not handled by the driver.

L

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
