From: jacques.facquet@free.fr (Jacques Facquet)
Date: Tue, 08 Nov 2005 01:51:03 +0000
Subject: [lm-sensors] reset=1 required for PWM control on Asus P4P800
Message-Id: <200511080150.08821.jacques.facquet@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051106224429.533f13b7@heffalump.sk2.org>
In-Reply-To: <20051106224429.533f13b7@heffalump.sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Le Dimanche 6 Novembre 2005 22:44, Stephen Kitt a ?crit :

> I switched to 2.6.14 yesterday and noticed today that the CPU fan
> was stuck at the speed the BIOS cruise control left it at before
> the w83627hf module was loaded. Changing the PWM value via
> /sys/bus/i2c/devices/.../pwm2 had no effect. Loading the module
> with reset=1 fixed things, and I noticed in my logs the request to
> report its usefulness. I compared the code from 2.6.13 to 2.6.14
> and saw the change (and the comment!).
This solved my problem too.
dmesg
Trying to free nonexistent resource <00000290-00000297>
(after reloading the driver)

w83627hf 9191-0290: If reset=1 solved a problem you were having, 
please report!

Soltek QBic EQ-3401A-V2

request_region(address, WINB_EXTENT, w83627hf_driver.name) return an 
error, without checking this error, the driver load but I have an 
error in unloading it.


-- 
Jacques Facquet.
