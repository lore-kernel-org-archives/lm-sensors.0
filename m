From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: LM90 compatibles
Message-Id: <3F51183B.8090808@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F50D95D.3050507@paradyne.com>
In-Reply-To: <3F50D95D.3050507@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

the problem of course with using die codes for detection is that many mfrs treat it as an internal
code that can change without notice. I see in the driver you allow a range for lm90 which is good.

Jean Delvare wrote:

> BTW, these three chips have no known die revision codes, which makes
> their detection possibly unreliable. I've sent a support request on
> Maxim's website but admit not to expect too much from it. I also mailed
> Mary Burke at Analog Devices, maybe she'll be able to provide the
> revision code values for the ADM1032.
