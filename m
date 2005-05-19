From: roger.hakansson@algitech.com (=?ISO-8859-1?Q?Roger_H=E5kansson?=)
Date: Thu, 19 May 2005 06:25:51 +0000
Subject: Wrong temperature readings
Message-Id: <425D941D.9020303@algitech.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <425D3645.1030500@algitech.com>
In-Reply-To: <425D3645.1030500@algitech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> These messages don't come from our drivers. They are either from ACPI or
> from CPU-specific MCE. Search the web for "Running in modulated clock
> mode" and you'll find several references to your problem.

I know, thats why I tried using sensors(1) to get the CPU/MB-temperature.

And there's the problem (if you look at the output from sensors(1)).
All three sensors tell me about ~127 degres Celsius (260 Farenheit), and I
doubt that thats the case.

> You should check if you can find anything relevant in
> /proc/acpi/thermal_zone. If temperature limits are too low, try
> increasing them.

I have nothing there, the directory is empty.

> As for MCE, I don't know how you can change their threshold. Maybe it's
> just a matter of improving the CPU cooling.

I know that the CPU cooling needs to be improved, but in order to check that
my (future) cooling changes is working, I need to get a correct reading on
the temperatures (before and after).
Right now I get 127 regardless if the machine is idle or if its loaded (when
the "modulated clock" messages appear) so any change to the cooling is just
guessing...

And it seems that I'm not the only one getting theese strange temp/voltage
readings with this MB.
http://lists.debian.org/debian-user/2005/03/msg00510.html

-- 
Roger H?kansson , Senior Consultant
Algitech Consulting AB
S?dra Kungsgatan 5(Office)
Box 28, S-971 02 Lule? , Sweden
Tel:    +46 (0)920 88313    Mobile: +46 (0)705 549533
Fax:    +1 (0)928 222 7116  E-mail: roger.hakansson@algitech.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 2883 bytes
Desc: S/MIME Cryptographic Signature
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050413/cec841b7/smime.bin
