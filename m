From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 30 Nov 2009 22:03:37 +0000
Subject: Re: [lm-sensors] ADT7490 support
Message-Id: <20091130230337.7894d0ba@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <64c68f1f0910261310y7a04f31du290bd6ff10dc0c1a@mail.gmail.com>
In-Reply-To: <64c68f1f0910261310y7a04f31du290bd6ff10dc0c1a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 30 Nov 2009 06:36:51 -0500 (EST), Justin Piszcz wrote:
> The one that shows the temperatures and fan speeds is labeled:
> intel-p55kg-system-setup-realtime-hardware-monitoring.jpg

This seems to match the output of "sensors" except for the missing
thermal margin value. It certainly comes from the PECI input, for which
we have no support.

> > The above output suggests that temp1 isn't used on your system, temp2 is
> > internal to the ADT7490 so it would be the motherboard temperature,
> > while temp3 would likely be the CPU temperature. Does the BIOS report
> > more than 2 temperature values?
> Yes but the top one is the thermal margin, so you are correct, the first
> temperature for this board needs to be disabled so lm-sensors does not look
> for it, see: intel-p55kg-system-setup-realtime-hardware-monitoring.jpg

This isn't the driver's job, as it can't tell the difference between a
permanently unused input and an actual sensor breakage. If you want to
hide temp1, just add the following to your sensors3.conf's adt7475
section:

    ignore temp1

As for the thermal margin, we lack support for this in libsensors at
the moment. How this could be implemented is still under discussion.
Until it settles, I can't add support to the adt7475 driver.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
