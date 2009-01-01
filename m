From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 01 Jan 2009 22:09:04 +0000
Subject: Re: [lm-sensors] [RFC] Asus ATK0110 ACPI hwmon driver
Message-Id: <495D3F00.5090509@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081229205537.GA11072@dreamland.darkstar.lan>
In-Reply-To: <20081229205537.GA11072@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I've been working (not finished yet) on reviewing the ATK0110 driver. There is 
one big problem though, it conflicts with direct access to the Ic's as done by 
other drivers, please see my post to the list titled: "ACPI versus native IC 
drivers " for further discussion.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
