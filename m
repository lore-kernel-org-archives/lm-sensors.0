From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: sensors.conf: explain how to enable/disable beeps
Message-Id: <409FB884.70305@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040509222513.GA20557@pc.aurel32.lan>
In-Reply-To: <20040509222513.GA20557@pc.aurel32.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

That's great, but I think you missed one:

@@ -312,6 +325,8 @@
 # the CPU temperature.
 #    label temp "M/B Temp"
 
+# Uncomment the following line to enable all beeping globally
+#    set beep_enable 1
 
 chip "lm75-*"



Aurelien Jarno wrote:

>On Sun, May 09, 2004 at 05:16:23PM -0700, Philip Pokorny wrote:
>  
>
>>I'd suggest you not use the term "globally" as that implies (to *me* 
>>anyway) that it applies to all chips in the system, when in fact it only 
>>applies to the chip in which it appears.
>>    
>>
>You're right. I didn't think to the fact that this file is the same for
>all chips when writing this comment.
>
>I fixed it using your suggestion, please find a new patch attached.
>
>
>  
>

-- 
Philip Pokorny, Director of Engineering
Tel: 415-954-2823   Fax: 415-954-2899   Toll Free: 888-PENGUIN
PENGUIN COMPUTING, INC.
www.penguincomputing.com

