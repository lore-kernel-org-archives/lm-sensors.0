From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:40 +0000
Subject: Ticket 1564 (Can't access /proc file for writing);
Message-Id: <1075995614.402263deaf317@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040205141827.GA3115@raw-sewage.net>
In-Reply-To: <20040205141827.GA3115@raw-sewage.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[Please reply to the list, not to me.]

Quoting Matt Garman <garman@raw-sewage.net>:

> Here is the output of strace sensors -s (run as root).
> Please let me know if you need any more information!

Erf, the trap is not activated by default :/ my bad. Please recompile
lm_sensors with DEBUG defined (changeable in the Makefile) so that
libsensors includes the trap, and redo the test. Sorry that I did not
mention that earlier.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
