From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: Ticket 1288
Message-Id: <20030813012030.1f5ac81b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <2147483647.1056216687@abrmsn288.med.upenn.edu>
In-Reply-To: <2147483647.1056216687@abrmsn288.med.upenn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> This does get a sensor running; it reports CPU temps of ~60 C.  When 
> I finally had a chance to take the server down and check via the
> BIOS, it reported temps in the mid-30s.
> 
> The voltages and fan speeds reported via i2c seem to be reasonable
> numbers.

If you aren't using 2.8.0 yet, upgrading could help (and at least we'll
make sure we aren't trying to fix a bug that was already corrected).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
