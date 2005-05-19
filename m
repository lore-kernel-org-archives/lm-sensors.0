From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: Ticket #920
Message-Id: <200406030944.i539iLQK050423@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200206221117.33609.veso_vdd@mail.orbitel.bg>
In-Reply-To: <200206221117.33609.veso_vdd@mail.orbitel.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>> OK, done. I've also added a comment. I suspect that continuous byte read
>> was not working on your adapter/monitor combination, while regular byte
>> read was. Usually, EEPROMs support continuous read mode (aka
>> auto-increment), maybe yours wasn't. I don't remember hearing of
>> similar cases though, and we cannot verify my theory anymore.
>
>Ticket #1011 looks similar, though it's a different board/monitor.

Correct. I've updated (but not closed) that ticket as well. Thanks for
pointing that out.

If more monitors appear to suffer from the problem, we should probably
either default to simple byte reads for everyone, or at least provide a
module parameter to forcibly select mode.

BTW, the driver reads much more data than we actually need, from what I
can see. So switching to byte reads would make sense anyway. It could
even be faster than reading the whole EEPROM in continuous mode.

As a side note, I'd suggest that we do not port the driver to Linux 2.6.
The eeprom driver should do well. All we need is some user-space tool to
decode that special eeprom. Having a separate drivers doesn't make much
sense IMHO.

Thanks.

Jean Delvare
