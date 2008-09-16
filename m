From: "Rahul Nabar" <rpnabar@gmail.com>
Date: Tue, 16 Sep 2008 19:29:58 +0000
Subject: [lm-sensors] lm_sensors trouble on AMD Opteron.
Message-Id: <c4d69730809161229o317b804ahf47b3ffc274be2ab@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I've a AMD Opteron Processor on a machine (Quad-Core AMD Opteron
Processor 2354) and wanted to monitor its temperature. I was
reccomended to use lm_sensors but after I tried sensor-detect it keeps
failing (error message below)

Any clues what I am doing wrong?

****************************************************************************
Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `to-be-written' (should be inserted):
  Detects correctly:
  * Chip `AMD K10 thermal sensors' (confidence: 9)

Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no):
Starting lm_sensors: not configured, run sensors-detect[WARNING]
[root@uranus Downloads]# /etc/init.d/lm_sensors start
Starting lm_sensors: not configured, run sensors-detect[WARNING]
***********************************************************************************

-- 
Rahul

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
