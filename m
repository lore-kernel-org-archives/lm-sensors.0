From: Juerg Haefliger <juergh@gmail.com>
Date: Fri, 09 Apr 2010 17:28:25 +0000
Subject: Re: [lm-sensors] SMSC 5027 watchdog support
Message-Id: <k2q191fb4ca1004091028s19bf14a8we69826c064f31687@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Thomas,


> Hi,
>
> I have seen that you added the SCH5027 support to the dme1737 driver.
>
> I have a couple of servers using the Tyan S5211 mainboard which uses the
> watchdog on the SCH5027, but it looks like there is no driver support in
> Linux.
>
> Can you please shed any light here ?

Not much light so shed here. There is no watchdog support in the
current driver. I don't know how the watchdog functionality integrates
with the hwmon subsystem or if this is handled in a different
subsystem. Anybody on the list willing to enlighten me before I fire
up google? :-)

...juerg



> Kind regards from Vienna, Austria
> Thomas
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
