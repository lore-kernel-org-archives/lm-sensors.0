From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:13 +0000
Subject: I2C_ALGO_MAX
Message-Id: <20030823230524.7989eb50.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030806164123.5f88f7b8.khali@linux-fr.org>
In-Reply-To: <20030806164123.5f88f7b8.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > Compiling all sensor chip drivers into the kernel is BAD. Do we want
> > to help people doing a BAD thing?
> > 
> 
> I think that's what Greg was advocating...

Yes, I understood that... Still I don't think people will do that.
Either they know which chipset that have, and compile only this driver
in, or they don't know and want to have all modules handy for
sensors-detect to work correctly.

It's great that one can build many drivers into the kernel at once, but
since the tables we are talking about are static, increasing the limits
is likely to be a waste of memory space for 99% of the users, and can
(and should) be easily avoided for the 1% left.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
