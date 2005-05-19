From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:36 +0000
Subject: Adding a note about via686a and i2c-viapro conflict in the FAQ
Message-Id: <20050206130505.24f056cd.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Aurelien,

> Oops. Here is a new patch.

You will be happy to learn that the patch Greg and I had been working on
is part of Linux 2.6.11-rc3-bk1 and later. This means that the via686a
vs i2c-viapro conflict is now gone.

If you still want to add a note about the problem in the FAQ, I'd prefer
it to be in a chip-specific section, or in the Linux-2.6 specific
section, since the problem and solution aren't exactly generic.

Thanks,
-- 
Jean Delvare
