From: andywu@iei.com.tw (AndyWu)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: the computer hangs when scans the adapter
Message-Id: <JFEPIKOAGNNHNFFLLGAHKEAJCCAA.andywu@iei.com.tw>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
I'm using a board with ServerWorks OSB4 and a ADM1026 chip.
The computer always hangs here...
Next adapter: SMBus PIIX4 adapter at 0580 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively): YES
I'm using Redhat 7.3 with a generic 2.4.18 kernel, and lm_sensors-2.8.1.
However, if I add something like "print("$addr");" in the sensors-detect scirpt,
it won't hang anymore!
But still no chip detected.
I see no one report this issue on the website.
I'm appreciated if you can give me some help or advices.

Thanks in advance.

Andy


-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031016/07b614d5/attachment.html
