From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: Call for testers: Kernel connector update, SuperIO update.
Message-Id: <20040912014552.36f2526a@zanzibar.2ka.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040909080310.GA32003@uganda.factory.vocord.ru>
In-Reply-To: <20040909080310.GA32003@uganda.factory.vocord.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 11 Sep 2004 23:18:45 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> > I swear I will not smoke bad crack anymore.
> > 
> > Patch for Makefile was broken.
> > Corrected shoud use SC_SUPERIO not SUPERIO.
> 
> BTW I still don't get what that "SC" is for. This is a directory where
> drivers for Super-I/O chips will be located, so why not actually simply
> call the option SUPERIO?

I really do not remember why it has sc_ prefix. Initially it was something 
like "soekris", probably "soekris control" or "superio control".
Directory for superio subsystem probably will be called superio, at least it 
has such name in the patches.

> Thanks.
> 
> -- 
> Jean "Khali" Delvare
> http://khali.linux-fr.org/


	Evgeniy Polyakov ( s0mbre )

Only failure makes us experts. -- Theo de Raadt
