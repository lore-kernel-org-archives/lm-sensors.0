From: Clemens Ladisch <clemens@ladisch.de>
Date: Fri, 16 Aug 2013 09:27:28 +0000
Subject: Re: [lm-sensors] reading on-die temperature sensor of AMD A10 5700 processor
Message-Id: <520DF080.9000200@ladisch.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAFSPGzQyxOOhjawcQj=wH+k1b=OC1gGf6CKWoU89TWVTykNcOQ@mail.gmail.com>
In-Reply-To: <CAFSPGzQyxOOhjawcQj=wH+k1b=OC1gGf6CKWoU89TWVTykNcOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Kapil Dev wrote:
> I think that you are saying that the units of final reported values
> are not deg-C.

Indeed they are not.  The final reported values do not have any unit.

The only known facts about the scale of these temperate values are:
1) Higher values corresponds to higher temperatures; and
2) at a value of 70, a fan designed for TDP must run at 100 %.

> I need to calibrate the camera itself against true temperature.

This is not possible with the CPU sensor.


Regards,
Clemens

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
