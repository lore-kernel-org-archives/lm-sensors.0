From: "Luca Tettamanti" <kronos.it@gmail.com>
Date: Tue, 02 Dec 2008 10:21:29 +0000
Subject: Re: [lm-sensors] New Asus board and multiple sensors chips
Message-Id: <68676e00812020221j1b2c5f42jd0fa58d255b19d03@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <48CA5C05.8040307@absence.it>
In-Reply-To: <48CA5C05.8040307@absence.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Nov 27, 2008 at 3:41 PM, Marco Chiappero <marco@absence.it> wrote:
>> Hum, anything in dmesg?
>> Anyway I'm attacching the new version (plus patch for ACPI - diffed
>> against git-current, but it's easily adapted to older kernels).
[...]
> I compiled and loaded the new atk driver and compiled again lm-sensors with
> the old patch (that was laying around in my /usr/src) and this time I
> managed to see the atk driver readings from the "sensors" output (don't know
> why it didn't work the first time, sorry). However I noticed that the code
> you posted recently it's a little bit different, isn't? Should I try that
> one too?

The patch for lm-sensors? I've just rebased to SVN-current.

> About the atk, it seems to work fine, but I haven't got the time to verify
> the presence of strange issues, regarding for example suspend and/or
> hibernate, stuff like that (does it matter?).

The driver is stateless, so it shouldn't matter (testing won't harm though :P)

> The only thing to say is that in the new code now shows all the readings in
> the /sys/class/hwmon/hwmonX/ dir instead of the
> /sys/class/hwmon/hwmonX/device/ I used to see with many other sensors chips.

Both are supported, I'm not sure which one is "better" - I used the
class directory since the ATK device also controls stuff other than
hwmon.

> I know that no fan control is possible with this driver, however I was
> asking to myself whether it is possible to select on the fly one of the
> three "silent, normal, turbo" profiles available in the BIOS settings. Even
> if it is not a fine fan tuning, such regulation should be enough for me.

It's doable using the Q-FAN interface. You use the interface calling
GITM/SITM with class 0x4 (see the documentation embedded in my
driver). There are at least 3 different types of control in this
class, you'll have to reverse engineer the exact calling interface
(start with the getters).

> One, last thing: I use to collect and plot system data with collectd and
> rrdtool, but collectd seems to ignore the atk driver. I know, I should read
> the code, however any idea for addressing this issue?

I suppose that collectd is using the unpatched libsensor which ignores
the ATK device (it's attached to the unknown ACPI bus).

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
