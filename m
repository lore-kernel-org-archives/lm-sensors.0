From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 30 Nov 2006 20:31:25 +0000
Subject: [lm-sensors] SMSC SCH5504-NS ?
Message-Id: <20061130213125.a1193cd4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 19 Aug 2006 12:46:40 +0200, Rudolf Marek wrote:
> Jon Graves wrote:
> > Does anyone have any information on this Super IO chip?
> > I'm guessing it's similar to the SCH5307-NS, which is
> > supported in the smsc47b397 driver.  It reports a device
> > id of 0x79 (SCH5307-NS is 0x81).
> > 
> > Dell uses it in recent versions of their Precision 380 workstations.
> > 
> > Mailing SMSC for a datasheet resulted in a big fat zero.  If
> > anyone can supply me with the datasheet or other information,
> > I'll give adding support a shot.
> 
> Hmm we do not have any info. You may try to pickup some values from register
> dump and compare if they look reasonable or try to change the ID in the driver
> and see what happens.

Jon, did you give it a try? If so, did it work?

Thanks,
-- 
Jean Delvare

