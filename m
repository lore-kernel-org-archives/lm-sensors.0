From: delvare@ensicaen.ismra.fr (Jean Delvare)
Date: Thu, 19 May 2005 06:23:53 +0000
Subject: IBM & lm_sensors
Message-Id: <20030416105414.4659a1d6.delvare@ensicaen.ismra.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


First, I'd like to apogize for taking so long answering. I've been
somehow busy the day I received your mail, and forgot to answer then.

> I was wondering what the current state of affairs is
> with IBM and the lm_sensors project.  I own an IBM
> Thinkpad X22 and would like to run linux on it with
> correct thermal management / power management
> features it is intended to have.

Things haven't been improving for quite a time now.

> Is IBM blocking the lm_sensors project from achieving these goals?

Though we can't say they block us, they are helping so slowly that it's
almost the same. You can read about the whole story here:
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/README.thinkpad

> That is to say, is lm_sensors a key component to thermal
> and power management in linux?

Thermal, yes. Power not at all. For power management see APM or ACPI
(depending on your hardware), but I've heard that APM and ACPI
implementations of IBM laptops are pretty poor, too. ACPI is also
supposed to handle thermal management on compliant systems.

> If it is, how could I help your group?

Well, I don't think you can do very much, except contact IBM and ask
them why LM Sensors still won't run on their hardware.

Good luck.

PS: Where did you get my e-mail address?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
