From: Juerg Haefliger <juergh@gmail.com>
Date: Mon, 17 Feb 2014 14:42:17 +0000
Subject: Re: [lm-sensors] Kernel errors for dme1737
Message-Id: <CADLDEKvpQpBJCSNNVadu_50EA0Xdv-9SnZ6aeDYH7rML8eXKpg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CADLDEKtzZeoOyyUGe7Rug8n-c0oZ_n8Cqd=HFpPZdZWgYmJARg@mail.gmail.com>
In-Reply-To: <CADLDEKtzZeoOyyUGe7Rug8n-c0oZ_n8Cqd=HFpPZdZWgYmJARg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, Feb 17, 2014 at 3:33 PM, J=FCrgen Fuchsberger <
juergen.fuchsberger@uni-graz.at> wrote:
>
>
>
> On 02/13/2014 08:32 AM, Jean Delvare wrote:
> > Hi J=FCrgen,
> >
> > On Thu, 13 Feb 2014 07:39:04 +0100, J=FCrgen Fuchsberger wrote:
> >>>> The board supports IPMI. I would guess that the errors happen when
the
> >>>> native driver and IPMI attempt to access the SMBus at the same time.
> >>>
> >>> Yes, that would explanin the problem.
> >>
> >>>> As usual, my recommendation is to either use IPMI or native drivers
but
> >>>> not mix.
> >>>
> >>> Agreed.
> >>
> >> OK, how can I choose which driver to use?
> >
> > In your case, the native drivers are i2c-nforce2, dme1737 and lm85, and
> > the native tool is "sensors". The IPMI driver would be ipmi-si if I
> > remember correctly, and its tool is "ipmitool" or equivalent (there are
> > several IPMI packages out there, I don't know which ones are available
> > to you.) If you have a BMC card in the machine, that card would be
> > accessing the monitoring chips over IPMI as well so it will happen even
> > without any driver loaded.
> >
> > If you want to use IPMI (and if you have a BMC this is the only safe
> > option), blacklist i2c-nforce2 and delete your lm_sensors configuration
> > file (typically /etc/sysconfig/lm_sensors on a sysconfig-based system,
> > might be different on your distributions, e.g. on Debian you'd just
> > delete the relevant modules from /etc/modules.) Then load ipmi-si and
> > use ipmitool or whatever IPMI tool you have installed.
>
> OK, where should I blacklist i2c-nforce2?
>
> impitool does not work:
> wegc203094:/etc# ipmitool sensor
> Could not open device at /dev/ipmi0 or /dev/ipmi/0 or /dev/ipmidev/0: No
> such file or directory

Did you try to load the ipmi driver(s)? What do you get in the logs?

...Juerg


> Get Device ID command failed
> Unable to open SDR for reading
>
> Best,
> Juergen
>
> >
>
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
