From: greanie@yahoo.com (Michael Greenish)
Date: Wed, 20 Sep 2006 19:59:26 +0000
Subject: [lm-sensors] asus P5GD2 Premium
Message-Id: <20060920195926.94095.qmail@web60424.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <42C6BFB0.7090900@sh.cvut.cz>
In-Reply-To: <42C6BFB0.7090900@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I build a server based on an Asus but continually got
an overtemperature alert (fan isn't modulating).  I
first submitted a support ticket to this user group a
year ago.  At that time, the drivers for my chipset
were not written. I put the server in the basement
with a fan blowing on it and only on the hottest days
did I get the error.

I'm hoping that with lm-sensors upto 2.10, perhaps the
chipset is supported.  Here is my system:

motherboard: asus P5GD2 Premium
chipsets: Intel? 915P, Intel? ICH6R
distribution: SuSE 9.2
kernel: 2.6.8-24.14-smp
processor: Intel P4 3.0 GHz
Winbond W83627ehf (according to digital-life.com)

The driver for the W83527hf has been written and I
guess that the ehf is just an enhanced version with
additional spi communication.  So I installed new
lm-sensors & ran sensors-detect.  I performed the
suggested actions, ran sensors and still got "No
Sensors Found". 

Hopefully this is operator error.  Any help would be
greatly appreciated so that I can take this server out
of my dusty basement.

Thanks,

Mike Greenish




__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

