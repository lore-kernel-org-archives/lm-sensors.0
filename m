From: phil@netroedge.com (Philip Edelbrock)
Date: Thu, 19 May 2005 06:23:43 +0000
Subject: about tempX information (fwd)
Message-Id: <3DEE5BF1.8090906@netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3DEA8D23.7080002@fis.ub.edu>
In-Reply-To: <3DEA8D23.7080002@fis.ub.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



The numbers are 'max alarm limit', 'min alarm limit' and 'actual 
reading'.  For more details on this chip, take a look at 
doc/chips/via686a.  Also take a look at the other documention which 
describes how the files in /proc/sys/dev/sensors works.  Normally, 
though, user-space apps will want to access the files using libsensors. 
 Or, if you just want intelligable text output, run 'sensors'.


Phil

>I've installed lm-sensors 2.6.5 and I use i2c-isa and via686a modules.
>
>I get:
>
>S01:/proc# cat /proc/sys/dev/sensors/via686a-isa-6000/temp2
>59.9 55.1 41.3
>S01:/proc# cat /proc/sys/dev/sensors/via686a-isa-6000/temp1
>44.9 39.9 45.3
>S01:/proc# cat /proc/sys/dev/sensors/via686a-isa-6000/temp3
>65.4 59.9 26.4
>
>
>What is the meaning of thins numbers ?
>
>
>
>Thank you
>
>  
>
