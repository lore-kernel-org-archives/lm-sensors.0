From: reuben-lmsensors@reub.net (Reuben Farrelly)
Date: Sat, 26 Nov 2005 14:11:36 +0000
Subject: [lm-sensors] Analogue Devices ADT7476ARQZ chip status
Message-Id: <43885EEC.5000509@reub.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4387E587.20302@reub.net>
In-Reply-To: <4387E587.20302@reub.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On 11/27/2005 12:59 AM, Jean Delvare wrote:
> Hi Reuben,
> 
>>> Please provide a dump of the Analog Devices chip:
>>> i2cdump 0 0x2e b
>> [root@typhoon ~]# i2cdump 0 0x2e b
>> (...)
>>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
>> 00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
>> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
>> 20: 77 6c c3 c5 be 36 29 27 62 0c 57 0d 46 36 ff ff    wl???6)'b?W?F6..
>> 30: 33 4c 4c 00 00 00 00 00 ff ff ff 00 00 76 41 69    3LL..........vAi
> 
> This matches what the ADT7476 datasheet says. I've added support in
> sensors-detect (in CVS). Please test if possible.

sensors-detect in CVS works great:

Probing for `SMSC EMC6D100, EMC6D101 or EMC6D102'... Failed!
Probing for `Analog Devices ADT7467 or ADT7468'... Failed!
Probing for `Analog Devices ADT7476'... Success!
     (confidence 7, driver `to-be-written')
Probing for `National Semiconductor LM87'... Failed!

and of course finishes up with:

#----cut here----
# I2C adapter drivers
modprobe i2c-i801
# I2C chip drivers
# no driver for Analog Devices ADT7476 yet
modprobe eeprom
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----

This is good.  At least from an end user perspective now it looks like it is 
known to the system even if a driver hasn't yet been written.

Thank for the quick response :)

Reuben
