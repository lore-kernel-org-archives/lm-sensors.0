From: Romanic Dean <romanicdean@gmail.com>
Date: Mon, 03 Mar 2014 18:58:21 +0000
Subject: [lm-sensors] How values are populated in sysfs enteries in LM73 sensor
Message-Id: <CAAi8uRzZizJk0Kk2zXhySG7zNdW6BwtPWJxhDJ9WnzK5xS0ThQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all

I am going through LM73 sensor implementation and wanted to know
how different entries in sysfs is populated .

I can see max and min temp. values are hard coded in code itself

 #define LM73_TEMP_MIN           (-256000 / 250)
#define LM73_TEMP_MAX           (255750 / 250)

But what about the current temp. values ,how it is populated?

Is it read from EEPROM and then populated into sysfs entry temp_input1?

Can anyone let me know these values are populated and what is role of
EEPROM here?

Thanks,
Romanic
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
