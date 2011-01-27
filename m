From: Phillip Susi <psusi@cfl.rr.com>
Date: Thu, 27 Jan 2011 18:47:39 +0000
Subject: Re: [lm-sensors] Identifying i2c devices on Asus P8P67 sandybridge
Message-Id: <4D41BDCB.4020205@cfl.rr.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D40E39E.4030406@cfl.rr.com>
In-Reply-To: <4D40E39E.4030406@cfl.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On 1/27/2011 12:14 PM, Jean Delvare wrote:
> Does ACPI allow reporting an unlimited number of voltage values? Does
> ACPI allow reporting an unlimited number of fan speeds? Reporting of
> temperature values with a resolution better than 1=B0C? Setting low and
> high limits for each of these items?

From what I have read so far, the TZ sets temperature thresholds at
which the various fan settings should kick in.  The resolution may have
only been in whole degrees, but that doesn't seem to be a problem to me.

> Wow, you are pretty optimistic. A board vendor accepting code from
> external contributors? I bet I will be dead before this happens.

Admittedly it's a long shot.  I also figured it would be a good learning
experience ;)

> I wholeheartedly agree that pwmconfig and fancontrol suck. They are
> afternoon hacks that have grown too old, and I wouldn't recommend
> anyone to use them. I wish someone interested would write a proper tool
> (i.e. not written in bash to start with) to deal with manual fan speed
> control. And automatic fan speed control, too.

Frequency control started off in user space too, then moved to the
kernel.  Maybe it is time for the same to be done with fan speed.  A
generic fan control driver could be written to interface with the hwmon
devices.

The problem is that it still would require manual configuration of which
temperature sensors should govern which fan pwm controls, since the
platform does not provide that information.

> And even with the two statements above, I still claim that native
> hwmon drivers are doing a much better job than any ACPI implementation
> I've seen. And don't believe it makes me happy: I would love all
> systems to have hardware monitoring support working out of the box
> thanks to a brilliant ACPI specification and no-less brilliant
> implementations. But I don't expect this to happen any time soon :(

Indeed.  It seems to me that vendors just don't care to do it right in
the standard way since they can just ship a windows driver that will
make 99% of their customers happy.  That is another reason I was
wondering about doing it with an SSDT.  If I could, it would show
clearly that it CAN be done, and pressure could be put on vendors to
start doing it the right way.

>> It should be 6-8-6-24.
>=20
> Really? Is this what memtest86 is report? It's a long time since I last
> saw a memory module with the 3 first digits not being the same.

It is what the MFR specs say.  I haven't run a memtest86 on it, but I
think the bios detected and used those values.  I'll double check it
tonight and maybe run a memtest.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
