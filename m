From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: Ticket #1545
Message-Id: <20040125203745.3cd60136.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <40140EAE.1010706@fortytwo.eu.org>
In-Reply-To: <40140EAE.1010706@fortytwo.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> 00:04.4 Class 0600: 1106:3057 (rev 30)

This is the correct device. So there must be something wrong with the
detection. Please try loading the module and check dmesg and/or system
logs right after. This should provide the cause of the failure. Contrary
to what you seem to think, you do not need to reboot to see the error
messages.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
