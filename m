From: Carren Stuart <kiwionabike@xnet.co.nz>
Date: Sun, 13 Jan 2008 03:58:25 +0000
Subject: [lm-sensors] lmsensors and gkrellm
Message-Id: <200801131658.26068.kiwionabike@xnet.co.nz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi :-)

I'm hoping somebody here can enlighten me.

I'm running OpenSUSE 10.3 on an Acer Travelmate laptop with an Intel Core Duo 
1.6GHz processor.

I finally figured out how to get lmsensors running and configured so that I 
could get my hdd temps showing up in gkrellm.

I'm confused about something though ....

Prior to getting this working GKrellM showed under CPU temp:

thermal_zone/TZ00
thermal_zone/TZ01

with corresponding temps (dual core processor)

Since fixing lmsensors however it now shows two extra entries:

coretemp-hwmon0/temp1
coretemp-hwmon1/temp1

Also with corresponding temp readings.

BUT the readings are not the same. The coretemp readings are several degrees 
lower than the thermal_zone readings, and the two cores are often showing 
different temps, whereas in the thermal_zone readings, the cores are nearly 
always showing the same temp.

I'm assuming the coretemps are what is being detected by lmsensors, so what is 
reading the thermal_zone temps?

Which readings are likely to be the most accurate ones i.e. the ones I should 
take notice of?

EDIT: Just as an example ...

right now the thermal_zone reading is showing temps of 51 and 51. The coretemp 
reading is showing 45 and 41. That's a significant difference when it comes 
to knowing when to be concerned about a particular temp.

If anyone can explain to me what the difference is between the thermal_zone 
readings and the coretemp readings, and which of the two is considered more 
accurate/reliable, I'd appreciate it.

Thanks in advance,

~ Carren

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
