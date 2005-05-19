From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: Sensor results of P4P800
Message-Id: <20031207120436.317fd757.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031207071324.11967.qmail@web1204.mail.yahoo.co.jp>
In-Reply-To: <20031207071324.11967.qmail@web1204.mail.yahoo.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Vcore2: Can I ignore?
> in4: I believe in4 shows +12V. Is this a bug?

After reading the w83627THF data sheet, I believe that in1 (here shown as Vcore2) is +12V, while in4 is -12V.

Try using the following lines:

  label in1 "+12V"
  label in4 "-12V"
  compute in1 ((28/10)+1)*@, @/((28/10)+1)
  set in1_min 12 * 0.90
  set in1_max 12 * 1.10
  set in4_max -12 * 0.90
  set in4_min -12 * 1.10

As for the in4 compute line, the one provided in the data sheet look buggy. Try to steal in5 from other Winbond chips and see how it goes. Anyway, I suspect that -12V isn't actually connected on your system (thus the 0 reading), so you'll probably end up ignoring this input.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
