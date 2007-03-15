From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 15 Mar 2007 06:59:50 +0000
Subject: [lm-sensors] get rid of i2c-isa - h now
Message-Id: <20070315075950.eedb2b36.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45F1E8C0.6040504@assembler.cz>
In-Reply-To: <45F1E8C0.6040504@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 10 Mar 2007 00:07:44 +0100, Rudolf Marek wrote:
> Jean asked me to help to covert the remaining i2c-isa drivers. Situation is
> following:
> 
> it87.c -  montjoie is working on it, Jean can test
> lm78.c - special ISA, Jean can test
> pc87360.c
> sis5595.c
> smsc47b397.c - I can test but bit complicated - it is a server
> smsc47m1.c
> via686a.c
> vt8231.c
> w83627hf.c - Jean can test
> w83627ehf.c - I can test on monday/sunday, passing to David right now ;)
> w83781d.c - special ISA

Jim, any chance you could help with the conversion of the pc87360
driver?

Thanks,
-- 
Jean Delvare

