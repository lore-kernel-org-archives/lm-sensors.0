From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 08 Sep 2011 20:21:38 +0000
Subject: Re: [lm-sensors] I2C Combined Transactions in Linux
Message-Id: <20110908222138.3f67230b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAHxUU74ecDvocFpXvhQPdJUndh+FfqU-AfEu0bw2d3+Eim2-MA@mail.gmail.com>
In-Reply-To: <CAHxUU74ecDvocFpXvhQPdJUndh+FfqU-AfEu0bw2d3+Eim2-MA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On Thu, 8 Sep 2011 14:29:34 -0500, Henri C Kjellberg wrote:
> Greetings Friends,
> 
> I am looking for a way to perform combined transactions over I2C in Linux.
> The structure of the message I need to send is as follows. The slave
> responds in the brackets.
> 
> START
> Slave Address, Write
> [ACK]
> Data
> [ACK]
> Data
> [ACK]
> ...
> FEND
> START
> Slave Address, Write
> [Data]
> ACK
> [Data]
> ACK
> ...
> [FEND]
> ACK
> STOP
> (...)

Wrong mailing list. Your question has nothing to do with hardware
monitoring. Please use the linux-i2c [1] list for such questions.

[1] linux-i2c at vger.kernel.org

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
