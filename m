From: mark.syms@eu.citrix.com (Mark Syms)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: Addition to IBM whitelist
Message-Id: <1082027302.6117.9.camel@viper.cam.eu.citrix.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I would like to get my IBM machine added to the whitelist. It is an
Intellistation M-Pro tower (model 6868-6BG), the BIOS is PLKT44AUK.
Sensors were working on this machine before the IBM blacklist came in
and I have verified it using kernel 2.6.5.

Sensors-detect came back with the following :-
 
---------------------------------------------------------------
To make the sensors modules behave correctly, add these lines to
/etc/modules:
 
#----cut here----
# I2C adapter drivers
i2c-i801
i2c-isa
# I2C chip drivers
adm1025
eeprom
smsc47m1
#----cut here----
 
Then, run /etc/init.d/modutils
 
 
To make the sensors modules behave correctly, add these lines to
/etc/modutils/local and run update-modules:
 
#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

------------------------------------------------------------------

Regards,

	Mark Syms
