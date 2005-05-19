From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: RFC: complete rewrite of i2c-i801 for 2.6.x
Message-Id: <41B6010F.1040300@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041128193640.GB5855@jupiter.solarsys.private>
In-Reply-To: <20041128193640.GB5855@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Mark M. Hoffman wrote:
> Hello MDS, again:

> BTW, there's really no point to implementing I2C_FUNC_SMBUS_BLOCK_DATA in
> the new i801 driver as i2c_smbus_[read|write]_block_data() were yanked
> out of i2c-core anyway.  And that reminds me: you probably shouldn't speak
> too loudly about any other parts (shhhh... PEC, SMBus 2.0) that have no
> current users, as the bloat police might show up and rip them out too. ;)


As I understand the bloat-police thread, there's no objection to adding back in the removed functions
when they're needed. 
It's a little irritating that things are being ripped out but I can understand it.
It should be our goal to get the block functions back in as soon as possible.
You should include it with any 801 patch submission.
I guess the write was already put back but the read wasn't?
