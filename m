From: tjs@skilta.cc.tut.fi (Timo Salmi)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: ---=== Lm_sensors Support DB Entry #1692 ===---
Message-Id: <20040609062212.GC448@skilta.cc.tut.fi>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jun 08, 2004 at 06:23:12PM -0700, Nobody wrote:
> Your Lm_sensors support entry has been updated.
> 
> Please go to http://secure.netroedge.com/~lm78/support.html to check
> the status of your entry.  
> 
> Ticket # 1692

I hadn't noticed the instructions below the tables at new drivers page.

I added to my modules.conf:
options lm90 force_lm90=0,0x4c

After that everything worked fine. 

lm90-i2c-0-4c
Adapter: SMBus I801 adapter at 0c00
M/B Temp:    +38 C  (low  =    +0 C, high =  +105 C)
CPU Temp:  +50.4 C  (low  =  +0.0 C, high = +55.0 C)
M/B Crit:   +105 C  (hyst =   +95 C)
CPU Crit:   +105 C  (hyst =   +95 C)

Thank you for the fast support!
