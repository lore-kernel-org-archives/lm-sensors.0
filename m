From: Luca Tettamanti <kronos.it@gmail.com>
Date: Tue, 13 Oct 2009 13:55:00 +0000
Subject: Re: [lm-sensors] it87 / acpi / DSDT-dump (ASUS P5V2D-MX)
Message-Id: <68676e00910130655v4e060226i1213a7689371d55e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <68676e00910130600u39fff342mf5db22c962f895de@mail.gmail.com>
In-Reply-To: <68676e00910130600u39fff342mf5db22c962f895de@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Oct 13, 2009 at 3:48 PM, Manuel Knitza
<manuel.knitza@uni-konstanz.de> wrote:
> Luca Tettamanti schrieb:
>> if you need to directly
>> control the fans (not possible with the ACPI driver) then use
>> "acpi_enforce_resources=lax" and load it87 (and do *not* load
>> asus_atk0110).
>
> ok, then that seems to be the *solution* rather then a workaround

No, it's really a workaround since the hwmon chip may be used by
"something" else (i.e. the firmware); on older boards it's somewhat
safe to override the exclusion logic since the chip is not actively
used (it's accessed only through the ACPI interface); on newer board
this is not true, there's a controller chip which uses the hwmon
independently.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
