From: Luca Tettamanti <kronos.it@gmail.com>
Date: Thu, 31 Mar 2011 20:16:28 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add support for MAX6642
Message-Id: <AANLkTi=nO0uh_Lhm8RpGaEBPx43Xmv2KatX65-Vd68pi@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <55325.79.160.13.2.1301596473.squirrel@webmail.s7.itpays.net>
In-Reply-To: <55325.79.160.13.2.1301596473.squirrel@webmail.s7.itpays.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Thu, Mar 31, 2011 at 8:34 PM, Per Dalén <per.dalen@appeartv.com> wrote:
> MAX6642 is a SMBus-Compatible Remote/Local Temperature Sensor with
> Overtemperature Alarm from Maxim.

Hello,
I've just a couple of minor comments:

[...]
> +struct max6642_data {
> +       struct device *hwmon_dev;
> +       struct mutex update_lock;
> +       char valid; /* zero until following fields are valid */

I'd use bool instead of char

> +       unsigned long last_updated; /* in jiffies */
> +
> +       /* registers values */
> +       u16 temp_input1, temp_high1; /* local */
> +       u16 temp_input2, temp_high2; /* remote */

IMHO keeping one field declaration per line makes it more readable.

From a quick glance the rest looks fine.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
