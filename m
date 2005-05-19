From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: Ticket 1288
Message-Id: <3EFCE2B1.4000200@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2147483647.1056216687@abrmsn288.med.upenn.edu>
In-Reply-To: <2147483647.1056216687@abrmsn288.med.upenn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

try modprobing i2c-isa then it should work.

Charles Bailey wrote:
> Tried CVS i2c lk-24 and lm_sensors2 per your reply.  Both build and 
> install fine.  ./prog/detect/sensors-detect again picks up the AMD768, 
> but fails loading i2c-amd756, apparently because it's now in 
> i2c/busses.  It also fails to locate the 627HF, both before and after 
> the amd756 module is loaded manually (not that that should matter, 
> afaict).  If I load modules manually, yielding
> 
>  Module                  Size  Used by    Not tainted
>  w83627hf               13044   0 (unused)
>  i2c-proc                8116   0 [w83627hf]
>  i2c-amd756              3848   0
>  i2c-dev                 4992   0
>  i2c-core               20164   0 [w83627hf i2c-proc i2c-amd756 i2c-dev]
> 
> I still have no luck:
> 
>  [bailey@XXX ~]% /usr/local/bin/sensors
>  No sensors found!
> 
> If I add the eeprom chip driver, I get little more:
> 
>  [bailey@XXX ~]% /usr/local/bin/sensors
>  eeprom-i2c-0-50
>  Adapter: SMBus AMD75x adapter at 06e0
>  Algorithm: Non-I2C SMBus adapter
>  Memory type:            DDR SDRAM DIMM SPD
>  Memory size (MB):       512
> 
>  eeprom-i2c-0-51
>  Adapter: SMBus AMD75x adapter at 06e0
>  Algorithm: Non-I2C SMBus adapter
> 
>  [bailey@XXX ~]%
> 
> I'm happy to test changes or provide additional data if that would help.
> 
> -- 
> Regards,
> Charles Bailey  < baileych _at_ mail _dot_ med _dot_ upenn _dot_ edu >
> Fellow, Pediatric Hematology/Oncology
> Children's Hospital of Philadelphia/University of Pennsylvania
> 
