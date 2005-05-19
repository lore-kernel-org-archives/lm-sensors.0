From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: Linux 2.6 and CONFIG_ISA
Message-Id: <1074246207.4007b23f6507a@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1074005072.400404506dd11@imp.gcu.info>
In-Reply-To: <1074005072.400404506dd11@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Greg KH <greg@kroah.com>:

> I just too the requirement for CONFIG_ISA off of i2c-isa so that
> x86_64 users can use that driver.  We might want to consider a rename
> of the driver in the future...

I am not sure I understand your sentence ;)  Nevermind, I have patch
ready that should help users and limit further reports about the ISA
bus:

1* Elektor depends on ISA.
2* ELV and Velleman do not depend on ISA.
3* i2c-isa is M by default, and has an additional help text
4* via686a autoselects i2c-isa
5* i2c-isa doesn't depend on ISA

If I understand it correctly, CONFIG_ISA does *not* do anything but
enable the user to select other drivers or enable specific parts in
drivers.  So I don't see any drawback nor possible problem not
depending on it.

I will send this patch to you this evening.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
