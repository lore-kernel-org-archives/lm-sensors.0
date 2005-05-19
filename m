From: ulysses_93674@hotmail.com (AB)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: lm_sensors problem/ITE8712 chip
Message-Id: <BAY99-DAV18a0fIQTrM00000f43@hotmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I'm hoping that you can help me. Recently I have installed SuSE 8.2 which
comes with lm_sensors 2.7.0 (though my question is probably not version
specific). I'm trying to get it to function on my Gigabyte GA8PE667 Ulta 2
board which uses the ITE 8712F sensor chip. The problem is that when I try
to use the program the temperatures are clearly way off. Now, I know it's
not because of the sensor type as I've tried changing them as per the
instructions and each result is clearly incorrect, I believe that the issue
is the same as the one with Motherboard Monitor, namely that if the sensor
chip is reset on program start then the readings are in the 70C region. With
MBM I would select the "Do not reset sensorchip" box, however, I'm not sure
how to do this with lm_sensors. I realise the answer to this is probably
contained within your documentation, however, as I'm new to Linux and
lm_sensors I'm not quite sure what to look for. Any help you could provide
would be greatly appreciated.

Thank You
AB
