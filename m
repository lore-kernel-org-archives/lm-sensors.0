From: dieter.jurzitza@t-online.de (Dieter Jurzitza)
Date: Fri, 19 May 2006 16:34:22 +0000
Subject: [lm-sensors] i2c-amd756.c - again, some thoughts
Message-Id: <200605191834.22564.dieter.jurzitza@t-online.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi folks,
only to make sure: it is *only* bit 13 and bit 3 in the return value showing 
in temp that could provide a reason to wait? I am referring to the line (row 
112, i2c-amd756.c):

if ((temp = inw_p(SMB_GLOBAL_STATUS)) & (GS_HST_STS | GS_SMB_STS)) {
}

No other status worth making a pause for?
Just guessing ...
Take care



Dieter Jurzitza

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

