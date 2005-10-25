From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 25 Oct 2005 14:48:21 +0000
Subject: [lm-sensors] Patch for 'w83627thf' Chipset add SmartFan control
Message-Id: <d6QUwPJE.1130243801.0579010.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A9A21CEA07B1F4A973CFCD89B9446C90111853C@sermaila.itesoft.local>
In-Reply-To: <4A9A21CEA07B1F4A973CFCD89B9446C90111853C@sermaila.itesoft.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi again Henrique,

On 2005-10-25, Henrique de Moraes Holschuh wrote:
> Here is the LM85 interface (as per 2.6.13.3):

The lm85 interface doesn't follow the standard, so pointing Pascal to it
for the w83627hf is a bad idea. See the standard interface in
Documentation/hwmon/sysfs-interface, and implement that.

> Where # is a number that varies with the number of channels.  Some of
> these entries are RW, others are RO, and some are automatically updated
> if others are changed.

Entries which change automatically depending on the value written to
other entries should always be read-only, so as to avoid confusion and
cycles.

Thanks,
--
Jean Delvare
