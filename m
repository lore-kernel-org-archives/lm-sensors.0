From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: Sensors-detect output from ASUS p5ad2 premium w/ W83627EHF as
Message-Id: <41B617CB.2050804@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <A652FD396F42E94BA29B9EB35404E7A303220620@azsmsx405.amr.corp.intel.com>
In-Reply-To: <A652FD396F42E94BA29B9EB35404E7A303220620@azsmsx405.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

ok.
as a quick test, in the w83627hf.c driver, try changing
#define W627THF_DEVID 0x82
to
#define W627THF_DEVID 0x88

then recompile and load the driver (and i2c-isa of course), see if it loads and if you get decent
results in sensors.

mds




Madsen, David W wrote:
> Feel free to contact me if any more info could be useful!
> 
