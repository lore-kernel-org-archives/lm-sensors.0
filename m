From: "armencho@gmail.com" <armencho@gmail.com>
Date: Sun, 22 Feb 2009 12:43:14 +0000
Subject: [lm-sensors] Intel WiFi Link 4965AGN sysfs interface and
Message-Id: <981b72360902220443k6dc3e8a4gc05a922b5a0ab4b6@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I am new here. Have found the 'temperature' file under the
'/sys/devices/pci0000:00/0000:00:1c.1/0000:03:00.0'.
Files 'vendor' and 'device' cat 0x8086 and 0x4230 respectively, which
indicates the device is Intel 4965AGN wifi card by Intel. Upon
cat'ting the file 'temperature' I get 320. I have no idea how to
translate the number to an understandable value, but I take it to be a
temperature readout indeed. Does anybody have a translation profile
for this device? Given that all sensor chips report internal values, I
take this needs to be translated, but I currently have no capacity to
do a libsensors C interfacing that translates for me (which is
recommended), so I wonder whether a human readable translation
database exists, or if someone can hint me how to translate exactly
this value? It also does not appear to be the same value my Gnome
Sensors applet reports for the MiniPCI slot, where this card is
supposedly inserted (Thinkpad T61 computer), but then again it may be
another sensor altogether.

Thanks,
-amn.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
