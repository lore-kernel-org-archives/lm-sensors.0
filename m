From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 08 Aug 2013 11:12:11 +0000
Subject: Re: [lm-sensors] Motherboard Fujitsu D-3076-S
Message-Id: <52037D0B.1080009@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <52035CE7.3060103@teamnet.de>
In-Reply-To: <52035CE7.3060103@teamnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

On 08/08/2013 01:05 PM, Holger B=FCrger wrote:
> Hi,
>
>> ...
>> ... 2.6.18 is quite old ...
>> ...
>
> I tried to compile this:
>
> "
> make -C /lib/modules/2.6.18-348.el5/build M=3D/root/test modules
> make[1]: Entering directory `/usr/src/kernels/2.6.18-348.12.1.el5-i686'
>    CC [M]  /root/test/sch56xx-common.o
> /root/test/sch56xx-common.c: In function =BBsch56xx_device_add=AB:
> /root/test/sch56xx-common.c:795: Fehler: Implizite Deklaration der
> Funktion =BBacpi_check_resource_conflict=AB
> make[2]: *** [/root/test/sch56xx-common.o] Fehler 1
> make[1]: *** [_module_/root/test] Fehler 2
> make[1]: Leaving directory `/usr/src/kernels/2.6.18-348.12.1.el5-i686'
> make: *** [all] Fehler 2
> "
>
> Is there a way to fix this?

Yes you can simply remove the line in question, and the 2 lines remove
it, so remove the following lines:

         err =3D acpi_check_resource_conflict(&res);
         if (err)
                 goto exit_device_put;

This is not something which I would normally advise, but at the
Fujitsu board in question it is safe to remove the check.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
