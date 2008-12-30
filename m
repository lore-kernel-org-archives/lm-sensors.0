From: "Luca Tettamanti" <kronos.it@gmail.com>
Date: Tue, 30 Dec 2008 14:09:47 +0000
Subject: Re: [lm-sensors] [RFC] Asus ATK0110 ACPI hwmon driver
Message-Id: <68676e00812300609p3497a541m6a322f2448d76f7d@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081229205537.GA11072@dreamland.darkstar.lan>
In-Reply-To: <20081229205537.GA11072@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Dec 30, 2008 at 3:01 PM, Gabriel C <crazy@frugalware.org> wrote:
>> I'm once again submitting my driver for ASUS ATK0110 sensor interface,
>> re-based against kernel v2.6.28. Comments are welcome :)
[...]
> Your patch works fine on my motherboard , here is the output when loading the driver :

yay :)

> however do I need some patches against lmsensors 2.* / 3.* to make sensors display the data from the ATK driver ?

Ah, yes:
http://thread.gmane.org/gmane.linux.drivers.sensors/18322

libsensors ignores the unknown 'acpi' bus.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
