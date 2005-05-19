From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:51 +0000
Subject: Problem with "sensors -s"
Message-Id: <20030324094500.740bc7ff.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E7EA3D2.60309@astro.physics.upenn.edu>
In-Reply-To: <3E7EA3D2.60309@astro.physics.upenn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I run sensors -s (as root!) and get this message:
> 
> ----------------------snip-------------------------
> it87-isa-0290: Can't access /proc file for writing;
> Run as root?
> ----------------------snip-------------------------
> 
> The i2c-proc IS inserted.

Just another question: Do you have any other patch added to your kernel,
such as the ptrace bugfix?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
