From: malmostoso@email.it (malmostoso)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: Ticket #1633
Message-Id: <HW1X4H$02D157720EBB0420D5148E7CB2C5A099@email.it>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Khali,
hope you'll get this email.

I solved the problem by reinstalling the original kernel rpm:

# rpm -Uvh --force kernel-2.4.25-ydl-1.rpm

This makes me think that some part of all the i2c subsystem was compiled in the kernel and not as a module.

Hope this helps, thank you!



--
Email.it, the professional e-mail, gratis per te: http://www.email.it/f

Sponsor:
Il pacchetto fiabe - 13 libri di fiabe per ragazzi e adulti
Sconto del 51% sul prezzo di mercato.
Clicca qui: http://adv.email.it/cgi-bin/foclick.cgi?mid06&d-4
