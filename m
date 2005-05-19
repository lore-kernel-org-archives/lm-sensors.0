From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: Call for testers: Kernel connector update, SuperIO update.
Message-Id: <20040911231845.68d322a7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040909080310.GA32003@uganda.factory.vocord.ru>
In-Reply-To: <20040909080310.GA32003@uganda.factory.vocord.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I swear I will not smoke bad crack anymore.
> 
> Patch for Makefile was broken.
> Corrected shoud use SC_SUPERIO not SUPERIO.

BTW I still don't get what that "SC" is for. This is a directory where
drivers for Super-I/O chips will be located, so why not actually simply
call the option SUPERIO?

Thanks.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
