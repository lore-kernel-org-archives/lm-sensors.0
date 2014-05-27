From: Kenny Lake <kennylake96@yahoo.it>
Date: Tue, 27 May 2014 21:13:17 +0000
Subject: Re: [lm-sensors] info about  driver for chip EMC1402
Message-Id: <1401225197.5056.YahooMailNeo@web172002.mail.ir2.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1401139433.59243.YahooMailNeo@web172006.mail.ir2.yahoo.com>
In-Reply-To: <1401139433.59243.YahooMailNeo@web172006.mail.ir2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Jean
I know that I have a EMC1402 chip because this is what the "sensors-detect"=
 command report:
Driver `to-be-written':
=A0 * Bus `SMBus PIIX4 adapter at 0b00'
=A0=A0=A0 Busdriver `i2c_piix4', I2C address 0x4c
=A0=A0=A0 Chip `SMSC EMC1402' (confidence: 6)
Driver `adm1021':
=A0 * Bus `SMBus PIIX4 adapter at 0b00'
=A0=A0=A0 Busdriver `i2c_piix4', I2C address 0x4e
=A0=A0=A0 Chip `Maxim MAX1617' (confidence: 3)
Driver `k10temp' (autoloaded):
=A0 * Chip `AMD Family 11h thermal sensors' (confidence: 9)
Note: there is no driver for SMSC EMC1402 yet.


I searched around but I haven't found a specific vendor's driver for my lap=
top (HP 6735s) and ACPI has a strange behavior: rarelly, when I turn on my =
laptop, the fan works, but 90% it doesn't start except when temp is around =
85 celsius. I have already tried all boot options (acpi=3Dforce, acpi=3Doff=
, acpi=3Dosi_Linux, acpi_enforce_resources=3Dlax) but without succes.=20



Il Marted=EC 27 Maggio 2014 8:53, Jean Delvare <jdelvare@suse.de> ha scritt=
o:
=20


Hi Guenter, Kenny,

On Mon, 26 May 2014 17:15:54 -0700, Guenter Roeck wrote:
> On 05/26/2014 02:23 PM, Kenny Lake wrote:
> > I have serious temp problem with my laptop, it has a EMC1402 chip and I=
 would like to know if is there any new driver=A0 that I can try to use.
> > Thanks
>=20
> A patch to add suport for this chip is pending for integration into the 3=
.16 kernel.
> It is available in the linux-next repository. Can you use that ?

On laptops it is almost never possible to access monitoring chips
directly, one has to go through ACPI or a vendor-specific layer. So
Kenny should prepare himself to the idea that the emc1403 driver in
linux-next will most likely not work. But it's certainly worth a try
anyway.

Kenny, how do you know that your laptop has an EMC1402 chip? Doesn't
the ACPI thermal driver work for you? Did you try the vendor-specific
driver for your laptop? Some of them (asus-wmi, compal-laptop,
eeepc-laptop and thinkpad_acpi) provide temperature readings.

--=20
Jean Delvare
SUSE L3 Support
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
