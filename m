From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:12 +0000
Subject: i2c-piix4 problem
Message-Id: <20040817073637.M95037@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200408041637.21472.lists@localguru.de>
In-Reply-To: <200408041637.21472.lists@localguru.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > I had no visual inspection yet, but I found the manual of the motherboad.
> > It's GA-568TX3 (PCI-ISA BUS). Does this information help?
> 
> Typo, it's a GA-586TX3. Sorry!

This board (obviously made by Gigabyte) is not listed on the MBM site. A quick
search trough Google didn't mention any hardware monitoring capabilities for
that board. So I would say that it just doesn't have any, which is why
sensors-detect wouldn't find any. Sorry but there's almost nothing more you
can do now, except accept that fact.. or change motherboards ;)

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
