From: "J, KEERTHY" <j-keerthy@ti.com>
Date: Tue, 03 May 2011 19:51:53 +0000
Subject: Re: [lm-sensors] [PATCH 0/2 v5] twl4030-madc driver
Message-Id: <BANLkTi=zt1j_s1uDfjL=SRG6_LS1pa3xAg@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="20cf301cc4828fe9f804a2646fb6"
List-Id: <lm-sensors.vger.kernel.org>
References: <1298986926-31180-1-git-send-email-j-keerthy@ti.com>
	<20110302101512.GC16181@sortiz-mobl>
	<BANLkTimc6uz353DDb9Ent6s6WjfY7f-xuA@mail.gmail.com>
In-Reply-To: <BANLkTimc6uz353DDb9Ent6s6WjfY7f-xuA@mail.gmail.com>
To: Steve Sakoman <sakoman@gmail.com>
Cc: lm-sensors@lm-sensors.org, guenter.roeck@ericsson.com, mikko.k.ylinen@nokia.com, amit.kucheria@canonical.com, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>

--20cf301cc4828fe9f804a2646fb6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Steve,

Can you try adding this patch?

Regards,
Keerthy

On Tue, May 3, 2011 at 8:44 PM, Steve Sakoman <sakoman@gmail.com> wrote:
> On Wed, Mar 2, 2011 at 2:15 AM, Samuel Ortiz <sameo@linux.intel.com> wrot=
e:
>> Hi Keerthy,
>>
>> On Tue, Mar 01, 2011 at 07:12:06PM +0530, Keerthy wrote:
>>> MADC(Monitoring ADC) driver enables monitoring analog signals using
>>> analog-to-digital conversion (ADC) on the input source.
>>> The previous discussion concluded in keeping the generic ADC
>>> functionality and the hwmon separate. The discussion can be found here:
>>>
>>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41805.html
>> Thanks a lot, I applied those 2 patches.
>
> I'm attempting to use this drive on the Overo platform with 2.6.39-rc5.
>
> Other than enabling the module with CONFIG_SENSORS_TWL4030_MADC=3Dm are
> there any board file modifications required other than the below?
>
> I have setup the platform data for the twl4030 madc driver:
>
> diff --git a/arch/arm/mach-omap2/board-overo.c
> b/arch/arm/mach-omap2/board-overo.c
> index 112dfc9..05dd3eb 100644
> --- a/arch/arm/mach-omap2/board-overo.c
> +++ b/arch/arm/mach-omap2/board-overo.c
> @@ -637,10 +637,15 @@ static struct twl4030_codec_data overo_codec_data =
=3D {
> =A0 =A0 =A0 =A0.audio =3D &overo_audio_data,
> =A0};
>
> +static struct twl4030_madc_platform_data overo_madc_data =3D {
> + =A0 =A0 =A0 .irq_line =A0 =A0 =A0 =3D 1,
> +};
> +
> =A0static struct twl4030_platform_data overo_twldata =3D {
> =A0 =A0 =A0 =A0.irq_base =A0 =A0 =A0 =3D TWL4030_IRQ_BASE,
> =A0 =A0 =A0 =A0.irq_end =A0 =A0 =A0 =A0=3D TWL4030_IRQ_END,
> =A0 =A0 =A0 =A0.gpio =A0 =A0 =A0 =A0 =A0 =3D &overo_gpio_data,
> + =A0 =A0 =A0 .madc =A0 =A0 =A0 =A0 =A0 =3D &overo_madc_data,
> =A0 =A0 =A0 =A0.usb =A0 =A0 =A0 =A0 =A0 =A0=3D &overo_usb_data,
> =A0 =A0 =A0 =A0.codec =A0 =A0 =A0 =A0 =A0=3D &overo_codec_data,
> =A0 =A0 =A0 =A0.vmmc1 =A0 =A0 =A0 =A0 =A0=3D &overo_vmmc1,
>
> However, I am not seeing the sysfs entry created:
>
> # modprobe twl4030-madc-hwmon
> twl4030_madc_hwmon_init entry
>
> # lsmod
> Module =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Size =A0Used by
> twl4030_madc_hwmon =A0 =A0 =A02594 =A00
> ipv6 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0224256 =A016
> libertas_sdio =A0 =A0 =A0 =A0 =A014867 =A00
> libertas =A0 =A0 =A0 =A0 =A0 =A0 =A0 92429 =A01 libertas_sdio
> cfg80211 =A0 =A0 =A0 =A0 =A0 =A0 =A0144256 =A01 libertas
> lib80211 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A05027 =A01 libertas
> firmware_class =A0 =A0 =A0 =A0 =A05859 =A02 libertas_sdio,libertas
>
> # ls /sys/class/hwmon/
> #
>
> I added a couple of printk's to the driver at the entry points of init
> and probe, and as you can see above the init message is printed, but
> not the probe.
>
> Am I missing something really obvious here?
>
> Steve
>

--20cf301cc4828fe9f804a2646fb6
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001-Enabling-Hwmon-driver-for-twl4030-madc.patch"
Content-Disposition: attachment; 
	filename="0001-Enabling-Hwmon-driver-for-twl4030-madc.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gn993rvg0

RnJvbSBhMDVjNmNiYjQ0OTQxNzNlMDNlYTU5NTc2NjYyMTZjYWVkYjIyZDg0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLZWVydGh5IDxqLWtlZXJ0aHlAdGkuY29tPgpEYXRlOiBXZWQs
IDQgTWF5IDIwMTEgMDE6MTQ6NTAgKzA1MzAKU3ViamVjdDogW1BBVENIXSBFbmFibGluZyBId21v
biBkcml2ZXIgZm9yIHR3bDQwMzAtbWFkYwoKClNpZ25lZC1vZmYtYnk6IEtlZXJ0aHkgPGota2Vl
cnRoeUB0aS5jb20+Ci0tLQogZHJpdmVycy9tZmQvdHdsLWNvcmUuYyB8ICAgMTUgKysrKysrKysr
KysrKysrCiAxIGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZmQvdHdsLWNvcmUuYyBiL2RyaXZlcnMvbWZkL3R3bC1j
b3JlLmMKaW5kZXggOTYwYjViZS4uZTZlOTlkYiAxMDA2NDQKLS0tIGEvZHJpdmVycy9tZmQvdHds
LWNvcmUuYworKysgYi9kcml2ZXJzL21mZC90d2wtY29yZS5jCkBAIC04Myw2ICs4MywxMyBAQAog
I2RlZmluZSB0d2xfaGFzX21hZGMoKQlmYWxzZQogI2VuZGlmCiAKKyNpZiBkZWZpbmVkKENPTkZJ
R19TRU5TT1JTX1RXTDQwMzBfTUFEQykgfHxcCisJIGRlZmluZWQoQ09ORklHX1NFTlNPUlNfVFdM
NDAzMF9NQURDX01PRFVMRSkKKyNkZWZpbmUgdHdsX2hhc19tYWRjX2h3bW9uKCkgIHRydWUKKyNl
bHNlCisjZGVmaW5lIHR3bF9oYXNfbWFkY19od21vbigpICBmYWxzZQorI2VuZGlmCisKICNpZmRl
ZiBDT05GSUdfVFdMNDAzMF9QT1dFUgogI2RlZmluZSB0d2xfaGFzX3Bvd2VyKCkgICAgICAgIHRy
dWUKICNlbHNlCkBAIC02MDksNiArNjE2LDE0IEBAIGFkZF9jaGlsZHJlbihzdHJ1Y3QgdHdsNDAz
MF9wbGF0Zm9ybV9kYXRhICpwZGF0YSwgdW5zaWduZWQgbG9uZyBmZWF0dXJlcykKIAkJCXJldHVy
biBQVFJfRVJSKGNoaWxkKTsKIAl9CiAKK2lmICh0d2xfaGFzX21hZGNfaHdtb24oKSkgeworCQlj
aGlsZCA9IGFkZF9jaGlsZCgyLCAidHdsNDAzMF9tYWRjX2h3bW9uIiwKKwkJCQlOVUxMLCAwLAor
CQkJCXRydWUsIHBkYXRhLT5pcnFfYmFzZSArIE1BRENfSU5UUl9PRkZTRVQsIDApOworCQlpZiAo
SVNfRVJSKGNoaWxkKSkKKwkJCXJldHVybiBQVFJfRVJSKGNoaWxkKTsKKwl9CisKIAlpZiAodHds
X2hhc19ydGMoKSkgewogCQkvKgogCQkgKiBSRVZJU0lUIHBsYXRmb3JtX2RhdGEgaGVyZSBjdXJy
ZW50bHkgbWlnaHQgZXhwb3NlIHRoZQotLSAKMS43LjAuNAoK
--20cf301cc4828fe9f804a2646fb6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--20cf301cc4828fe9f804a2646fb6--
