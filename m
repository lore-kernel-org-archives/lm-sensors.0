From: 2crazy4you@gmx.de (slompf)
Date: Mon, 01 Jan 2007 11:03:50 +0000
Subject: [lm-sensors] w83627ehf informations
Message-Id: <4598EA96.7000907@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1163284779.5555.34.camel@armageddon>
In-Reply-To: <1163284779.5555.34.camel@armageddon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

the patch does work. Though, the script still finds no correlations on 
my board.

Torsten


> On Sun, 19 Nov 2006 16:51:33 +0100, torsten goroll wrote:
>   
>> thanks for your answer. The version of the bash is 3.1.
>> I didn't modify it and compiled lm-sensors from the current
>> sources.
>>     
>
> Ok, it appears to be a new feature of bash 3.1: it displays an error
> message when a write (echo) to a file returns an error. Previous
> versions of bash didn't. So we need to hide the error in pwmconfig (and
> fancontrol). And while we're at it, we could handle that error
> properly, as it seems we weren't so far.
>
> Patch is attached, I can't test it right now, so testers are wanted and
> feedback is welcome. If the patch works OK, I'll apply it before we
> release lm_sensors 2.10.2.
>   

-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070101/f54b7df0/attachment.html 
