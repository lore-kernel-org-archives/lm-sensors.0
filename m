From: fabien.pourias@thales-is.com (fabien.pourias)
Date: Tue, 21 Jun 2005 11:20:22 +0000
Subject: [lm-sensors] RE: w83792d driver for the 2.6 kernel
Message-Id: <42AA952B@mailmlk.tisfr.thales>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE5E7741@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE5E7741@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>=== Original Message From "Jean Delvare" <khali@linux-fr.org> ==>Hi Fabien,
>
>> Thanks a lot for the patch. It works pretty well (i.e. we see meaningful
>> values when we run sensors -u) but the user tools are not up to date :
>>  - sensors-detect fails to detect the w83792d
>>  - the "sensors" output only includes the old w83627hf data
>
>Did you update the lm_sensors user-space tools as Rudolf Marek
>recommended? Support for the W83792D is in CVS only.

I used the daily snapshot as recommanded by Rudolf and had to :
 - copy the etc/sensors.conf.eg to /etc/sensors.conf
 - run the sensors-detect from the lm_sensors distribution (the make 
user_install command did not install it)
 - run /usr/local/bin/sensors to make sure I did not run the Fedora version of 
sensors.

I also removed the Fedora version but the sensors-detect script still failed 
to detect the 83792d. Could it be because it is not properly installed ? What 
commands should I issue in addition to "make user; make user_install" ?

   thanks for your help,

    F.  Pourias


