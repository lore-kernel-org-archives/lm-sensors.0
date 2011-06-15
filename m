From: Luca Tettamanti <kronos.it@gmail.com>
Date: Wed, 15 Jun 2011 15:25:08 +0000
Subject: Re: [lm-sensors] asus_atk0110 causes mouse and keyboard freeze in
Message-Id: <BANLkTinnR-Fm5BADojXkMr4w39x03W9pXQ@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="005045016c92fd838b04a5c1c193"
List-Id: <lm-sensors.vger.kernel.org>
References: <4CF7B282.10007@verizon.net>
In-Reply-To: <4CF7B282.10007@verizon.net>
To: lm-sensors@vger.kernel.org

--005045016c92fd838b04a5c1c193
Content-Type: text/plain; charset=UTF-8

On Wed, Jun 15, 2011 at 2:13 PM, Luca Tettamanti <kronos.it@gmail.com> wrote:
> On Wed, Jun 8, 2011 at 1:20 PM, Javier <javier@javispedro.com> wrote:
>> 2011/6/8 Luca Tettamanti <kronos.it@gmail.com>:
>>> I'll take a look ASAP (but this weekend I'll be AFK). Does your kernel
>>> have ACPI_CUSTOM_METHOD enabled?
>>
>> No, but I can easily rebuild it (do not worry).
>
> Yes please, ACPI_CUSTOM_METHOD will be needed; I'm preparing a patched
> version of the DSDT and the driver.

I'm attaching a patched version of the monitoring method.
Boot the kernel with ACPI_CUSTOM_METHOD enabled and do *not* load
asus_atk0110; load the override with:
cat DSDT.aml > /sys/kernel/debug/acpi/custom_method
If everything looks good then try asus_atk0110 and see if it's stable.
If it still locks up the machine I'll have to try a different
approach...

Luca

--005045016c92fd838b04a5c1c193
Content-Type: application/octet-stream; name="DSDT.aml"
Content-Disposition: attachment; filename="DSDT.aml"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_goyfm0410

RFNEVEIDAAABwUExMzI2AEExMzI2MDAxAQAAAElOVEwoBRAgEE0xLwRfU0JfUENJMFNCUkdBU09D
FEgwR0lUNgEIX1RfMABwe2gL//8AX1RfMKA5k19UXzAKEaAwklsjXl4uRUMwX01VRUP//3deXi5F
QzBfRVI4NAoIQVNCMVsnXl4uRUMwX01VRUOhRSugSQSTX1RfMApjoD+SWyNeXi5FQzBfTVVFQ///
cgoiCiJgd3leXi5FQzBfRVI4NQoDAGBgeGAKIgBBU0IxWydeXi5FQzBfTVVFQ6FIJqBJBJNfVF8w
CmKgP5JbI15eLkVDMF9NVUVD//9yChQKCmB3eV5eLkVDMF9FUjg2CgMAYGB4YAoKAEFTQjFbJ15e
LkVDMF9NVUVDoUshoEkEk19UXzAKYaA/klsjXl4uRUMwX01VRUP//3IKPAoKYHd5Xl4uRUMwX0VS
ODcKAwBgYHhgCgoAQVNCMVsnXl4uRUMwX01VRUOhThygQgWTX1RfMAoSoEgEklsjXl4uRUMwX01V
RUP//3leXi5FQzBfRVI3NQFgel5eLkVDMF9FUjc2CgdhWydeXi5FQzBfTVVFQ3JgYWF3YQoFQVNC
MaFIF6A9k19UXzAKFKA0klsjXl4uRUMwX01VRUP//3leXi5FQzBfRVI3NwFgWydeXi5FQzBfTVVF
Q3dgCgVBU0IxoUcToEgEk19UXzAKE6A+klsjXl4uRUMwX01VRUP//3leXi5FQzBfRVI3QwoIYHJe
Xi5FQzBfRVI3RGBBU0IxWydeXi5FQzBfTVVFQ6FLDqBIBJNfVF8wCnOgPpJbI15eLkVDMF9NVUVD
//95Xl4uRUMwX0VSN0EKCGByXl4uRUMwX0VSN0JgQVNCMVsnXl4uRUMwX01VRUOhTwmgSASTX1Rf
MAqDoD6SWyNeXi5FQzBfTVVFQ///eV5eLkVDMF9FUjgwCghgcl5eLkVDMF9FUjgxYEFTQjFbJ15e
LkVDMF9NVUVDoUMFoEgEk19UXzAKw6A+klsjXl4uRUMwX01VRUP//3leXi5FQzBfRVI3RQoIYHJe
Xi5FQzBfRVI3RmBBU0IxWydeXi5FQzBfTVVFQ6EHcABBU0Iw
--005045016c92fd838b04a5c1c193
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--005045016c92fd838b04a5c1c193--
