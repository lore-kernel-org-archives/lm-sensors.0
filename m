From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: locks
Message-Id: <20030721104617.4b5f1811.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I noticed that the locks in our drivers are used only in the update
function (that is, when reading from the hardware), and never in the
proc files subs, where we sometimes *write* to the hardware registers.
Why that?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
