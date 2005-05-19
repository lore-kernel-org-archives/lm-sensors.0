From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: sensors.conf: explain how to enable/disable beeps
Message-Id: <40A021BD.6010804@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040509222513.GA20557@pc.aurel32.lan>
In-Reply-To: <20040509222513.GA20557@pc.aurel32.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[grin]  I've been there and done that as well...

Looks great!
:v)

Aurelien Jarno wrote:

>On Mon, May 10, 2004 at 10:14:44AM -0700, Philip Pokorny wrote:
>  
>
>>That's great, but I think you missed one:
>>
>>@@ -312,6 +325,8 @@
>># the CPU temperature.
>>#    label temp "M/B Temp"
>>
>>+# Uncomment the following line to enable all beeping globally
>>+#    set beep_enable 1
>>
>>chip "lm75-*"
>>    
>>
>
>That's because I am the specialist of broken patches or patches with
>problems... In almost all cases, I need to send a patch three times
>until it is correct :-)
>
>New patch attached, hope this time it will be ok.
>
>
>  
>
>------------------------------------------------------------------------
>
>diff -urN lm_sensors2.orig/etc/sensors.conf.eg lm_sensors2/etc/sensors.conf.eg
>--- lm_sensors2.orig/etc/sensors.conf.eg	2004-05-11 02:12:44.000000000 +0200
>+++ lm_sensors2/etc/sensors.conf.eg	2004-05-11 02:12:36.000000000 +0200
>@@ -221,6 +221,19 @@
> # yet supported; spaces at the end are ignored, though.
> #
> #
>+# BEEPS
>+# -----
>+# Some chips support alarms with beep warnings. When an alarm is triggered
>+# you can be warned by a beeping signal through your computer speaker. It
>+# is possible to enable beeps for all alarms on a chip using the following 
>+# line:
>+#
>+# 	set beep_enable 1
>+#
>+# or disable them using:
>+#
>+# 	set beep_enable 0
>+#
> ##########################################################################
> #### Here begins the real configuration file
> 
>@@ -312,6 +325,9 @@
> # the CPU temperature.
> #    label temp "M/B Temp"
> 
>+# Uncomment the following line to enable beeps for all alarms on this chip
>+#    set beep_enable 1
>+
> 
> chip "lm75-*"
> 
>  
>

-- 
Philip Pokorny, Director of Engineering
Tel: 415-954-2823   Fax: 415-954-2899   Toll Free: 888-PENGUIN
PENGUIN COMPUTING, INC.
www.penguincomputing.com

