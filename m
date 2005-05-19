From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: lm_sensors messages
Message-Id: <20030916214501.3cef3d5c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> As requested.

Thanks. Looks like the DMI method is better than the ACPI one, at least
in your case. I think I remember that another user once reported a
similar case, but - shame on me - I can't remember which method was
working for him.

BTW, it looks like you are working at IBM. Maybe you could help us? We
are trying to get some information about Thinkpads for months now. Some
of them do contain special memory chips that lm_sensors can corrupt.
This is the reason why we don't let Thinkpad users install lm_sensors on
their machine. We'd like to enable the use of our product to those who
have a non-faulty Thinkpad. Unfortunately, we never could obtain from
IBM a list of which laptops are safe, and which are not. We already know
how do identify the laptops, thank to that document:
http://www.pc.ibm.com/qtechinfo/MIGR-45120.html
But that's useless until we also know which laptops we can safely run
lm_sensors on. For reference, the full story is available here:
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/README.thinkpad

Do you think you could provide some assistance?

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
