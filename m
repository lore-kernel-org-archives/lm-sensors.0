From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:30 +0000
Subject: New driver: DS1307 RTC
Message-Id: <3C8030E2.5C26D24C@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <B25E2E5A003CD311B61E00902778AF2A02BBDBB0@SERVER1>
In-Reply-To: <B25E2E5A003CD311B61E00902778AF2A02BBDBB0@SERVER1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

the comment inside the code says it exports to /proc/rtc but
I think it is /dev/rtc.

The 1302 driver came from the kris/ARM people, not us.
If you would like to add i2c-proc support to your 1307 driver
we will consider including it in our package.
Otherwise you may wish to send it to the 1302 people,
or if you have a web page for it we can link to it.

mds



Brian Kuschak wrote:
> 
> Hi, I didn't see a mailing list on your webpage, so I'm just send this
> driver as an attachment.  It's not a sensors driver, but it is for a Dallas
> I2C real-time-clock chip.  Developed and tested on a PowerPC platform, but
> should work on x86 as well.
> 
> Regards,
> Brian
> 
>  <<ds1307.c>>
> 
> 
>                Name: ds1307.c
>    ds1307.c    Type: unspecified type (application/octet-stream)
>            Encoding: quoted-printable
