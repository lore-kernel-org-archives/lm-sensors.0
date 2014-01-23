From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 23 Jan 2014 04:59:30 +0000
Subject: Re: [lm-sensors] sensors
Message-Id: <52E0A1B2.50602@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.21.0207072332570.12801-100000@ond.vein.hu>
In-Reply-To: <Pine.LNX.4.21.0207072332570.12801-100000@ond.vein.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On 01/22/2014 03:27 PM, Ryan wrote:
> hello,
>
> I'm having an issue getting the correct output from sensors on my asus
> laptop.  I'm running xubuntu on it and I've attached the following files
> hoping it gives you all the information you may need.
>
> grub                       - my /etc/default/grub
> modules_file.txt     - my /etc/modules
> sensors_output.txt - output from running 'sudo sensors'
> lshw_short.txt        - hardware information from lshw command
>
> Please let me know if you need more information and thank you for your
> time.  I greatly appreciate any advise.
>

Hi Ryan,

please don't use attachments when posting. It makes it difficult to reply.

 > acpitz-virtual-0
 > Adapter: Virtual device
 > temp1:       +101.0=B0C  (crit =3D +108.0=B0C)

This temperature is reported by ACPI, or in other words by the BIOS, and
suggests that the system is running really hot (unlikely) or that the BIOS
has a bug. Do you have the latest BIOS installed ?

 > coretemp-isa-0000
 > Adapter: ISA adapter
 > Core 0:       +33.0=B0C  (high =3D +95.0=B0C, crit =3D +105.0=B0C)
 > Core 2:       +27.0=B0C  (high =3D +95.0=B0C, crit =3D +105.0=B0C)

This looks ok.

 > radeon-pci-0100
 > Adapter: PCI adapter
 > temp1:       -128.0=B0C  (crit =3D +120.0=B0C, hyst =3D +90.0=B0C)

This suggests that there is either no temperature sensor attached to
the graphics adapter (that is most likely), or that it is broken.

Guenter




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
