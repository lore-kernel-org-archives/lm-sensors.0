From: "Juerg Haefliger" <juergh@gmail.com>
Date: Mon, 07 Jul 2008 06:11:02 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon (c7temp): new driver for VIA C7 CPU
Message-Id: <191fb4ca0807062311l1a3f63d0k43083e24d77b0b4e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0806191620g1f001306r5d26cb67ed12d44b@mail.gmail.com>
In-Reply-To: <191fb4ca0806191620g1f001306r5d26cb67ed12d44b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Wilken,


>> Wilken, what motherboard is this? Are there any BIOS settings (thermal
>> management) that you can play around with? Try different thermal
>> management settings and rerun cpuid and check if the thermal monitors
>> show up as 'true'.
>> I have a cpuid dump from Sergio (C7 on a LN10000 board) and the only
>> difference between his dump and yours is that his shows 'true' for
>> both thermal monitors. Maybe your BIOS disables these features on your
>> CPU.
>
> It's the Artigo-Box from Via with a PX10000 board
> (http://www.via.com.tw/en/products/embedded/artigo/).
> No, there are no bios settings dealing with thermal or power management. There
> is nothing I can play with. The bios is very rudimentary.

Look at page 31 (CPU features) of the user's manual at
http://www.via.com.tw/en/products/mainboards/downloads.jsp?motherboard_idG2#Manual

...juerg

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
