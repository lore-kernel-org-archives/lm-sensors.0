From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 02 Mar 2009 08:40:01 +0000
Subject: Re: [lm-sensors] Intel WiFi Link 4965AGN sysfs interface and
Message-Id: <20090302094001.6dd88f98@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 22 Feb 2009 13:43:14 +0100, armencho@gmail.com wrote:
> I am new here. Have found the 'temperature' file under the
> '/sys/devices/pci0000:00/0000:00:1c.1/0000:03:00.0'.
> Files 'vendor' and 'device' cat 0x8086 and 0x4230 respectively, which
> indicates the device is Intel 4965AGN wifi card by Intel. Upon
> cat'ting the file 'temperature' I get 320. I have no idea how to
> translate the number to an understandable value, but I take it to be a
> temperature readout indeed. Does anybody have a translation profile
> for this device?

According to the code these are degrees Kelvin. 320 - 273 = 47 degrees
Celsius. A pretty inconvenient unit, if you ask me.

> Given that all sensor chips report internal values, I
> take this needs to be translated, but I currently have no capacity to
> do a libsensors C interfacing that translates for me (which is
> recommended), so I wonder whether a human readable translation
> database exists, or if someone can hint me how to translate exactly
> this value?

Documentation/hwmon/sysfs-interface says that temperature values should
be exported in millidegrees Celsius, which the iwlwifi drivers doesn't
do. If the temperature in question is one that is worth monitoring, the
iwlwifi driver should be updated to comply with the hwmon standard.

> It also does not appear to be the same value my Gnome
> Sensors applet reports for the MiniPCI slot, where this card is
> supposedly inserted (Thinkpad T61 computer), but then again it may be
> another sensor altogether.

If the iwlwifi driver maintainer cares about integration of the driver
into hardware monitoring application, he/she should:
* Have the iwlwifi driver register a hwmon class device, by means of
  hwmon_device_unregister().
* Create there a name attribute returning "iwlwifi" or something
  similar.
* Create there a temp1_input attribute returning the temperature value
  in millidegrees Celsius.

This should be very easy to implement. This however is only worth doing
if the temperature in question is one which is updated frequently. This
should be verified with the iwlwifi driver maintainer first.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
