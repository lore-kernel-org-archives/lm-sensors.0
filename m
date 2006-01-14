From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Sat, 14 Jan 2006 04:03:47 +0000
Subject: [lm-sensors] Incorrect SiS chipset detection?
Message-Id: <20060114040347.GA29747@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <43C6762C.3040001@quintic.co.uk>
In-Reply-To: <43C6762C.3040001@quintic.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Marcus:

> On 13/01/2006 Mark M. Hoffman wrote:
> > Could you please send the output from 'lspci -n' ?

* Marcus Williams <marcus at quintic.co.uk> [2006-01-13 09:27:14 +0000]:
> 0000:00:00.0 0600: 1039:0661 (rev 11)
> 0000:00:01.0 0604: 1039:0003
> 0000:00:02.0 0601: 1039:0008 (rev 25)
> 0000:00:02.5 0101: 1039:5513
> 0000:00:03.0 0c03: 1039:7001 (rev 0f)
> 0000:00:03.1 0c03: 1039:7001 (rev 0f)
> 0000:00:03.3 0c03: 1039:7002
> 0000:00:04.0 0200: 1039:0900 (rev 90)
> 0000:01:00.0 0300: 1039:6330

I committed a small change to sensors-detect in CVS.  I would appreciate if
you grab that and run it; please reply with the results.

> This is a remote box so I cant get to the BIOS without getting an 
> engineer to take a look, but it hasnt got anything important on it 
> (mainly because I dont trust it until I've sorted this heat problem out) 
> so if I can test anything email me.

Note: I'm just trying to make sure that the SMBus device on your SiS 963L
south bridge is supported.  It is unlikely that this will actually help
find any other sensors, since yours seems to be accessible by the ISA
bus already.  At least it will prevent the false detection of sis5595.

Thanks & regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


