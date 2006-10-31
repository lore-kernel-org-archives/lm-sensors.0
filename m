From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 31 Oct 2006 08:19:36 +0000
Subject: [lm-sensors] "Built-in" via686a sensors names
Message-Id: <BJpM7Alu.1162282776.1511300.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <4545A129.5000600@comcast.net>
In-Reply-To: <4545A129.5000600@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Ian,

On 10/30/2006, Ian Pilcher wrote:
>The gkrellm package in Fedora Extras 6 has been patched to use
>libsensors.  This causes it to fail to detect the voltage sensors on my
>Abit VP6 motherboard:
>
>[pilcher at home ~]$ gkrellm -d 0x80
>--- GKrellM 2.2.9 ---
>hddtemp_daemon_read: can't connect to 127.0.0.1:7634.
>libsensors error determining type for: via686a at 6000/2.0V
>libsensors error determining type for: via686a at 6000/2.5V
>libsensors error determining type for: via686a at 6000/3.3V
>libsensors error determining type for: via686a at 6000/5.0V
>libsensors error determining type for: via686a at 6000/12V
>libsensors error determining type for: via686a at 6000/alarms
>
>gkrellm expects voltage sensors to to be named "inX", but it is getting
>back the "built-in" names such as "2.0V", etc.  (Built-in names which,
>BTW, are incorrect for my motherboard.)
>
>While I understand the desire to provide meaningful output, this seems
>to be a case where the library is being too clever by half.  Shouldn't
>the library just return the "raw" name (in0, etc.) and let the human-
>readable names be defined in sensors.conf?

libsensors returns the old 2.4 kernel symbol names, which were not
standard. Programs should not make any assumption about these symbol
names, they are arbitrary.

This was admittedly a design error, which is why the names where
standardized in kernel 2.6, but for now applications still go through
the old names in libsensors for compatibility reasons (sensors.conf
references the old names). We hope to have an alternative access method
in lm_sensors 2.11.0, which would solve the problem, but it will only
support 2.6 kernels, and will require a new sensors.conf file.

>Or am I missing something...

This is a bug in Fedora and/or gkrellm. What do you expect from us by
reporting it on the lm_sensors list?

--
Jean Delvare

