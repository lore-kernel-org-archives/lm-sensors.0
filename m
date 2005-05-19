From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: Tellerstats, Computer Hardware Statistics
Message-Id: <UKZZLT5k.1108721634.2510450.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <pT0OxCEG.1108373919.2908350.khali@localhost>
In-Reply-To: <pT0OxCEG.1108373919.2908350.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Morgan,

> Unfortunately all ACPI provides in fan & thermal zone is nil...  Thus my
> use of lm_sensors.  Do you have any pointers as to fan control?  Something
> must be controlling it?

I can't tell. The OT and ALERT/COMP outputs of the chip may be wired to
about anything, which might control the fan directly, or not. At this
point you really need to get some high-level technical documentation
from your hardware manufacturer, which is usually hard to obtain.
Alternatively you may open the case and try to follow the wires from the
MC1066 chip. That might help, or not.

--
Jean Delvare
