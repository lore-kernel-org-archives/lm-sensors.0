From: Juerg Haefliger <juergh@gmail.com>
Date: Tue, 18 Feb 2014 07:25:04 +0000
Subject: Re: [lm-sensors] Kernel errors for dme1737
Message-Id: <CADLDEKvXNPRqn9e=fxJjd0_L3VURWFpSnqDtYdvFpgsFawaE5g@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CADLDEKtzZeoOyyUGe7Rug8n-c0oZ_n8Cqd=HFpPZdZWgYmJARg@mail.gmail.com>
In-Reply-To: <CADLDEKtzZeoOyyUGe7Rug8n-c0oZ_n8Cqd=HFpPZdZWgYmJARg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, Feb 17, 2014 at 4:55 PM, Jean Delvare <jdelvare@suse.de> wrote:
>
> Hallo J=FCrgen,
>
> On Mon, 17 Feb 2014 15:33:18 +0100, J=FCrgen Fuchsberger wrote:
> > On 02/13/2014 08:32 AM, Jean Delvare wrote:
> > > In your case, the native drivers are i2c-nforce2, dme1737 and lm85,
and
> > > the native tool is "sensors". The IPMI driver would be ipmi-si if I
> > > remember correctly, and its tool is "ipmitool" or equivalent (there
are
> > > several IPMI packages out there, I don't know which ones are available
> > > to you.) If you have a BMC card in the machine, that card would be
> > > accessing the monitoring chips over IPMI as well so it will happen
even
> > > without any driver loaded.
> > >
> > > If you want to use IPMI (and if you have a BMC this is the only safe
> > > option), blacklist i2c-nforce2 and delete your lm_sensors
configuration
> > > file (typically /etc/sysconfig/lm_sensors on a sysconfig-based system,
> > > might be different on your distributions, e.g. on Debian you'd just
> > > delete the relevant modules from /etc/modules.) Then load ipmi-si and
> > > use ipmitool or whatever IPMI tool you have installed.
> >
> > OK, where should I blacklist i2c-nforce2?
>
> Add the following statement to any .conf file under /etc/modprobe.d:
>
> blacklist i2c-nforce2
>
> > impitool does not work:
> > wegc203094:/etc# ipmitool sensor
> > Could not open device at /dev/ipmi0 or /dev/ipmi/0 or /dev/ipmidev/0: No
> > such file or directory
> > Get Device ID command failed
> > Unable to open SDR for reading

$ modprobe ipmi_si
$ modprobe ipmi_devintf

> I can't help with that, sorry, I don't know much about IPMI.


> --
> Jean Delvare
> Suse L3 Support
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
