From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: RFC: complete rewrite of i2c-i801 for 2.6.x
Message-Id: <20041208033459.GH5295@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041128193640.GB5855@jupiter.solarsys.private>
In-Reply-To: <20041128193640.GB5855@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark:

* Mark D. Studebaker <mds4@verizon.net> [2004-12-07 22:01:32 -0500]:
> (...)

> >OTOH, the ICH5 [1] datasheet shows this:
> >
> >	S Addr Wr [A] D1 [A] S (read bytes...)
> >
> >That's exactly the transfer protocol that eeproms need, right?  (That's 
> >why I
> >mentioned to Khali by IRC last weekend that I thought it should be 
> >possible.)
> >
> 
> I think it is what eeproms need (you omitted 'Addr' after the second 'S').
> It matches what I wrote in doc/smbus-protocol in i2c
> (that is, the i2c block functions are defined to take a 'command' byte, 
> matching
> what eeproms need for 'random' reads and writes).
> 
> Does anybody have a ICH5/6? If so I can add support to the driver for 
> testing.

I have an ICH5; I'll definitely test it if you add it.  I'm working on
adding this to the new i801 driver as well.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
