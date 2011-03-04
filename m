From: Andrew Lutomirski <luto@mit.edu>
Date: Fri, 04 Mar 2011 18:50:41 +0000
Subject: Re: [lm-sensors] [PATCH v5 00/11] hwmon: (w83627ehf) Add support
Message-Id: <AANLkTinNrOG69Kzy=ZfRjurOedsz2Oazt-FT-m3Ro6Gg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1299261486-15190-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1299261486-15190-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Jean Delvare <khali@linux-fr.org>, Ian Dobson <i.dobson@planet-ian.com>, Randy Dunlap <rdunlap@xenotime.net>, binximeng@gmail.com, lmsensors@tapanitarvainen.fi, andrea.rizzolo@gmail.com, jeff.sadowski@gmail.com, lm-sensors@lm-sensors.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Mar 4, 2011 at 12:57 PM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> The following patch series adds support for NCT6775F and NCT6776F to the
> w83627ehf driver. It also includes some cleanup and adds support for
> the fourth temperature sensor on W83677HG-B.
>
> No code changes since v4. Resubmitting and widening audience in the hope =
that
> someone may find the time to review the changes prior to the next commit =
window.

I'm not sure my review is worth much, but the driver seems to work.  I've t=
ested
fan speed measurement, changing pwm2_enable to 1, changing the fan speed,
and changing back to 5.  Everything looks good.

The only weird thing I noticed is that, the first time I ran sensors, I got:
fan2:                    0 RPM  (min =3D    0 RPM, div =3D 64)
and thereafter I get
fan2:                  136 RPM  (min =3D    0 RPM, div =3D 64)  ALARM

I suspect (although I haven't checked) that sensors is just reading
div after it's already changed to 64.

Thanks,
Andy

>
> v5:
> - Update Kconfig to reference W83667HG, NCT6775F, and NCT6776F.
>
> v4:
> - Store rpm instead of raw fan speed readings
> - For NCT6775F, increase fan divisor if the fan speed reads 0
> =A0[ On NCT6775F, fan speed readings can return 0 instead of 0xff if the
> =A0 =A0fan divisor value is too low ]
> - Separate changes into more patches to simplify review
>
> v3:
> - Documentation: Remove references to datasheets which no longer exist
> - Documentation: Add information about limits of SmartFan IV support.
> - SmartFan III mode is not supported on NCT6776F, so remove related attri=
butes
> =A0and refuse to configure it.
> - (additional patch) Improve support for chips with 16-bit fan count regi=
sters
>
> v2:
> - W83677HG-B does share the AUXTIN/VIN3 pin, so we can not skip this chec=
k.
> - Cosmetic changes to fix a couple of checkpatch errors and to undo some
> =A0unnecessary formatting changes in patch 5.
> - Patch 1 introduced a bug in temp_to_reg which was fixed in a later patc=
h.
> =A0Modified code to not introduce the bug in the first place.
> - Two dev_dbg messages were changed to dev_info for testing. Changed back
> =A0to dev_dbg.
>
> The patched driver can be downloaded as stand-alone driver from
> =A0 =A0 =A0 =A0http://www.roeck-us.net/linux/drivers/w83627ehf/
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
