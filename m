From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 02 Oct 2005 22:53:26 +0000
Subject: [lm-sensors] Proposed PEC support reimplementation
Message-Id: <20051002225247.18a09e78.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051002142457.347cf818.khali@linux-fr.org>
In-Reply-To: <20051002142457.347cf818.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant,

> >Comments are of course welcome. Testers are very welcome too, both to
> 
> What is PEC?  Why do I want it?  I been skimming this thread for days 
> waiting for the penny to drop, it hasn't :(

Didn't you read the SMBus 2.0 specification yet? ;)

PEC stands for Packet Error Code, this is an extension of the SMBus
protocol which adds a CRC8 byte at the end of each transaction, for the
purpose of improving reliability. For it to work, both the master and
the slave must support it for the given transaction.

We had a previous implementation by Mark D. Studebaker which had some
bugs and design limitations. I've been reimplementing it in a different
way, in fewer lines of code, with hopefully less bugs and less
limitations.

If you want to help, you can pick the patches and at least make sure
that they don't break anything for you. If you additionally have a
PEC-capable master (either an I2C master using the software PEC
implementation, or a SMBus master with hardware PEC support), and have
at least one slave with PEC, you could see if PEC actually works for
you. My impression is that only a very small number of slaves actually
support PEC though.

Thanks,
-- 
Jean Delvare
