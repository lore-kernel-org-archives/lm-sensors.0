From: Aike Kristian Terjung <Aike@terjung.net>
Date: Fri, 15 Mar 2013 13:17:36 +0000
Subject: Re: [lm-sensors] Max6650 not working / no sysfs entries
Message-Id: <7A66EC8D-9234-436F-BCB1-1E64828953DA@terjung.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1DE40A3D-6512-40E3-8281-F3F86A9C5432@terjung.net>
In-Reply-To: <1DE40A3D-6512-40E3-8281-F3F86A9C5432@terjung.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

thank you very much, its working now! 

> 1* Don't drop the list from Cc.
> 2* Don't top-post.

ok.

> One common mistake encouraged by some datasheets is to refer to "read
> address" and "write address" for a chip as 8-bit values. What really
> goes on the wire is a 7-bit address followed by a direction bit. So if
> you think your chip uses address 0x90 then odds are that it actually
> uses 0x90 >> 1 = 0x48.

After your explanation i looked at the datasheet again, they mention 0x90 as Hex, but 0101 000 as binary value. I had never seen this without your help ;-)

 thanks

Aike


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
