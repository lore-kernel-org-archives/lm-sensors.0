From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: packages for Red Hat 7.3
Message-Id: <20031122093333.74eda2df.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Please provide a subject next time.

> I've got a question for you. I have a system running the Redhat 7.3
> operating system and i've tried to run lmsensors on it but i get bogus
> values when i run sensors. The chip on the motherboard is the Winbond
> w83627hf and i'm using the embedded lmsensors rpm package that comes
> with the redhat distribution.

Must be version 2.6.1, is that it? It's two years old, we have been
fixing the driver a lot since.

> Can you tell me if there is a fix for this problem? Are there any
> updated rpms available?

We don't provide RPM packages anymore, but it looks like ATRPMS has
some:
http://atrpms.physik.fu-berlin.de/dist/rh73/lm_sensors/

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
