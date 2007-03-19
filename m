From: juergh@gmail.com (Juerg Haefliger)
Date: Mon, 19 Mar 2007 05:30:38 +0000
Subject: [lm-sensors] Failure to Detect VT1211 chip on Averatec 3150P
Message-Id: <191fb4ca0703182230h6b04eb21x2f06ec1d3500510@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1174094059.45fb40eb08206@webmail.mail.gatech.edu>
In-Reply-To: <1174094059.45fb40eb08206@webmail.mail.gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Brad,

Make sure hwmon-vid is loaded before you modprobe the vt1211 driver.
Also, could you post the output of lspci and the tail of
/var/log/syslog after modprobing the driver?

...juerg


> When I try to modprobe vt1211, I get the error:
>
> Fatal: Error inserting vt1211
> (/lib/modules/2.6.20-supend2-r1/kernel/drivers/hwmon/vt1211.ko): No such device
>
> I noticed that there was a post similar to this about the driver not checking
> all the appropriate addresses, so I also edited the driver to check the location
> 0x4e as noted in the mailing list, but even after recompiling, I got the same
> result.  Sorry for the delay and thanks again.
>
> --
> Brad R. Beglin
>

