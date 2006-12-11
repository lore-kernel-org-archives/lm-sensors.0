From: david@ad5ey.net (David Holl)
Date: Mon, 11 Dec 2006 17:41:18 +0000
Subject: [lm-sensors] Asus P5B Deluxe WiFi AP Sensors
Message-Id: <6b59d5890612110941u1af4acdfjf3ceab4bc8b33fdb@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060822145643.GA5632@seahunt.dyndns.org>
In-Reply-To: <20060822145643.GA5632@seahunt.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>
> Hi David,
>
> Here are some things you could do (pick any that appeal to you):
> - Subscribe to the lm-sensors list (
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors)


Already done.  :)

- What hardware monitoring chip do you have on your motherboard?


W83627DHG / ICH8 -- I have the same P5B+WiFi board that's discussed in this
post:
http://lists.lm-sensors.org/pipermail/lm-sensors/2006-August/017332.html

If you have a 627ehf/ehg/dhg jump in with testing the new driver -- and
> there are some bugs I could point you to, also. Or if you have another chip,
> I'm sure it needs development too.


I could try my hand with some 627DHG bugs.  So what's the best way to
start?  Install 2.6.19 w/ the patch you just sent the other day?
(w83627ehf_add_w83627dhg_support.patch) ?  I also switched up to lm-sensors
v2.10.1.

Do you want to work in the linux kernel?
> - The lm-sensors project also has work, which I'm sure Jean Delvare and
> Rudolf Marek could tell you more about.


I'll work wherever you guys would need me too.  (I'm only finishing my
dissertation now anyways...)

David
>

- David
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061211/0820ee29/attachment.html 
