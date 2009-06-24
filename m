From: Luca Tettamanti <kronos.it@gmail.com>
Date: Wed, 24 Jun 2009 11:08:58 +0000
Subject: Re: [lm-sensors] HowTo Asus P5Q, W83667HG vs ATK0110 - fancontrol
Message-Id: <68676e00906240408h71655594k7fbe96c53ba0ddc2@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090624094735.GA16670@punzenstreichler.doom>
In-Reply-To: <20090624094735.GA16670@punzenstreichler.doom>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Wed, Jun 24, 2009 at 11:47 AM, Konstantin Kletschke<konsti@ku-gbr.de> wrote:
> On my investigation I discovered some sort of acpi based atk0110 driver
> for the asus boards, which works fine so far.
>
> ATK0110 ATK0110:00: adding...
> ATK0110 ATK0110:00: board ID = P5Q
> ATK0110 ATK0110:00: Using old hwmon interface
> ATK0110 ATK0110:00: voltage: 0x6020000 Vcore Voltage [800-1600] enabled
> ATK0110 ATK0110:00: voltage: 0x6020001  +3.3 Voltage [2970-3630] enabled
> ATK0110 ATK0110:00: voltage: 0x6020002  +5 Voltage [4500-5500] enabled
> ATK0110 ATK0110:00: voltage: 0x6020003  +12 Voltage [10200-13800] enabled
> ATK0110 ATK0110:00: temperature: 0x6030000 CPU Temperature [600-950] enabled
> ATK0110 ATK0110:00: temperature: 0x6030001 MB Temperature [450-950] enabled
> ATK0110 ATK0110:00: fan: 0x6040000 CPU FAN Speed [600-7200] enabled
> ATK0110 ATK0110:00: fan: 0x6040001 CHASSIS1 FAN Speed [600-7200] enabled
> ATK0110 ATK0110:00: fan: 0x6040002 CHASSIS2 FAN Speed [600-7200] enabled
> ATK0110 ATK0110:00: fan: 0x6040003 POWER FAN Speed [600-7200] enabled
> ATK0110 ATK0110:00: registering hwmon device
> ATK0110 ATK0110:00: populating sysfs directory
>
> The readings from fan1_[input|label] are reasonable:
>
>> cat fan1_input fan1_label
> 534
> CPU FAN Speed
>
> Can fan pwm value controlled with this driver?

Not directly, the relevant ACPI method doesn't actually touch the
hardware. It should be possible to use Q-FAN to switch between
different profiles, but I've yet to RE that interface.

> Does lm_sensors-3.1.0 still need to be patched to acces this driver?

No, it's fine as is.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
