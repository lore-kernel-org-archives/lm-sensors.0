From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 21 Sep 2008 15:06:21 +0000
Subject: Re: [lm-sensors] few information on gateway T-1625
Message-Id: <20080921170621.2edb7bf0@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <b69e42c40809071252l7b5dc005l5e99be4ce3a9b19@mail.gmail.com>
In-Reply-To: <b69e42c40809071252l7b5dc005l5e99be4ce3a9b19@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Andr=E9s,

On Sun, 7 Sep 2008 16:52:22 -0300, Andr=E9s Moreira wrote:
> Hi,
>  I recently bought a gateway T-1625 notebook and I want to know informati=
on
> about my fan. The fan is making a noise really annoying.
>=20
> the sensors output is:
>=20
> k8temp-pci-00c3
> Adapter: PCI adapter
> Core0 Temp:  +42.0=B0C
> Core0 Temp:  +39.0=B0C
> Core1 Temp:  +36.0=B0C
> Core1 Temp:  +39.0=B0C
>=20
> and the sensors-detect is :
>=20
> andres@atlantis:~$ sudo sensors-detect
> # sensors-detect revision 5016 (2007-11-11 22:20:16 +0100)
> (...)
> Driver `k8temp' (should be inserted):
>   Detects correctly:
>   * Chip `AMD K8 thermal sensors' (confidence: 9)
> (...)
> How can i do to set up my fan configs?

You most probably can't. It is very common that laptop do not have a
full-featured hardware monitoring chip, so there's nothing lm-sensors
can do. ACPI is taking care of all the thermal management instead. If
you think your fan misbehave, first thing to try is a BIOS upgrade if
available. If it doesn't help, you would report to the ACPI folks.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
