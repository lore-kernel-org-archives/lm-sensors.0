From: Jan Richling <jan@richling.de>
Date: Tue, 27 Nov 2007 15:49:15 +0000
Subject: Re: [lm-sensors] please test sensors-detect
Message-Id: <474C3C7B.8080609@richling.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071127125149.7ityxmwoqj88wo0c@ms.trustica.cz>
In-Reply-To: <20071127125149.7ityxmwoqj88wo0c@ms.trustica.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

> Last time I forgot to add the detection of this Celeron CPU to sensors-detect.
> Please would you be so kind and test it with the latest SVN version?
> 
> http://www.lm-sensors.org/browser/lm-sensors/branches/lm-sensors-3.0.0/prog/detect/sensors-detect?format=txt
> 
> Just take this file, download rename, and run.

Works... here is just the relevant output:

Some CPUs or memory controllers may also contain embedded sensors.
Do you want to scan for them? (YES/no):
AMD K8 thermal sensors...                                   No
AMD K10 thermal sensors...                                  No
Intel Core family thermal sensor...                         Success!
    (driver `coretemp')
Intel AMB FB-DIMM thermal sensor...                         No


and

Driver `coretemp' (should be inserted):
  Detects correctly:
  * Chip `Intel Core family thermal sensor' (confidence: 9)


and

#----cut here----
# Chip drivers
modprobe w83627ehf
modprobe coretemp
# sleep 2 # optional
/usr/bin/sensors -s # recommended
#----cut here----

...works as expected.

Thank you again for your great work!

Greetings,

Jan

   ------------------------------------------------------------------
  / Dr. Jan Richling - http://www.richling.de                      /
 / Member of Computer Architecture and Communication Group -      /
/ Department of Computer Science - Humboldt University Berlin    /

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
