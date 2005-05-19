From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: RFC: complete rewrite of i2c-i801 for 2.6.x
Message-Id: <20041208005641.GF5295@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041128193640.GB5855@jupiter.solarsys.private>
In-Reply-To: <20041128193640.GB5855@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark:

(CCs trimmed)

* Mark D. Studebaker <mds4@verizon.net> [2004-12-07 11:20:54 -0500]:
> My reading of the DB datasheet (in 2002 and now) is that it doesn't support a
> standard i2c block read. The driver functionality bitmask reflects that.
> I fixed the error message (which would only print out if a driver ignored 
> the functionality mask).

Interesting.  It looks like that datasheet only shows this:

	S Addr Wr [A] Comm [A] D0 [A] D1 [A] S (read bytes...)

I agree that's not like any transaction we support.

OTOH, the ICH5 [1] datasheet shows this:

	S Addr Wr [A] D1 [A] S (read bytes...)

That's exactly the transfer protocol that eeproms need, right?  (That's why I
mentioned to Khali by IRC last weekend that I thought it should be possible.)

It would be really bizarre if these two chipsets behaved differently in this
respect - I wonder if the datasheets are correct?

[1] Well I just scanned all the other datasheets... only ICH5, ICH6, and
6300ESB appear to support the standard I2C block read.  Sorry Khali. :)

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
