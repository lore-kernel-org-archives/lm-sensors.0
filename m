From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 27 Jun 2007 19:32:10 +0000
Subject: Re: [lm-sensors] gigabyte GA-8IE
Message-Id: <20070627213210.323306e0@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <c823af600706200358j5c64468cy2011ba72deecbf45@mail.gmail.com>
In-Reply-To: <c823af600706200358j5c64468cy2011ba72deecbf45@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, 20 Jun 2007 12:58:35 +0200, Bal=E1zs H=E1morszky wrote:
> I can't get lm-sensors working on GA-8IE
> http://www.gigabyte.com.tw/Support/Motherboard/BIOS_Model.aspx?ProductID=
=1320
> (i have the latest bios version)
> it seems it have Both ITE8702 and ITE8712

Very unlikely, as both are Super-I/O chips and it doesn't make sense to
have two such chips on the same board.

> but sensors-detect can't find ITE8712
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `ITE'...                                      Yes
> Found `ITE IT8702F Super IO Sensors'                        Success!
>     (address 0x290, driver `to-be-written')
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Fintek'...                       No
> Probing for Super-I/O at 0x4e/0x4f
> Trying family `ITE'...                                      No
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Fintek'...                       No
>=20
> # modprobe it87
> FATAL: Error inserting it87
> (/lib/modules/2.6.21-1-686/kernel/drivers/hwmon/it87.ko): No such device

The it87 driver supports several devices of the ITE IT87xxF family, but
not the IT8702F. That's a rare chip, which only offers fan speed
monitoring (as far as sensors are concerned.) We don't support it yet.

> and acpi say
> No support for device type: thermal
>=20
> so I can't get the cpu temp.

The IT8702F wouldn't give it to you, even if we had support. What makes
you think that this relatively old motherboard actually supports
temperature monitoring? Does the BIOS display temperature values?

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
