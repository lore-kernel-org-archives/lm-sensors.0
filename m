From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 29 Nov 2007 22:35:45 +0000
Subject: [lm-sensors] [PATCH 0/4] adm1026 updates
Message-Id: <20071129233545.2a15fb0f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Here comes a 4-piece patchset updating the adm1026 driver:
* Implement individual alarm files for the new libsensors.
* Whitespace cleanups.
* Other cleanups.
* temp3 and in8+in9 are mutually exclusive.

Stefano, Philip, I would appreciate if you could test these patches. I
would also appreciate if someone could send me a dump of an ADM1026
chip so that I can add it to my collection.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
