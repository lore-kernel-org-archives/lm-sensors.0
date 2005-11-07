From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 07 Nov 2005 19:33:41 +0000
Subject: [lm-sensors] Helps: how to use i801--SMBus functions viai2c-dev
Message-Id: <20051107193331.5ba85992.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051101104855.41881.qmail@web31214.mail.mud.yahoo.com>
In-Reply-To: <20051101104855.41881.qmail@web31214.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Michael,

> I am actually accessing the master ICH6 SMBus controller's registers and
> memory instead of the slave control on the customized board. According
> to the data sheet of ICH6, it supports block data transfer. 

Sure it does, that's not the point. The question is, is the slave
device you are talking to expecting an SMBus block transfer for the
command byte you are using? As I already said, SMBus transactions only
work if the master and client agree on the transaction type. If you are
trying random block reads/writes, no wonder it doesn't work.

That being said, SMBus block transactions are rarely used, so we can't
exclude some bug for them in some of our drivers.

-- 
Jean Delvare
