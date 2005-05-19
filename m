From: Huang0@Winbond.com.tw (Huang0@Winbond.com.tw)
Date: Thu, 19 May 2005 06:25:46 +0000
Subject: We will port w83792d.c to linux-2.6
Message-Id: <FF9D611BFCDB1E42B37FAA148096BECE2E5494@weshml03.winbond.com.tw>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf:


> I changed error handling of the ali1563 I think it can work this way.
> Please fix error(s) in source if you spot any, you will see the main idea.

I test the driver modified by you, It can work well after I changed it into unix
format by "dos2unix", and changed the line 113:
	if !(timeout) {
into
	if (!timeout) {

> If it is working please can you try to load eeprom modules to probe block
> transfers? I only hope ASUS is not playing hide and seek right now :(
> 
> Just run sensors command or take a look to eeprom content in /sys ...

I loaded the eeprom modules, the 792 driver for linux-2.6 can still work well,
But the eeprom output part of "#sensors" is "Unknown EEPROM type":
[root@ /usr/src/linux]# sensors
eeprom-i2c-0-50
Adapter: SMBus ALi 1563 Adapter @ 5000
Unknown EEPROM type (172)

w83792d-i2c-0-2f
Adapter: SMBus ALi 1563 Adapter @ 5000
VCoreA:    +1.52 V  (min =  +1.20 V, max =  +1.30 V)       ALARM
VCoreB:    +0.54 V  (min =  +1.40 V, max =  +1.60 V)       ALARM
VIN0:      +3.28 V  (min =  +3.20 V, max =  +3.39 V)
VIN1:      +3.16 V  (min =  +3.09 V, max =  +3.30 V)
VIN2:      +2.52 V  (min =  +1.39 V, max =  +1.49 V)       ALARM
VIN3:      +1.26 V  (min =  +2.59 V, max =  +2.64 V)       ALARM
5VCC:      +5.02 V  (min =  +4.73 V, max =  +5.23 V)
5VSB:      +4.99 V  (min =  +4.73 V, max =  +5.23 V)
VBAT:      +3.12 V  (min =  +2.85 V, max =  +3.14 V)
Fan1:     1599 RPM  (min = 2500 RPM, div = 4)              ALARM
Fan2:        0 RPM  (min = 1500 RPM, div = 4)
Fan3:        0 RPM  (min = 1500 RPM, div = 4)
Fan4:        0 RPM  (min = 1500 RPM, div = 4)
Fan5:        0 RPM  (min = 1500 RPM, div = 4)
Fan6:        0 RPM  (min = 1500 RPM, div = 4)
Fan7:       -1 RPM  (min = 1506 RPM, div = 64)              ALARM
Temp1:     +36.0??C  (high =  +8.0??C, hyst =  +7.0??C)   ALARM
Temp2:      -8.0??C  (high = +43.0??C, hyst = +38.0??C)   ALARM
Temp3:     +41.0??C  (high = +45.0??C, hyst = +40.0??C)
chassis:  Chassis is normal.

The content in /sys is:
[root@ /usr/src/linux]# cat /sys/bus/i2c/drivers/eeprom/0-0050/
detach_state  driver/       eeprom        name          power/


Thanks

Best Regards
Chunhao


==============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original author of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such person, please kindly reply the sender indicating accordingly and delete all copies of it from your computer and network server immediately. We thank you for your cooperation. It is advisable that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email that does not relate to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.==============================================If your computer is unable to decode Chinese font, please ignore the following message. They essentially repea!
 t the&nbsp; English statement above.???H???????t?????q?l???]???????K?????T, ?????v???o?H?H???w?????H?H???\????. ?????z???D?Q???w?????H?H???]???????]?b???g???v?????????U???????H??, ???z?i?????o?H?H?????Y?N?H???q?q???P???????A???????H????. ?????z???X?@, ?????????P??. ?S??????, ???????g???v?????????????q?l?????K???T???????O?Q?Y???T????. ?H???P?????q?l???~?L???????e,???o?????????q?l?????????N??.
