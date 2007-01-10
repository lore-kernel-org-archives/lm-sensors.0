From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 10 Jan 2007 17:27:36 +0000
Subject: [lm-sensors] HP PAVILLION dv8000
Message-Id: <20070110182736.c5419d26.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <beb91d720701061533r15ed4803h42d904ecfb0de1b4@mail.gmail.com>
In-Reply-To: <beb91d720701061533r15ed4803h42d904ecfb0de1b4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Salatiel,

On Wed, 10 Jan 2007 14:03:36 -0300, Salatiel Filho wrote:
> Sorry, attached now ...

Next time please make sure your attachement has type text/plain and not
application/octet-stream.

> Coretemp detects cpu temperature but i can not get fan rpm

From the output of sensors-detect, it appears that you do not have any
fan speed monitoring chip on your system. This is quite common on
laptops. What makes you believe that it has such a chip? Do you see
hardware monitoring information in the BIOS, or when using another OS?

Your best chance is probably ACPI here, try loading the "fan" driver
and check under /proc/acpi/fan is anything shows up.

-- 
Jean Delvare

