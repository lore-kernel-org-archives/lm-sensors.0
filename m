From: Luca Tettamanti <kronos.it@gmail.com>
Date: Wed, 06 Jul 2011 11:00:22 +0000
Subject: Re: [lm-sensors] Where are all the sensors?
Message-Id: <CAKPcRGp3KOnZh19kfTfYsqtyQSUUJ524PHvBrffCwDxN7JgFFA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4E0B52A6.1070402@yahoo.co.uk>
In-Reply-To: <4E0B52A6.1070402@yahoo.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jul 6, 2011 at 12:30 PM, DB <Freddog_de@yahoo.co.uk> wrote:
> File copy is attached......

Uhm, the quality of that implementation is... below par. I see a lot
of copy&past, there's even this:

Name (VEND, Buffer (0x05)
{
    "ASUS"
})
the BIOS writer definitely did too much copying around ;-)

The good news is that there's accessor for the hwmon chip, the bad
news is that the chip is actually used by the bios itself, it reads
the second voltage (in1) to do some stuff related to ACC.

L

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
