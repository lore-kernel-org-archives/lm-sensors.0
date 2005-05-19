From: clauz@punkass.com (Claws)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: Regarding the W83627HF..
Message-Id: <20031222214430.066b3e4d.clauz@punkass.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

After batteling with lm_sensors on a new linux 2.6.0 kernel a couple of hours i realised that my W83627HF wasen't being recognized properly by 'sensors-detect' - It told to modprobe for W83682HF which in the 2.6.x series dosent exist since it has been merged into one driver or something (i don't have programming skills O_o ) namely the:

CONFIG_SENSORS_W83781D:                                                 ___
                     ___ If you say yes here you get support for the Winbond W8378x series       ___
                     ___ of sensor chips: the W83781D, W83782D, W83783S and W83682HF,            ___
                     ___ and the similar Asus AS99127F.  

So when i modprobe'd the W83781D module everything worked Ok.

The lm_sensors i use are pulled from CVS.
 
I hope this helps someone :)

Thanks for some awsome software, and merry x-mas to all :)

