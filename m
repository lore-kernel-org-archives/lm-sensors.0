From: dieter.jurzitza@t-online.de (Dieter Jurzitza)
Date: Fri, 31 Mar 2006 19:32:38 +0000
Subject: [lm-sensors] Question on my mainboard
Message-Id: <200603312132.38389.dieter.jurzitza@t-online.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200603282150.16130.dieter.jurzitza@t-online.de>
In-Reply-To: <200603282150.16130.dieter.jurzitza@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear listmembers,
I tried to load the 83781d only according to your suggestions, and, yes, 
everything is working like before. The driver detects the sensor chips and 
reads all values from both chips. And, yes, the 83627 is read out even though 
the corresponding module is not loaded. As readily mentioned, the deadlock 
takes a while, so I'll wait and report what is happening.

This, however, leads me to the question why there is a different module for 
the w83781d and the w83627hf at all - if the first can handle both?
Thanks again
take care



Dieter

-- 
-----------------------------------------------------------

                               |
                                \
                 /\_/\           |
                | ~x~ |/-----\   /
                 \   /-       \_/
  ^^__   _        /  _  ____   /
 <??__ \- \_/     |  |/    |  |
  ||  ||         _| _|    _| _|

if you really want to see the pictures above - use some font
with constant spacing like courier! :-)
-----------------------------------------------------------

