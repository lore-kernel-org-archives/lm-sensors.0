From: Jean Delvare <jdelvare@suse.de>
Date: Tue, 24 Feb 2015 12:09:28 +0000
Subject: Re: [lm-sensors] IT8620E working with it87 driver
Message-Id: <20150224130928.72823130@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAMqk1ZyC2w7JnJ7xyDPwCvXkHQjwkPmG_LhyC8_doavpeXHXyA@mail.gmail.com>
In-Reply-To: <CAMqk1ZyC2w7JnJ7xyDPwCvXkHQjwkPmG_LhyC8_doavpeXHXyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ash,

Sorry for the late reply.

On Tue, 6 May 2014 22:06:34 +0800, Ash Wiren wrote:
> > (2014-03-16) One request (Kertesz Laszlo). No datasheet. We had a report that the chip is somewhat compatible with the IT8728F for the hardware monitoring part. Be very careful with fan control as it wasn't tested. So you can try loading the it87 driver with force_id=0x8728 and see how it goes. If you do, please report!
> 
> Reporting this as working.

Thanks for the report. Can you please share the actual output of
"sensors" with us?

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
