From: i.pilcher@comcast.net (Ian Pilcher)
Date: Mon, 30 Oct 2006 06:52:25 +0000
Subject: [lm-sensors] "Built-in" via686a sensors names
Message-Id: <4545A129.5000600@comcast.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The gkrellm package in Fedora Extras 6 has been patched to use
libsensors.  This causes it to fail to detect the voltage sensors on my
Abit VP6 motherboard:

[pilcher at home ~]$ gkrellm -d 0x80
--- GKrellM 2.2.9 ---
hddtemp_daemon_read: can't connect to 127.0.0.1:7634.
libsensors error determining type for: via686a at 6000/2.0V
libsensors error determining type for: via686a at 6000/2.5V
libsensors error determining type for: via686a at 6000/3.3V
libsensors error determining type for: via686a at 6000/5.0V
libsensors error determining type for: via686a at 6000/12V
libsensors error determining type for: via686a at 6000/alarms

gkrellm expects voltage sensors to to be named "inX", but it is getting
back the "built-in" names such as "2.0V", etc.  (Built-in names which,
BTW, are incorrect for my motherboard.)

While I understand the desire to provide meaningful output, this seems
to be a case where the library is being too clever by half.  Shouldn't
the library just return the "raw" name (in0, etc.) and let the human-
readable names be defined in sensors.conf?

Or am I missing something...

Thanks!

-- 
====================================
Ian Pilcher                                        i.pilcher at comcast.net
====================================

