From: mikpolniak@adelphia.net (mikepolniak)
Date: Tue, 11 Jul 2006 22:10:21 +0000
Subject: [lm-sensors] it87 driver supports ITE8716 chip on new AM2 boards
Message-Id: <20060711221021.GA5889@debamd64>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060705202045.GA15892@debamd64>
In-Reply-To: <20060705202045.GA15892@debamd64>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 23:45 Tue 11 Jul     , Rudolf Marek wrote:
> Thanks Mike,
> 
> I'm attaching fixed sensors-detect.
> 
> DOes it find the IT8716F on isa and on superIO?

Yes...success!

Do you want to scan the ISA bus? (YES/no): 
Probing for 	TE IT8712F'
  Trying address 0x0290... Failed!
Probing for 	TE IT8716F'
  Trying address 0x0290... Success!
    (confidence 7, driver 	t87')

....................

Do you want to scan for Super I/O sensors? (YES/no): 
Probing for 	TE 8702F Super IO Sensors'
  Failed! (0x8716)
Probing for 	TE 8705F Super IO Sensors'
  Failed! (0x8716)
Probing for 	TE 8712F Super IO Sensors'
  Failed! (0x8716)
Probing for 	TE IT8716F Super IO Sensors'
  Success... found at address 0x0290
.....................
Driver 	t87' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver 	2c-isa')
    Chip 	TE IT8716F Super IO Sensors' (confidence: 9)


I will now generate the commands needed to load the I2C modules.

To make the sensors modules behave correctly, add these lines to
/etc/modules.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----
To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-isa
# I2C chip drivers
modprobe it87
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----

