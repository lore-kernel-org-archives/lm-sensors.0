From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 25 Oct 2008 12:43:11 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] k8temp warn about errata
Message-Id: <20081025144311.776b7e68@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <48E3F505.40401@assembler.cz>
In-Reply-To: <48E3F505.40401@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Rudolf,

On Thu, 02 Oct 2008 00:09:09 +0200, Rudolf Marek wrote:
> Following patch adds warning about wrong CPU temperature readouts on all =
fam f
> rev f revision of CPUs.
>=20
> Used switch statement, more code changes follows.
>=20
> Signed-off-by: Rudolf Marek <r.marek@assembler.cz>
>=20
> It should "fix" http://bugzilla.kernel.org/show_bug.cgi?id=8866

Thanks for working on this. Review:

> Index: linux-2.6.27-rc7/drivers/hwmon/k8temp.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- linux-2.6.27-rc7.orig/drivers/hwmon/k8temp=
.c	2008-09-28 11:01:45.855284456 +0200
> +++ linux-2.6.27-rc7/drivers/hwmon/k8temp.c	2008-09-28 11:13:42.396117790=
 +0200
> @@ -34,6 +34,7 @@
> =20
>  #define TEMP_FROM_REG(val)	(((((val) >> 16) & 0xff) - 49) * 1000)
>  #define REG_TEMP	0xe4
> +#define REG_CPUID	0xfc
>  #define SEL_PLACE	0x40
>  #define SEL_CORE	0x04
> =20
> @@ -47,6 +48,7 @@
>  	/* registers values */
>  	u8 sensorsp;		/* sensor presence bits - SEL_CORE & SEL_PLACE */
>  	u32 temp[2][2];		/* core, place */
> +	u8 fam;
>  };
> =20
>  static struct k8temp_data *k8temp_update_device(struct device *dev)
> @@ -141,6 +143,7 @@
>  	int err;
>  	u8 scfg;
>  	u32 temp;
> +
>  	struct k8temp_data *data;
>  	u32 cpuid =3D cpuid_eax(1);
> =20

Unrelated whitespace change, please revert.

> @@ -155,6 +158,18 @@
>  		goto exit;
>  	}
> =20
> +	/* get real PCI based cpuid, prior revF of fam 0Fh, this reg is 0 */

That's tricky. It took me some time to figure out why the warning
wouldn't be displayed on all family 0Fh CPUs ;)

> +	pci_read_config_dword(pdev, REG_CPUID, &cpuid);
> +
> +	data->fam =3D (cpuid & 0x00000f00) >> 8;
> +	data->fam +=3D (cpuid & 0x00f00000) >> 20;

The extended family code is an 8-bit value, so this should be:

+	data->fam +=3D (cpuid & 0x0ff00000) >> 20;

I don't know if the result is guaranteed to fit in a u8.

> +
> +	switch (data->fam) {
> +		case 0xf:

Coding style: case is normally aligned on switch (see Chapter 1:
Indentation of Documentation/CodingStyle.)

> +			dev_warn(&pdev->dev, "Temperature readouts might be wrong"
> +						" - check errata #141\n");
> +	}
> +
>  	pci_read_config_byte(pdev, REG_TEMP, &scfg);
>  	scfg &=3D ~(SEL_PLACE | SEL_CORE);		/* Select sensor 0, core0 */
>  	pci_write_config_byte(pdev, REG_TEMP, scfg);

This is a good start, but I don't think this is enough. I don't expect
desktop users to search the kernel logs for that kind of information.
The situation is made worse by the fact that the k8temp driver is one
of the few hwmon drivers which auto-loads, so many users see the
reported temperature, not just those who ran sensors-detect. So I'd
rather implement a more "active" mechanism. I have several ideas in
mind and would welcome comments on them.

If all revision F and later CPUs are affected by the errata and the
temperature reported is never correct, we should simply blacklist these
CPUs. I guess this isn't the case, otherwise you'd have proposed that
we do that long ago.

If most but not all of these CPUs are affected, then it would make
sense to disable them by default but give the user a chance to still
enable them (using a module parameter.)

If there are more revision F and later CPUs with working thermal
diodes, and working ones can be told from non-working ones based on the
exact revision, we could implement blacklisting and/or whitelisting
base on the revision.

Does anyone have an idea about the ratio of working/broken revision F
and later CPU models?

Does the status (broken or not) of the thermal diode depend on the
exact CPU revision, or is it purely random?

Alternatively, or additionally, we could use a heuristic to detect
broken diodes. I don't much like this in general, as monitoring should
normally not assume anything on what it is monitoring, but in this
specific case I think it makes some sense because the thermal sensor in
question is not a generic chip and brokenness is so widely spread.

When looking at reports for broken K8 diodes, for example at:
http://bugzilla.kernel.org/show_bug.cgi?id=8866
it is immediately visible to a human that:

k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:  +17 C
Core0 Temp:   +3 C
Core1 Temp:  +21 C
Core1 Temp:   +5 C

are NOT reasonable temperatures for a CPU.

Other obviously wrong outputs (gathered on the lm-sensors mailing list):

k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:   +4=B0C
Core0 Temp:   -1=B0C
Core1 Temp:   -2=B0C
Core1 Temp:  -20=B0C

k8temp-pci-00c3
Adapter: PCI adapter
temp1:        -9=B0C
temp2:       -20=B0C
temp3:       -18=B0C
temp4:       -14=B0C

k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:    -6=B0C
Core0 Temp:   -11=B0C
Core1 Temp:    +5=B0C
Core1 Temp:   -13=B0C

k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:   -1=B0C
Core0 Temp:   +1=B0C
Core1 Temp:   +6=B0C
Core1 Temp:   +6=B0C

k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:   +9=B0C
Core0 Temp:   +0=B0C
Core1 Temp:   +3=B0C
Core1 Temp:  +11=B0C

The following outputs, OTOH, look pretty good (also gathered on the
lm-sensors mailing list):

k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:  +42.0=B0C
Core0 Temp:  +39.0=B0C
Core1 Temp:  +36.0=B0C
Core1 Temp:  +39.0=B0C

k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:  +43.0=B0C
Core1 Temp:  +37.0=B0C

k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:  +41.0=B0C
Core1 Temp:  +46.0=B0C

k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:  +38.0=B0C
Core1 Temp:  +25.0=B0C

k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:  +31.0=B0C
Core1 Temp:  +32.0=B0C

k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:  +32=B0C
Core1 Temp:  +35=B0C

k8temp-pci-00c3
Adapter: PCI adapter
Core1 Temp:   +43=B0C
Core2 Temp:   +46=B0C

There were also a few reports which I'm not sure if there are good or
bad:

k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:  +26 C
Core1 Temp:  +24 C

k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:  +17=B0C
Core1 Temp:  +25=B0C

So I am under the impression that it should not be too difficult to
come up with a heuristic to spot obviously broken sensors:
* Apparently all affected CPUs have 4 thermal sensors (I don't know if
  this is because all revision F and later CPUs have 4 thermal sensors?)
* Average of the 4 sensors is below 15 degrees C.
* Minimum of the 4 sensors is below 5 degrees C

So we could build a heuristic based on the number of sensors and either
the average or the minimum temperature and reject by default all
revision F and later CPUs which do not pass the test. We would of
course provide a way (module parameter) for the user to change the
temperature limit or maybe disable the heuristic entirely.

Of course this isn't a perfect solution, as there are still CPUs in the
gray zone for which no heuristic can say whether they are good or bad.
Also, there is a small risk that a CPU which is at the limit will be
rejected sometimes but not always, so hwmon device numbering may change
from one boot to the next. However, I think that a good heuristic would
solve way more problems than it would cause.

Comments anyone?

Thanks,
--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
