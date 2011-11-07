From: =?ISO-8859-1?Q?Lars_Nood=E9n?= <lars.nooden@gmail.com>
Date: Mon, 07 Nov 2011 12:13:08 +0000
Subject: Re: [lm-sensors] Hardware running hot and without the fan
Message-Id: <4EB7CB54.7020207@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4EB1108F.6070009@gmail.com> <20111103020301.GA22333@ericsson.com> <4EB250FD.3070000@gmail.com> <20111103134902.GA26121@ericsson.com> <4EB2A46B.8080600@gmail.com> <1320332801.2309.60.camel@groeck-laptop> <4EB2B0FD.309@gmail.com> <20111103174635.GA12229@polaris.bitmath.org>
In-Reply-To: <20111103174635.GA12229@polaris.bitmath.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Henrik Rydberg <rydberg@euromail.se>
Cc: guenter.roeck@ericsson.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On 11/3/11 7:46 PM, Henrik Rydberg wrote:
[snip]
> I am confused.
>=20
> From what I gather, the fans work, and it should be possible to run
> the macfanctld daemon (not fancontrol) to tune the fans.
>
> If there really is a problem with the applesmc, following
> http://ubuntuforums.org/showthread.php?t=924096 is a good idea.
>=20
> However, the root problem is most likely the GPU consuming too much
> power. Depending on the exact laptop model, there may or may not be a
> viable workaround. If you model is very new, there is most likely and
> active thread about it on the ubuntu forums.

Not that I could find, at least not useful ones.
Starting a new thread gained no results.

> After checking around on the forums, if you find that this is still a
> fan or temperature sensor problem, and not a GPU problem, then please
> restate the problem as exactly as you can.

Can it be both a fan / sensor / GPU problem?
To restate the symptoms:

- the hardware runs hot in Linux, the same hardware runs cool in OS X
- the fan(s) do not run automatically when the machines get hot
- the fan(s) can be controlled manually
- the temperatures from /usr/bin/sensors on the notebook seem
  suspiciously low

The kernels are

- 3.1.0-999-generic #201111070407 SMP Mon Nov 7
  09:08:05 UTC 2011 x86_64 x86_64 x86_64 GNU/Linux

- 3.1.0-2-generic #3-Ubuntu SMP Fri Oct 28
  20:28:07 UTC 2011 i686 i686 i386 GNU/Linux

Output from apport can be found in Launchpad:

 https://bugs.launchpad.net/ubuntu/+source/linux/+bug/881593

The notebook is a MacBookPro8,2 and the desktop is a Macmini3,1

How should I split the problem up and where should I pursue their
resolution?

/Lars

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
