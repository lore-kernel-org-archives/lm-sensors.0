From: ulysses_93674@hotmail.com (AB)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: lm_sensors problem/ITE8712 chip --FOLLOW UP PRIOR TO REPLY--
Message-Id: <BAY99-DAV14aRM4vNQX00000f5d@hotmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Firstly I wanted to let you know that I solved the problem by editing the
sensors.conf file. It appears that it wasn't the same problem as with MBM,
and I needed to adjust some sensor values. I apologise if I have wasted any
of your time, all too often I ask for help and then manage to get up the
courage to try and fix it myself. Anyway, thanks to all involved for making
these tools as not only are they useful on the surface, but they encouraged
me to learn more about how they work.

Yours Sincerely
AB

----- Original Message ----- 
From: "AB" <ulysses_93674@hotmail.com>
To: <sensors@stimpy.netroedge.com>
Sent: Thursday, October 16, 2003 3:57 PM
Subject: lm_sensors problem/ITE8712 chip


> Hello,
>
> I'm hoping that you can help me. Recently I have installed SuSE 8.2 which
> comes with lm_sensors 2.7.0 (though my question is probably not version
> specific). I'm trying to get it to function on my Gigabyte GA8PE667 Ulta 2
> board which uses the ITE 8712F sensor chip. The problem is that when I try
> to use the program the temperatures are clearly way off. Now, I know it's
> not because of the sensor type as I've tried changing them as per the
> instructions and each result is clearly incorrect, I believe that the
issue
> is the same as the one with Motherboard Monitor, namely that if the sensor
> chip is reset on program start then the readings are in the 70C region.
With
> MBM I would select the "Do not reset sensorchip" box, however, I'm not
sure
> how to do this with lm_sensors. I realise the answer to this is probably
> contained within your documentation, however, as I'm new to Linux and
> lm_sensors I'm not quite sure what to look for. Any help you could provide
> would be greatly appreciated.
>
> Thank You
> AB
>
>
