From: ejl@eberian.com (Ed Lucas)
Date: Mon, 26 Mar 2007 22:33:40 +0000
Subject: [lm-sensors] Motherboard-specific configurations (sensors4mobo)
Message-Id: <46084A44.4070101@eberian.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear Lm-sensors team,
    Back in 2005 the company I was working for needed consistent access 
to sensor data from a range of motherboards (we were building 
Managed-NAS systems), so we created motherboard-specific sensors.conf 
files and a tool to install and query them. I have now been given 
permission to update and release this software under the GPL.

I have placed it all online at:
    http://sensors4mobo.eberian.com

Online Query Tool:
    http://sensors4mobo.eberian.com/lookup/

Sample sensors.conf file:
    http://sensors4mobo.eberian.com/lookup/mobolibrary/EPIA.conf


We aimed to tackle the following:

* We were very happy with lm-sensors itself, but we found the output of 
"/usr/bin/sensors" hard to parse reliably because of the variable labels 
and fixed-width formatting. Instead, we now take the raw 
"/usr/bin/sensors -u" output and massage it into a consistent CSV format 
with extra data from an overlay file.

* We needed an automated install for our systems. Understandably, 
sensors-detect won't do this because it could kill the motherboard. We 
felt it would be cleaner to work top-down using the output from 
dmidecode to identify the motherboard and use a script to automatically 
pick the matching sensors.conf file. We achieved this by adding keywords 
and parameters in the comments within the sensors.conf files which this 
script detects and uses to match against the dmidecode output.  The 
keywords allow the correct matching to the appropriate sensors.conf file 
and can also include modprobe information to be added to /etc/modules.  
An example of this is shown in the EPIA.conf file referenced above. 

* We wanted to standardise the terms used, so that it would be easier to 
grep/understand what each sensor was being used to report. Initially, we 
used a custom (and somewhat arcane) labelling convention that embedded 
the type of sensor (fan,temperature,voltage) and the role in the label. 
This has been replaced with a script that massages the output of 
"sensors -u" and allows us to add extra overlay information. Through the 
overlay we can add a (fixed) set of tags to describe the function of the 
sensor - these can then be set on a case-by-case basis as well as a 
human-readable comment field.


Overall, the idea of sensors4mobo is to act as an overlay to 
sensors/dmidecode to add motherboard/installation-specific information 
that is outside the current scope of the lm-sensors project.  It also 
allows a motherboard to be matched against an exact sensors.conf file 
and removes the potential for error when a sensor chip may be used in 
different ways on different motherboards (e.g. it may have a different 
external resistor divider network).

Is this of interest to anyone on the list? and do you have any 
questions/suggestions?

If you have any motherboard-specific sensors.conf files that you would 
like to add, please just send them to me along with either the output of 
"sensors4mobo_lookup --dump" or dmidecode and I will get on it.

Since developing this, I have become aware of the sconfig tool created 
during Google SoC 2006. It is interesting and I hope that we can find 
some common ground around the sensors.conf files themselves, but I think 
the two projects are sufficiently different in style and goal to merit 
their existence.

Thanks and best wishes,
    Ed Lucas



